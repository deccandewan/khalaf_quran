package com.abuhashim.khalafquran

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.os.Bundle
import android.util.TypedValue
import android.widget.RemoteViews
import android.app.AlarmManager
import android.app.PendingIntent
import android.content.Intent
import android.Manifest
import android.content.pm.PackageManager
import androidx.core.content.ContextCompat
import android.location.LocationManager
import com.abuhashim.khalafquran.R
import com.github.msarhan.ummalqura.calendar.UmmalquraCalendar
import kotlinx.coroutines.*
import org.json.JSONObject
import java.net.URL
import java.text.SimpleDateFormat
import java.util.*

open class QuranWidgetProvider : AppWidgetProvider() {

    companion object {
        private const val PREFS_NAME              = "QuranWidgetCache"
        private const val DATE_FORMAT             = "yyyy-MM-dd"
        private const val REQUEST_CODE_PRAYER_ALARM   = 9001
        private const val REQUEST_CODE_COUNTDOWN_ALARM = 9002
        private const val REQUEST_CODE_SECOND_ALARM    = 9003
        private const val SECONDS_THRESHOLD_MS         = 60 * 1000L  // show seconds below 1 min

        /**
         * Schedule an exact alarm to fire exactly at [nextPrayerTime] so the widget
         * refreshes the moment the prayer begins and the countdown/highlight flip instantly.
         * Uses FLAG_UPDATE_CURRENT so only one alarm is ever queued at a time.
         */
        fun scheduleNextPrayerAlarm(context: Context, nextPrayerTime: String, appWidgetIds: IntArray) {
            try {
                val parts = nextPrayerTime.trim().split(":")
                if (parts.size < 2) return

                val fireAt = Calendar.getInstance().apply {
                    set(Calendar.HOUR_OF_DAY, parts[0].toInt())
                    set(Calendar.MINUTE,      parts[1].toInt())
                    set(Calendar.SECOND,      0)
                    set(Calendar.MILLISECOND, 0)
                    // if the prayer time has already passed today, aim for tomorrow
                    if (timeInMillis <= System.currentTimeMillis()) {
                        add(Calendar.DAY_OF_MONTH, 1)
                    }
                }

                val intent = Intent(context, QuranWidgetProvider::class.java).apply {
                    action = AppWidgetManager.ACTION_APPWIDGET_UPDATE
                    putExtra(AppWidgetManager.EXTRA_APPWIDGET_IDS, appWidgetIds)
                }
                val pi = PendingIntent.getBroadcast(
                    context, REQUEST_CODE_PRAYER_ALARM, intent,
                    PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
                )
                val am = context.getSystemService(Context.ALARM_SERVICE) as AlarmManager
                am.setExactAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, fireAt.timeInMillis, pi)
                android.util.Log.d("QuranWidget", "Prayer alarm set for ${fireAt.time}")
            } catch (e: Exception) {
                android.util.Log.e("QuranWidget", "Error scheduling prayer alarm", e)
            }
        }

        /** Cancel any pending prayer alarm — called when all widget instances are removed. */
        fun cancelPrayerAlarm(context: Context) {
            try {
                val intent = Intent(context, QuranWidgetProvider::class.java).apply {
                    action = AppWidgetManager.ACTION_APPWIDGET_UPDATE
                }
                val pi = PendingIntent.getBroadcast(
                    context, REQUEST_CODE_PRAYER_ALARM, intent,
                    PendingIntent.FLAG_NO_CREATE or PendingIntent.FLAG_IMMUTABLE
                )
                if (pi != null) {
                    val am = context.getSystemService(Context.ALARM_SERVICE) as AlarmManager
                    am.cancel(pi)
                    pi.cancel()
                    android.util.Log.d("QuranWidget", "Prayer alarm cancelled")
                }
            } catch (e: Exception) {
                android.util.Log.e("QuranWidget", "Error cancelling prayer alarm", e)
            }
        }

        /**
         * Schedule an alarm to fire 60 seconds before [nextPrayerTime] so the widget
         * wakes up so the widget starts per-second redraws at the 10-minute mark.
         */
        fun scheduleCountdownAlarm(context: Context, nextPrayerTime: String, appWidgetIds: IntArray) {
            try {
                val parts = nextPrayerTime.trim().split(":")
                if (parts.size < 2) return
                val fireAt = Calendar.getInstance().apply {
                    set(Calendar.HOUR_OF_DAY, parts[0].toInt())
                    set(Calendar.MINUTE,      parts[1].toInt())
                    set(Calendar.SECOND,      0)
                    set(Calendar.MILLISECOND, 0)
                    if (timeInMillis <= System.currentTimeMillis()) add(Calendar.DAY_OF_MONTH, 1)
                    add(Calendar.SECOND, -60) // wake up 60s before prayer to start per-second ticking
                }
                if (fireAt.timeInMillis <= System.currentTimeMillis()) return
                val intent = Intent(context, QuranWidgetProvider::class.java).apply {
                    action = AppWidgetManager.ACTION_APPWIDGET_UPDATE
                    putExtra(AppWidgetManager.EXTRA_APPWIDGET_IDS, appWidgetIds)
                }
                val pi = PendingIntent.getBroadcast(
                    context, REQUEST_CODE_COUNTDOWN_ALARM, intent,
                    PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
                )
                (context.getSystemService(Context.ALARM_SERVICE) as AlarmManager)
                    .setExactAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, fireAt.timeInMillis, pi)
                android.util.Log.d("QuranWidget", "Countdown alarm set for \${fireAt.time}")
            } catch (e: Exception) {
                android.util.Log.e("QuranWidget", "Error scheduling countdown alarm", e)
            }
        }

        fun cancelCountdownAlarm(context: Context) {
            try {
                val intent = Intent(context, QuranWidgetProvider::class.java).apply {
                    action = AppWidgetManager.ACTION_APPWIDGET_UPDATE
                }
                val pi = PendingIntent.getBroadcast(
                    context, REQUEST_CODE_COUNTDOWN_ALARM, intent,
                    PendingIntent.FLAG_NO_CREATE or PendingIntent.FLAG_IMMUTABLE
                )
                if (pi != null) {
                    (context.getSystemService(Context.ALARM_SERVICE) as AlarmManager).cancel(pi)
                    pi.cancel()
                }
            } catch (e: Exception) {
                android.util.Log.e("QuranWidget", "Error cancelling countdown alarm", e)
            }
        }

        /**
         * Schedule a one-shot alarm 1 second from now so the widget redraws the
         * live seconds countdown. Called on every onUpdate while inside the
         * SECONDS_THRESHOLD_MS window; self-perpetuating until the prayer fires.
         */
        fun scheduleSecondAlarm(context: Context, appWidgetIds: IntArray) {
            try {
                val intent = Intent(context, QuranWidgetProvider::class.java).apply {
                    action = AppWidgetManager.ACTION_APPWIDGET_UPDATE
                    putExtra(AppWidgetManager.EXTRA_APPWIDGET_IDS, appWidgetIds)
                }
                val pi = PendingIntent.getBroadcast(
                    context, REQUEST_CODE_SECOND_ALARM, intent,
                    PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
                )
                val am = context.getSystemService(Context.ALARM_SERVICE) as AlarmManager
                am.setExactAndAllowWhileIdle(
                    AlarmManager.RTC_WAKEUP,
                    System.currentTimeMillis() + 1_000L,
                    pi
                )
            } catch (e: Exception) {
                android.util.Log.e("QuranWidget", "Error scheduling second alarm", e)
            }
        }

        fun cancelSecondAlarm(context: Context) {
            try {
                val intent = Intent(context, QuranWidgetProvider::class.java).apply {
                    action = AppWidgetManager.ACTION_APPWIDGET_UPDATE
                }
                val pi = PendingIntent.getBroadcast(
                    context, REQUEST_CODE_SECOND_ALARM, intent,
                    PendingIntent.FLAG_NO_CREATE or PendingIntent.FLAG_IMMUTABLE
                )
                if (pi != null) {
                    (context.getSystemService(Context.ALARM_SERVICE) as AlarmManager).cancel(pi)
                    pi.cancel()
                }
            } catch (e: Exception) {
                android.util.Log.e("QuranWidget", "Error cancelling second alarm", e)
            }
        }

                /** Returns today's date string used as cache key prefix */
        private fun todayKey(): String =
            SimpleDateFormat(DATE_FORMAT, Locale.US).format(Date())

        /** Returns a date string N days from today */
        private fun dateKey(daysFromToday: Int): String {
            val cal = Calendar.getInstance()
            cal.add(Calendar.DAY_OF_MONTH, daysFromToday)
            return SimpleDateFormat(DATE_FORMAT, Locale.US).format(cal.time)
        }

        /** Cache key for a given date string */
        private fun cacheKey(date: String) = "prayers_$date"

        /** Save prayer times for a specific date */
        fun savePrayerTimes(context: Context, date: String, prayers: Map<String, String>,
                            sunrise: String, sunset: String) {
            val json = JSONObject().apply {
                prayers.forEach { (k, v) -> put(k, v) }
                put("Sunrise", sunrise)
                put("Sunset", sunset)
            }
            context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
                .edit()
                .putString(cacheKey(date), json.toString())
                .apply()
        }

        /** Load prayer times for a specific date, returns null if not cached */
        fun loadPrayerTimes(context: Context, date: String): Triple<Map<String, String>, String, String>? {
            val raw = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
                .getString(cacheKey(date), null) ?: return null
            return try {
                val json = JSONObject(raw)
                val prayers = linkedMapOf(
                    "Fajr"    to json.getString("Fajr"),
                    "Dhuhr"   to json.getString("Dhuhr"),
                    "Asr"     to json.getString("Asr"),
                    "Maghrib" to json.getString("Maghrib"),
                    "Isha"    to json.getString("Isha")
                )
                val sunrise = json.optString("Sunrise", "--:--")
                val sunset  = json.optString("Sunset",  "--:--")
                Triple(prayers, sunrise, sunset)
            } catch (e: Exception) {
                android.util.Log.e("QuranWidget", "Error parsing cached prayer times", e)
                null
            }
        }

        /** Remove cache entries older than today to avoid unbounded growth */
        fun pruneOldCache(context: Context) {
            val prefs = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
            val today = todayKey()
            val toRemove = prefs.all.keys.filter { key ->
                key.startsWith("prayers_") && key.removePrefix("prayers_") < today
            }
            if (toRemove.isNotEmpty()) {
                prefs.edit().apply { toRemove.forEach { remove(it) } }.apply()
            }
        }
    }

    /** Cancel the alarm when a specific widget instance is removed. */
    override fun onDeleted(context: Context, appWidgetIds: IntArray) {
        super.onDeleted(context, appWidgetIds)
        val manager = AppWidgetManager.getInstance(context)
        // If no widget instances remain after this deletion, cancel the alarm
        val remaining = manager.getAppWidgetIds(
            android.content.ComponentName(context, this::class.java)
        ).filter { it !in appWidgetIds }
        if (remaining.isEmpty()) {
            cancelPrayerAlarm(context)
            cancelCountdownAlarm(context)
            cancelSecondAlarm(context)
        }
    }

    /** Cancel the alarm when the last widget instance is removed. */
    override fun onDisabled(context: Context) {
        super.onDisabled(context)
        cancelPrayerAlarm(context)
        cancelCountdownAlarm(context)
        cancelSecondAlarm(context)
    }

    override fun onAppWidgetOptionsChanged(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetId: Int,
        newOptions: Bundle
    ) {
        super.onAppWidgetOptionsChanged(context, appWidgetManager, appWidgetId, newOptions)
        onUpdate(context, appWidgetManager, intArrayOf(appWidgetId))
    }

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        // Always collect IDs from both providers so alarm updates reach every widget instance,
        // regardless of which provider class the alarm was originally scheduled against.
        val allWidgetIds = run {
            val thisIds   = appWidgetManager.getAppWidgetIds(
                android.content.ComponentName(context, QuranWidgetProvider::class.java))
            val largeIds  = try {
                appWidgetManager.getAppWidgetIds(
                    android.content.ComponentName(context.packageName,
                        "${context.packageName}.QuranWidgetProviderLarge"))
            } catch (e: Exception) { intArrayOf() }
            (thisIds.toList() + largeIds.toList() + appWidgetIds.toList())
                .distinct().toIntArray()
        }

        val lang = getAppLanguage(context)
        val (day, month, year) = getHijriDate(context, lang)

        val launchIntent = context.packageManager.getLaunchIntentForPackage(context.packageName)
        val pendingIntent = PendingIntent.getActivity(
            context, 0, launchIntent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )

        val today = todayKey()
        val cached = loadPrayerTimes(context, today)

        if (cached != null) {
            // ── Cache hit: update immediately, no network needed ──────────
            val (prayers, sunrise, sunset) = cached
            val next = getNextPrayer(prayers, context)
            for (widgetId in allWidgetIds) {
                val isLarge = isLargeWidget(context, appWidgetManager, widgetId)
                val views = buildViews(context, isLarge, day, month, year,
                    prayers, pendingIntent, next, sunrise, sunset,
                    appWidgetManager, widgetId, lang)
                appWidgetManager.updateAppWidget(widgetId, views)
            }
            scheduleNextPrayerAlarm(context, next.second, allWidgetIds)
            scheduleCountdownAlarm(context, next.second, allWidgetIds)

            // Schedule per-second updates if inside the 10-min seconds window,
            // otherwise make sure any stale second alarm is cancelled.
            val millisUntilNext = run {
                try {
                    val p = next.second.trim().split(":")
                    if (p.size < 2) Long.MAX_VALUE
                    else {
                        val pCal = Calendar.getInstance().apply {
                            set(Calendar.HOUR_OF_DAY, p[0].toInt())
                            set(Calendar.MINUTE, p[1].toInt())
                            set(Calendar.SECOND, 0); set(Calendar.MILLISECOND, 0)
                            if (timeInMillis <= System.currentTimeMillis()) add(Calendar.DAY_OF_MONTH, 1)
                        }
                        pCal.timeInMillis - System.currentTimeMillis()
                    }
                } catch (e: Exception) { Long.MAX_VALUE }
            }
            if (millisUntilNext in 1..SECONDS_THRESHOLD_MS) {
                scheduleSecondAlarm(context, allWidgetIds)
            } else {
                cancelSecondAlarm(context)
            }

            // Still refresh in the background if we have fewer than 3 days ahead cached
            val daysAheadCached = (1..6).count { loadPrayerTimes(context, dateKey(it)) != null }
            if (daysAheadCached < 3) {
                fetchAndCacheWeek(context, appWidgetManager, allWidgetIds, day, month, year, pendingIntent, lang)
            }
        } else {
            // ── Cache miss: show skeleton, then fetch ──────────────────────
            for (widgetId in allWidgetIds) {
                val isLarge = isLargeWidget(context, appWidgetManager, widgetId)
                val views = buildViews(context, isLarge, day, month, year, null, pendingIntent,
                    appWidgetManager = appWidgetManager, widgetId = widgetId, lang = lang)
                appWidgetManager.updateAppWidget(widgetId, views)
            }
            fetchAndCacheWeek(context, appWidgetManager, allWidgetIds, day, month, year, pendingIntent, lang)
        }
    }

    // ── Network fetch: grab the full month calendar, cache next 7 days ──────

    private fun fetchAndCacheWeek(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        day: String, month: String, year: String,
        pendingIntent: PendingIntent,
        lang: String = "english"
    ) {
        CoroutineScope(Dispatchers.IO).launch {
            try {
                val location = getDeviceLocation(context) ?: return@launch
                val (lat, lon) = location

                val cal = Calendar.getInstance()
                val currentMonth = cal.get(Calendar.MONTH) + 1
                val currentYear  = cal.get(Calendar.YEAR)

                // Fetch full month calendar in one request
                val url = "https://api.aladhan.com/v1/calendar/$currentYear/$currentMonth" +
                          "?latitude=$lat&longitude=$lon&method=2"
                val response = URL(url).readText()
                val json     = JSONObject(response)
                val dataArr  = json.getJSONArray("data")

                val sdf = SimpleDateFormat(DATE_FORMAT, Locale.US)

                for (i in 0 until dataArr.length()) {
                    try {
                        val entry   = dataArr.getJSONObject(i)
                        val dateObj = entry.getJSONObject("date").getJSONObject("gregorian")

                        // month is a nested object {"number":6,"en":"June"} — not a plain string
                        val dayNum   = dateObj.getString("day").trim().padStart(2, '0')
                        val monthNum = dateObj.getJSONObject("month").getInt("number").toString().padStart(2, '0')
                        val yearNum  = dateObj.getString("year").trim()
                        val dateStr  = "$yearNum-$monthNum-$dayNum"

                        // Only cache today + next 6 days
                        val entryDate = sdf.parse(dateStr) ?: continue
                        val todayDate = sdf.parse(todayKey()) ?: continue
                        val diffDays  = ((entryDate.time - todayDate.time) / 86_400_000).toInt()
                        if (diffDays < 0 || diffDays > 6) continue

                        val timings = entry.getJSONObject("timings")
                        val prayers = linkedMapOf(
                            "Fajr"    to timings.getString("Fajr").trim().take(5),
                            "Dhuhr"   to timings.getString("Dhuhr").trim().take(5),
                            "Asr"     to timings.getString("Asr").trim().take(5),
                            "Maghrib" to timings.getString("Maghrib").trim().take(5),
                            "Isha"    to timings.getString("Isha").trim().take(5)
                        )
                        val sunrise = timings.getString("Sunrise").trim().take(5)
                        val sunset  = timings.getString("Sunset").trim().take(5)

                        savePrayerTimes(context, dateStr, prayers, sunrise, sunset)
                        android.util.Log.d("QuranWidget", "Cached prayers for $dateStr")
                    } catch (e: Exception) {
                        android.util.Log.e("QuranWidget", "Error parsing calendar entry $i", e)
                    }
                }

                pruneOldCache(context)

                // Update the widget with today's freshly cached data
                val todayCached = loadPrayerTimes(context, todayKey())
                if (todayCached != null) {
                    val (prayers, sunrise, sunset) = todayCached
                    val next = getNextPrayer(prayers, context)
                    val allIds = run {
                        val base = appWidgetManager.getAppWidgetIds(
                            android.content.ComponentName(context, QuranWidgetProvider::class.java))
                        val large = try {
                            appWidgetManager.getAppWidgetIds(
                                android.content.ComponentName(context.packageName,
                                    "${context.packageName}.QuranWidgetProviderLarge"))
                        } catch (e: Exception) { intArrayOf() }
                        (base.toList() + large.toList() + appWidgetIds.toList()).distinct().toIntArray()
                    }
                    CoroutineScope(Dispatchers.Main).launch {
                        for (widgetId in allIds) {
                            val isLarge = isLargeWidget(context, appWidgetManager, widgetId)
                            val views = buildViews(context, isLarge, day, month, year,
                                prayers, pendingIntent, next, sunrise, sunset,
                                appWidgetManager, widgetId, lang)
                            appWidgetManager.updateAppWidget(widgetId, views)
                        }
                        scheduleNextPrayerAlarm(context, next.second, allIds)
                        scheduleCountdownAlarm(context, next.second, allIds)

                        // Schedule per-second updates if inside the 10-min seconds window,
                        // otherwise make sure any stale second alarm is cancelled.
                        val millisUntilNext = run {
                            try {
                                val p = next.second.trim().split(":")
                                if (p.size < 2) Long.MAX_VALUE
                                else {
                                    val pCal = Calendar.getInstance().apply {
                                        set(Calendar.HOUR_OF_DAY, p[0].toInt())
                                        set(Calendar.MINUTE, p[1].toInt())
                                        set(Calendar.SECOND, 0); set(Calendar.MILLISECOND, 0)
                                        if (timeInMillis <= System.currentTimeMillis()) add(Calendar.DAY_OF_MONTH, 1)
                                    }
                                    pCal.timeInMillis - System.currentTimeMillis()
                                }
                            } catch (e: Exception) { Long.MAX_VALUE }
                        }
                        if (millisUntilNext in 1..SECONDS_THRESHOLD_MS) {
                            scheduleSecondAlarm(context, allIds)
                        } else {
                            cancelSecondAlarm(context)
                        }
                    }
                }

            } catch (e: Exception) {
                android.util.Log.e("QuranWidget", "Error fetching/caching prayer times: ${e.message}", e)
            }
        }
    }

    // ── Language helpers ─────────────────────────────────────────────────────

        /** Read the language the user selected in the Flutter app. */
        private fun getAppLanguage(context: Context): String {
            val prefs = context.getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)
            return prefs.getString("flutter.app_language", "english") ?: "english"
        }

        /** Translate a label key into the chosen language. */
        private fun translateLabel(key: String, lang: String): String {
            return when (lang) {
                "arabic" -> when (key) {
                    "until"    -> "حتى"
                    "sunrise"  -> "الشروق"
                    "sunset"   -> "الغروب"
                    else       -> key
                }
                "urdu" -> when (key) {
                    "until"    -> "تک"
                    "sunrise"  -> "طلوع"
                    "sunset"   -> "غروب"
                    else       -> key
                }
                else -> when (key) {
                    "until"    -> "UNTIL"
                    "sunrise"  -> "Sunrise"
                    "sunset"   -> "Sunset"
                    else       -> key
                }
            }
        }

        /** Translate an English prayer key into the chosen language. */
        private fun translatePrayerName(name: String, lang: String): String {
            return when (lang) {
                "arabic" -> when (name) {
                    "Fajr"    -> "الفجر"
                    "Dhuhr"   -> "الظهر"
                    "Asr"     -> "العصر"
                    "Maghrib" -> "المغرب"
                    "Isha"    -> "العشاء"
                    else      -> name
                }
                "urdu" -> when (name) {
                    "Fajr"    -> "فجر"
                    "Dhuhr"   -> "ظہر"
                    "Asr"     -> "عصر"
                    "Maghrib" -> "مغرب"
                    "Isha"    -> "عشاء"
                    else      -> name
                }
                else -> name // english / default
            }
        }

        /** Return the 12 Hijri month names in the chosen language. */
        private fun getHijriMonthNames(lang: String): Array<String> {
            return when (lang) {
                "arabic" -> arrayOf(
                    "مُحَرَّم", "صَفَر", "رَبِيع الأَوَّل", "رَبِيع الثَّانِي",
                    "جُمَادَى الأُولَى", "جُمَادَى الثَّانِيَة", "رَجَب", "شَعْبَان",
                    "رَمَضَان", "شَوَّال", "ذُو القَعْدَة", "ذُو الحِجَّة"
                )
                "urdu" -> arrayOf(
                    "محرم", "صفر", "ربیع الاول", "ربیع الثانی",
                    "جمادی الاولی", "جمادی الثانی", "رجب", "شعبان",
                    "رمضان", "شوال", "ذوالقعدہ", "ذوالحجہ"
                )
                else -> arrayOf(
                    "Muharram", "Safar", "Rabi' al-Awwal", "Rabi' al-Thani",
                    "Jumada al-Awwal", "Jumada al-Thani", "Rajab", "Sha'ban",
                    "Ramadan", "Shawwal", "Dhu al-Qi'dah", "Dhu al-Hijjah"
                )
            }
        }

        /** Convert Latin digits 0-9 to Eastern Arabic-Indic ٠-٩ for Arabic/Urdu. */
        fun toLocalDigits(str: String, lang: String): String {
            if (lang != "arabic" && lang != "urdu") return str
            return str.map { c ->
                when (c) {
                    '0' -> '٠'; '1' -> '١'; '2' -> '٢'; '3' -> '٣'; '4' -> '٤'
                    '5' -> '٥'; '6' -> '٦'; '7' -> '٧'; '8' -> '٨'; '9' -> '٩'
                    else -> c
                }
            }.joinToString("")
        }

    // ── Location helpers (unchanged) ─────────────────────────────────────────

    private fun getDeviceLocation(context: Context): Pair<Double, Double>? {
        return try {
            val flutterPrefs = context.getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)
            var lat = flutterPrefs.getString("flutter.prayer_location_lat", null)?.toDoubleOrNull()
            var lon = flutterPrefs.getString("flutter.prayer_location_lon", null)?.toDoubleOrNull()

            if (lat == null || lon == null) {
                lat = flutterPrefs.getString("prayer_location_lat", null)?.toDoubleOrNull()
                lon = flutterPrefs.getString("prayer_location_lon", null)?.toDoubleOrNull()
            }
            if (lat != null && lon != null) return Pair(lat, lon)

            var autoLat = flutterPrefs.getString("flutter.widget_latitude", null)?.toDoubleOrNull()
            var autoLon = flutterPrefs.getString("flutter.widget_longitude", null)?.toDoubleOrNull()
            if (autoLat == null || autoLon == null) {
                autoLat = flutterPrefs.getString("widget_latitude", null)?.toDoubleOrNull()
                autoLon = flutterPrefs.getString("widget_longitude", null)?.toDoubleOrNull()
            }
            if (autoLat != null && autoLon != null) return Pair(autoLat, autoLon)

            val prefs = context.getSharedPreferences("flutter_box", Context.MODE_PRIVATE)
            lat = prefs.getString("flutter.widget_latitude", null)?.toDoubleOrNull()
            lon = prefs.getString("flutter.widget_longitude", null)?.toDoubleOrNull()
            if (lat == null || lon == null) {
                lat = prefs.getString("widget_latitude", null)?.toDoubleOrNull()
                lon = prefs.getString("widget_longitude", null)?.toDoubleOrNull()
            }
            if (lat != null && lon != null) return Pair(lat, lon)

            val locationManager = context.getSystemService(Context.LOCATION_SERVICE) as LocationManager
            if (ContextCompat.checkSelfPermission(context, Manifest.permission.ACCESS_COARSE_LOCATION) == PackageManager.PERMISSION_GRANTED) {
                val loc = locationManager.getLastKnownLocation(LocationManager.NETWORK_PROVIDER)
                if (loc != null) return Pair(loc.latitude, loc.longitude)
            }
            if (ContextCompat.checkSelfPermission(context, Manifest.permission.ACCESS_FINE_LOCATION) == PackageManager.PERMISSION_GRANTED) {
                val loc = locationManager.getLastKnownLocation(LocationManager.GPS_PROVIDER)
                if (loc != null) return Pair(loc.latitude, loc.longitude)
            }
            null
        } catch (e: Exception) {
            android.util.Log.e("QuranWidget", "Error getting device location", e)
            null
        }
    }

    // ── View builders (unchanged) ────────────────────────────────────────────

    private fun isLargeWidget(context: Context, manager: AppWidgetManager, widgetId: Int): Boolean {
        val info = manager.getAppWidgetInfo(widgetId) ?: return false
        return info.provider.className.contains("Large")
    }

    private fun buildViews(
        context: Context,
        isLarge: Boolean,
        day: String, month: String, year: String,
        prayers: Map<String, String>?,
        pendingIntent: PendingIntent,
        next: Pair<String, String>? = null,
        sunrise: String? = null,
        sunset: String? = null,
        appWidgetManager: AppWidgetManager? = null,
        widgetId: Int = 0,
        lang: String = "english"
    ): RemoteViews {
        // Read both dimensions — width is the real constraint on narrow phones like M01
        val options = appWidgetManager?.getAppWidgetOptions(widgetId)
        // Use MAX_* — these reflect the widget's actual current rendered size.
        // MIN_* only reports the minimum possible size at the current cell count and
        // barely changes when the widget is enlarged, causing text to stay small.
        val minHeight = options?.getInt(AppWidgetManager.OPTION_APPWIDGET_MAX_HEIGHT, 0) ?: 0
        val minWidth  = options?.getInt(AppWidgetManager.OPTION_APPWIDGET_MAX_WIDTH,  0) ?: 0

        // Hero text: driven by height
        val daySize: Float
        val countdownSize: Float
        when {
            minHeight >= 200 -> { daySize = 44f; countdownSize = 26f }
            minHeight >= 150 -> { daySize = 32f; countdownSize = 18f }
            else             -> { daySize = 22f; countdownSize = 13f }
        }

        // Prayer columns: driven by width — narrow phones need tighter text
        // so columns don't look bloated with tiny centered text
        val prayerTimeSize: Float
        val prayerLabelSize: Float
        when {
            minWidth >= 300 -> { prayerTimeSize = 14f; prayerLabelSize = 10f }
            minWidth >= 240 -> { prayerTimeSize = 12f; prayerLabelSize = 9f  }
            else            -> { prayerTimeSize = 10f; prayerLabelSize = 8f  }
        }
        val layout = if (isLarge) R.layout.quran_widget_large else R.layout.quran_widget_small
        return RemoteViews(context.packageName, layout).apply {
            try {
                val ahSuffix = when (lang) { "arabic" -> "هـ"; "urdu" -> "ھ"; else -> "AH" }
                setTextViewText(R.id.widget_hijri_day, toLocalDigits(day, lang))
                setTextViewText(R.id.widget_hijri_month, month)
                setTextViewText(R.id.widget_hijri_year, "${toLocalDigits(year, lang)} $ahSuffix")
                setOnClickPendingIntent(R.id.widget_hijri_day, pendingIntent)
                // Apply size-aware text sizes — these are set explicitly so they
                // reset correctly when the widget is enlarged again after shrinking
                setTextViewTextSize(R.id.widget_hijri_day, TypedValue.COMPLEX_UNIT_SP, daySize)
                if (isLarge) {
                    setTextViewTextSize(R.id.widget_countdown_large, TypedValue.COMPLEX_UNIT_SP, countdownSize)
                    setTextViewText(R.id.lbl_until_large, translateLabel("until", lang))
                } else {
                    setTextViewTextSize(R.id.widget_countdown, TypedValue.COMPLEX_UNIT_SP, countdownSize)
                    setTextViewText(R.id.lbl_until_small, translateLabel("until", lang))
                }

                if (!isLarge) {
                    try {
                        if (next != null) {
                            setTextViewText(R.id.widget_next_name, translatePrayerName(next.first, lang))
                            setCountdown(this, R.id.widget_countdown, next.second, lang)
                        } else {
                            setTextViewText(R.id.widget_next_name, "---")
                            setTextViewText(R.id.widget_countdown, "---")
                        }
                    } catch (e: Exception) {
                        android.util.Log.e("QuranWidget", "Error setting small widget prayer data", e)
                    }
                } else {
                    try {
                        if (prayers != null) {
                            setTextViewText(R.id.widget_fajr,    toLocalDigits(prayers["Fajr"]    ?: "--:--", lang))
                            setTextViewText(R.id.widget_dhuhr,   toLocalDigits(prayers["Dhuhr"]   ?: "--:--", lang))
                            setTextViewText(R.id.widget_asr,     toLocalDigits(prayers["Asr"]     ?: "--:--", lang))
                            setTextViewText(R.id.widget_maghrib, toLocalDigits(prayers["Maghrib"] ?: "--:--", lang))
                            setTextViewText(R.id.widget_isha,    toLocalDigits(prayers["Isha"]    ?: "--:--", lang))

                            // Scale prayer column text to widget width so narrow phones
                            // (e.g. M01) don't end up with tiny text in oversized columns
                            listOf(R.id.widget_fajr, R.id.widget_dhuhr, R.id.widget_asr,
                                   R.id.widget_maghrib, R.id.widget_isha).forEach {
                                setTextViewTextSize(it, TypedValue.COMPLEX_UNIT_SP, prayerTimeSize)
                            }
                            listOf(R.id.lbl_fajr, R.id.lbl_dhuhr, R.id.lbl_asr,
                                   R.id.lbl_maghrib, R.id.lbl_isha).forEach {
                                setTextViewTextSize(it, TypedValue.COMPLEX_UNIT_SP, prayerLabelSize)
                            }
                            // Translate prayer label text
                            setTextViewText(R.id.lbl_fajr,    translatePrayerName("Fajr",    lang))
                            setTextViewText(R.id.lbl_dhuhr,   translatePrayerName("Dhuhr",   lang))
                            setTextViewText(R.id.lbl_asr,     translatePrayerName("Asr",     lang))
                            setTextViewText(R.id.lbl_maghrib, translatePrayerName("Maghrib", lang))
                            setTextViewText(R.id.lbl_isha,    translatePrayerName("Isha",    lang))

                            if (next != null) {
                                val highlightColor = android.graphics.Color.parseColor("#7A9E7A")
                                val dimTextColor   = android.graphics.Color.parseColor("#4A6B4A")
                                mapOf(
                                    "Fajr"    to Triple(R.id.lbl_fajr,    R.id.widget_fajr,    R.id.prayer_box_fajr),
                                    "Dhuhr"   to Triple(R.id.lbl_dhuhr,   R.id.widget_dhuhr,   R.id.prayer_box_dhuhr),
                                    "Asr"     to Triple(R.id.lbl_asr,     R.id.widget_asr,     R.id.prayer_box_asr),
                                    "Maghrib" to Triple(R.id.lbl_maghrib, R.id.widget_maghrib, R.id.prayer_box_maghrib),
                                    "Isha"    to Triple(R.id.lbl_isha,    R.id.widget_isha,    R.id.prayer_box_isha)
                                ).forEach { (prayerName, ids) ->
                                    if (prayerName == next.first) {
                                        setTextColor(ids.first,  highlightColor)
                                        setTextColor(ids.second, highlightColor)
                                        setInt(ids.third, "setBackgroundResource", R.drawable.prayer_box_highlight)
                                    } else {
                                        setTextColor(ids.first,  dimTextColor)
                                        setTextColor(ids.second, dimTextColor)
                                        setInt(ids.third, "setBackgroundResource", R.drawable.prayer_box_dim)
                                    }
                                }
                            }
                        } else {
                            setTextViewText(R.id.widget_fajr,    "--:--")
                            setTextViewText(R.id.widget_dhuhr,   "--:--")
                            setTextViewText(R.id.widget_asr,     "--:--")
                            setTextViewText(R.id.widget_maghrib, "--:--")
                            setTextViewText(R.id.widget_isha,    "--:--")
                        }

                        if (next != null) {
                            setTextViewText(R.id.widget_next_name_large, translatePrayerName(next.first, lang))
                            setCountdown(this, R.id.widget_countdown_large, next.second, lang)
                        } else {
                            setTextViewText(R.id.widget_next_name_large, "---")
                            setTextViewText(R.id.widget_countdown_large, "--:--")
                        }

                        setTextViewText(R.id.widget_sunrise, toLocalDigits(sunrise ?: "--:--", lang))
                        setTextViewText(R.id.widget_sunset,  toLocalDigits(sunset  ?: "--:--", lang))
                        setTextViewText(R.id.lbl_sunrise_large, translateLabel("sunrise", lang))
                        setTextViewText(R.id.lbl_sunset_large, translateLabel("sunset", lang))

                    } catch (e: Exception) {
                        android.util.Log.e("QuranWidget", "Error setting large widget data", e)
                    }
                }
            } catch (e: Exception) {
                android.util.Log.e("QuranWidget", "Error in buildViews", e)
            }
        }
    }

    /**
     * Set the countdown TextView.
     * > 10 min  ->  "2h 15m" / "45m"   (updated each prayer alarm)
     * <= 10 min ->  "9m 42s" / "38s"   (updated every second via second alarm)
     */
    private fun setCountdown(views: RemoteViews, viewId: Int, prayerTime: String, lang: String = "english") {
        views.setTextViewText(viewId, getCountdownTime(prayerTime, lang))
    }


    private fun getCountdownTime(prayerTime: String, lang: String = "english"): String {
        return try {
            val parts = prayerTime.trim().split(":")
            if (parts.size < 2) return "---"
            val now = Calendar.getInstance()
            val prayer = Calendar.getInstance().apply {
                set(Calendar.HOUR_OF_DAY, parts[0].toInt())
                set(Calendar.MINUTE,      parts[1].toInt())
                set(Calendar.SECOND,      0)
                set(Calendar.MILLISECOND, 0)
            }
            if (prayer.timeInMillis <= now.timeInMillis) prayer.add(Calendar.DAY_OF_MONTH, 1)
            val diff  = prayer.timeInMillis - now.timeInMillis
            val hours = diff / (1000L * 60 * 60)
            val mins  = (diff / (1000L * 60)) % 60
            val secs  = (diff / 1000L) % 60
            val hU = when (lang) { "arabic" -> "س"; "urdu" -> "گھ"; else -> "h" }
            val mU = when (lang) { "arabic" -> "د"; "urdu" -> "م";  else -> "m" }
            val sU = when (lang) { "arabic" -> "ث"; "urdu" -> "ث";  else -> "s" }
            fun Long.d() = toLocalDigits(toString(), lang)
            when {
                hours > 0                    -> "${hours.d()}$hU ${mins.d()}$mU"
                diff >= SECONDS_THRESHOLD_MS -> "${mins.d()}$mU"
                mins > 0                     -> "${mins.d()}$mU ${secs.d()}$sU"
                else                         -> "${secs.d()}$sU"
            }
        } catch (e: Exception) {
            "---"
        }
    }

    private fun getNextPrayer(
        todayPrayers: Map<String, String>,
        context: Context? = null
    ): Pair<String, String> {
        val now       = System.currentTimeMillis()
        var nextPrayer: Pair<String, String>? = null
        var minDiff   = Long.MAX_VALUE

        // Only look at prayers still ahead of us today (millisecond precision)
        for ((name, time) in todayPrayers) {
            try {
                val parts = time.trim().split(":")
                if (parts.size < 2) continue
                val prayerCal = Calendar.getInstance().apply {
                    set(Calendar.HOUR_OF_DAY, parts[0].toInt())
                    set(Calendar.MINUTE,      parts[1].toInt())
                    set(Calendar.SECOND,      0)
                    set(Calendar.MILLISECOND, 0)
                }
                val diff = prayerCal.timeInMillis - now
                if (diff > 0 && diff < minDiff) {
                    minDiff = diff
                    nextPrayer = Pair(name, time.trim())
                }
            } catch (e: Exception) {
                android.util.Log.e("QuranWidget", "Error parsing time for $name", e)
            }
        }

        // All prayers have passed for today — next is tomorrow's Fajr
        if (nextPrayer == null) {
            val tomorrowFajr = context?.let { loadPrayerTimes(it, dateKey(1)) }?.first?.get("Fajr")
                ?: todayPrayers["Fajr"] // fallback to today's Fajr time if tomorrow isn't cached yet
            nextPrayer = Pair("Fajr", tomorrowFajr ?: "--:--")
        }

        return nextPrayer
    }

    /**
     * Returns the Hijri date to display, taking into account that the Islamic day
     * begins at Maghrib. After Maghrib has passed today, we show tomorrow's Hijri date.
     *
     * @param maghribTime Optional Maghrib time string "HH:mm". If null or unavailable
     *                    the Gregorian midnight boundary is used as a safe fallback.
     */
    private fun getHijriDate(context: Context? = null, lang: String = "english"): Triple<String, String, String> {
        // Determine whether the Islamic day has already flipped (i.e. Maghrib has passed).
        val islamicDayStarted: Boolean = run {
            val maghrib = context?.let {
                loadPrayerTimes(it, todayKey())?.first?.get("Maghrib")
            }
            if (maghrib != null) {
                try {
                    val parts = maghrib.trim().split(":")
                    if (parts.size >= 2) {
                        val now = Calendar.getInstance()
                        val maghribCal = Calendar.getInstance().apply {
                            set(Calendar.HOUR_OF_DAY, parts[0].toInt())
                            set(Calendar.MINUTE,      parts[1].toInt())
                            set(Calendar.SECOND,      0)
                            set(Calendar.MILLISECOND, 0)
                        }
                        now.timeInMillis >= maghribCal.timeInMillis
                    } else false
                } catch (e: Exception) { false }
            } else false
        }

        // If the Islamic day has begun, advance by one Gregorian day to get tomorrow's Hijri date
        val gregorianCal = Calendar.getInstance()
        if (islamicDayStarted) gregorianCal.add(Calendar.DAY_OF_MONTH, 1)

        val cal = UmmalquraCalendar()
        cal.time = gregorianCal.time
        val day   = cal.get(UmmalquraCalendar.DAY_OF_MONTH).toString()
        val year  = cal.get(UmmalquraCalendar.YEAR).toString()
        val monthNames = getHijriMonthNames(lang)
        val month = monthNames[cal.get(UmmalquraCalendar.MONTH)]
        return Triple(day, month, year)
    }
}