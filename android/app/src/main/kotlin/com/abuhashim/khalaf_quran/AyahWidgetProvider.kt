package com.abuhashim.khalafquran

import android.app.AlarmManager
import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Intent
import android.util.Log
import android.util.TypedValue
import android.widget.RemoteViews
import org.json.JSONArray
import org.json.JSONObject
import java.util.*

open class AyahWidgetProvider : AppWidgetProvider() {

    companion object {
        const val ACTION_RELOAD_AYAH = "com.abuhashim.khalafquran.ACTION_RELOAD_AYAH"
        private const val REQUEST_CODE_UPDATE_ALARM = 9004
        private const val ASSET_FILE = "reminder_ayahs.json"

        fun scheduleNextUpdate(context: Context, appWidgetIds: IntArray) {
            try {
                val intent = Intent(context, AyahWidgetProvider::class.java).apply {
                    action = AppWidgetManager.ACTION_APPWIDGET_UPDATE
                    putExtra(AppWidgetManager.EXTRA_APPWIDGET_IDS, appWidgetIds)
                }
                val pi = PendingIntent.getBroadcast(
                    context, REQUEST_CODE_UPDATE_ALARM, intent,
                    PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
                )
                val am = context.getSystemService(Context.ALARM_SERVICE) as AlarmManager
                am.setExactAndAllowWhileIdle(
                    AlarmManager.RTC_WAKEUP,
                    System.currentTimeMillis() + (3 * 60 * 60 * 1000L),
                    pi
                )
                Log.d("AyahWidget", "Next update scheduled in 3 hours")
            } catch (e: Exception) {
                Log.e("AyahWidget", "Error scheduling update alarm", e)
            }
        }

        // Reads reminder_ayahs.json from assets/ — returns empty list on any failure.
        fun loadAyahsFromAssets(context: Context): List<JSONObject> {
            return try {
                val raw = context.assets.open(ASSET_FILE).bufferedReader().use { it.readText() }
                val array = JSONArray(raw)
                (0 until array.length()).map { array.getJSONObject(it) }
            } catch (e: Exception) {
                Log.e("AyahWidget", "Error loading ayahs from assets", e)
                emptyList()
            }
        }
    }

    private fun getAppLanguage(context: Context): String {
        val prefs = context.getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)
        return prefs.getString("flutter.app_language", "english") ?: "english"
    }

    private fun toLocalDigits(str: String, lang: String): String {
        if (lang != "arabic" && lang != "urdu") return str
        return str.map { c ->
            when (c) {
                '0' -> '٠'; '1' -> '١'; '2' -> '٢'; '3' -> '٣'; '4' -> '٤'
                '5' -> '٥'; '6' -> '٦'; '7' -> '٧'; '8' -> '٨'; '9' -> '٩'
                else -> c
            }
        }.joinToString("")
    }

    private fun translateSurahName(name: String, lang: String): String {
        return when (lang) {
            "arabic" -> when (name) {
                "Al-Fatiha" -> "الفاتحة"
                "Al-Baqarah" -> "البقرة"
                "Ali Imran" -> "آل عمران"
                "An-Nisa" -> "النساء"
                "Al-Ma'idah" -> "المائدة"
                "Al-Anam" -> "الأنعام"
                "Al-Araf" -> "الأعراف"
                "Al-Anfal" -> "الأنفال"
                "At-Tawbah" -> "التوبة"
                "Yunus" -> "يونس"
                "Hud" -> "هود"
                "Yusuf" -> "يوسف"
                "Ar-Rad" -> "الرعد"
                "Ibrahim" -> "إبراهيم"
                "Al-Hijr" -> "الحجر"
                "An-Nahl" -> "النحل"
                "Al-Isra" -> "الإسراء"
                "Al-Kahf" -> "الكهف"
                "Maryam" -> "مريم"
                "Ta-Ha" -> "طه"
                "Ad-Duha" -> "الضحى"
                "Adh-Dhariyat" -> "الذاريات"
                "Al-Ahzab" -> "الأحزاب"
                "Al-Alaq" -> "العلق"
                "Al-Anbiya" -> "الأنبياء"
                "Al-Ankabut" -> "العنكبوت"
                "Al-Asr" -> "العصر"
                "Al-Balad" -> "البلد"
                "Al-Falaq" -> "الفلق"
                "Al-Furqan" -> "الفرقان"
                "Al-Hadid" -> "الحديد"
                "Al-Hajj" -> "الحج"
                "Al-Hujurat" -> "الحجرات"
                "Al-Ikhlas" -> "الإخلاص"
                "Al-Insan" -> "الإنسان"
                "Al-Inshiqaq" -> "الانشقاق"
                "Al-Jumuah" -> "الجمعة"
                "Al-Maun" -> "الماعون"
                "Al-Mujadila" -> "المجادلة"
                "Al-Mulk" -> "الملك"
                "Al-Muminun" -> "المؤمنون"
                "Al-Muzzammil" -> "المزمل"
                "Al-Qasas" -> "القصص"
                "An-Naml" -> "النمل"
                "An-Nas" -> "الناس"
                "An-Nur" -> "النور"
                "Ar-Rahman" -> "الرحمن"
                "Ash-Sharh" -> "الشرح"
                "Ash-Shura" -> "الشورى"
                "At-Taghabun" -> "التغابن"
                "At-Talaq" -> "الطلاق"
                "At-Tariq" -> "الطارق"
                "Az-Zalzalah" -> "الزلزلة"
                "Az-Zumar" -> "الزمر"
                "Fatir" -> "فاطر"
                "Fussilat" -> "فصلت"
                "Ghafir" -> "غافر"
                "Luqman" -> "لقمان"
                "Muhammad" -> "محمد"
                "Nuh" -> "نوح"
                else -> name
            }
            "urdu" -> when (name) {
                "Al-Fatiha" -> "الفاتحہ"
                "Al-Baqarah" -> "البقرہ"
                "Ali Imran" -> "آل عمران"
                "An-Nisa" -> "النساء"
                "Al-Ma'idah" -> "المائدہ"
                "Al-Anam" -> "الانعام"
                "Al-Araf" -> "الاعراف"
                "Al-Anfal" -> "الانفال"
                "At-Tawbah" -> "التوبہ"
                "Yunus" -> "یونس"
                "Hud" -> "ہود"
                "Yusuf" -> "یوسف"
                "Ar-Rad" -> "الرعد"
                "Ibrahim" -> "ابراہیم"
                "Al-Hijr" -> "الحجر"
                "An-Nahl" -> "النحل"
                "Al-Isra" -> "الاسراء"
                "Al-Kahf" -> "الکہف"
                "Maryam" -> "مریم"
                "Ta-Ha" -> "طہ"
                "Ad-Duha" -> "الضحیٰ"
                "Adh-Dhariyat" -> "الذاریات"
                "Al-Ahzab" -> "الاحزاب"
                "Al-Alaq" -> "العلق"
                "Al-Anbiya" -> "الانبیاء"
                "Al-Ankabut" -> "العنکبوت"
                "Al-Asr" -> "العصر"
                "Al-Balad" -> "البلد"
                "Al-Falaq" -> "الفلق"
                "Al-Furqan" -> "الفرقان"
                "Al-Hadid" -> "الحدید"
                "Al-Hajj" -> "الحج"
                "Al-Hujurat" -> "الحجرات"
                "Al-Ikhlas" -> "الاخلاص"
                "Al-Insan" -> "الانسان"
                "Al-Inshiqaq" -> "الانشقاق"
                "Al-Jumuah" -> "الجمعہ"
                "Al-Maun" -> "الماعون"
                "Al-Mujadila" -> "المجادلہ"
                "Al-Mulk" -> "الملک"
                "Al-Muminun" -> "المومنون"
                "Al-Muzzammil" -> "المزمل"
                "Al-Qasas" -> "القصص"
                "An-Naml" -> "النمل"
                "An-Nas" -> "الناس"
                "An-Nur" -> "النور"
                "Ar-Rahman" -> "الرحمن"
                "Ash-Sharh" -> "الشرح"
                "Ash-Shura" -> "الشوریٰ"
                "At-Taghabun" -> "التغابن"
                "At-Talaq" -> "الطلاق"
                "At-Tariq" -> "الطارق"
                "Az-Zalzalah" -> "الزلزلہ"
                "Az-Zumar" -> "الزمر"
                "Fatir" -> "فاطر"
                "Fussilat" -> "فصلت"
                "Ghafir" -> "غافر"
                "Luqman" -> "لقمان"
                "Muhammad" -> "محمد"
                "Nuh" -> "نوح"
                else -> name
            }
            else -> name
        }
    }

    private fun applyDynamicScaling(
        appWidgetManager: AppWidgetManager,
        widgetId: Int,
        views: RemoteViews,
        lang: String
    ) {
        val options = appWidgetManager.getAppWidgetOptions(widgetId)
        val height = options.getInt(AppWidgetManager.OPTION_APPWIDGET_MAX_HEIGHT, 0)

        var (translationSize, metaSize) = when {
            height >= 200 -> 20f to 13f
            height >= 150 -> 16f to 11f
            else          -> 12f to 10f
        }

        // Increase font size for Arabic/Urdu to improve readability
        if (lang == "arabic" || lang == "urdu") {
            translationSize += 4f
            metaSize += 2f
        }

        views.setTextViewTextSize(R.id.widget_ayah_translation, TypedValue.COMPLEX_UNIT_SP, translationSize)
        views.setTextViewTextSize(R.id.widget_ayah_reference,   TypedValue.COMPLEX_UNIT_SP, metaSize)
        views.setTextViewTextSize(R.id.widget_ayah_attribution, TypedValue.COMPLEX_UNIT_SP, metaSize)
    }

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        val ayahs = loadAyahsFromAssets(context)
        val lang = getAppLanguage(context)

        if (ayahs.isEmpty()) {
            // Asset missing or malformed — show error state
            for (widgetId in appWidgetIds) {
                val views = RemoteViews(context.packageName, R.layout.ayah_widget_large).apply {
                    setTextViewText(R.id.widget_ayah_translation, "Could not load verses. Please reinstall the app.")
                    setTextViewText(R.id.widget_ayah_reference, "ERROR")
                    setTextViewText(R.id.widget_ayah_attribution, "")
                }
                applyDynamicScaling(appWidgetManager, widgetId, views, lang)
                appWidgetManager.updateAppWidget(widgetId, views)
            }
        } else {
            updateWidgetsWithRandomAyah(context, appWidgetManager, appWidgetIds, ayahs)
        }

        scheduleNextUpdate(context, appWidgetIds)
    }

    override fun onReceive(context: Context, intent: Intent) {
        super.onReceive(context, intent)
        if (intent.action == ACTION_RELOAD_AYAH) {
            val appWidgetManager = AppWidgetManager.getInstance(context)
            val component = android.content.ComponentName(context, AyahWidgetProvider::class.java)
            val ids = appWidgetManager.getAppWidgetIds(component)
            onUpdate(context, appWidgetManager, ids)
        }
    }

    private fun updateWidgetsWithRandomAyah(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        ayahs: List<JSONObject>
    ) {
        val lang = getAppLanguage(context)
        // Dataset uses: "english", "arabic", "surah", "ref" (e.g. "2:255")
        val randomAyah = ayahs[Random().nextInt(ayahs.size)]

        val (translationText, referenceText) = if (lang == "arabic" || lang == "urdu") {
            // Arabic/Urdu mode: Arabic text + translated reference
            val arabicText = randomAyah.optString("arabic", "---")
            val surahName = randomAyah.optString("surah", "Unknown")
            val ref = randomAyah.optString("ref", "")
            val ayahNo = ref.substringAfter(":", "")

            val translatedSurah = translateSurahName(surahName, lang)
            val reference = if (ayahNo.isNotEmpty()) {
                "$translatedSurah · ${toLocalDigits(ayahNo, lang)}"
            } else {
                translatedSurah
            }
            arabicText to reference
        } else {
            // English mode: English translation + reference
            val translation = randomAyah.optString("english", "---")
            val surahName  = randomAyah.optString("surah", "Unknown")
            val ref        = randomAyah.optString("ref", "")
            val ayahNo = ref.substringAfter(":", "")
            val reference = if (ayahNo.isNotEmpty()) {
                "$surahName · $ayahNo".uppercase()
            } else {
                surahName.uppercase()
            }
            "“$translation”" to reference
        }

        for (widgetId in appWidgetIds) {
            val views = RemoteViews(context.packageName, R.layout.ayah_widget_large).apply {
                setTextViewText(R.id.widget_ayah_translation, translationText)
                setTextViewText(R.id.widget_ayah_reference, referenceText)
                setTextViewText(R.id.widget_ayah_attribution, "")

                val reloadIntent = Intent(context, AyahWidgetProvider::class.java).apply {
                    action = ACTION_RELOAD_AYAH
                }
                val pi = PendingIntent.getBroadcast(
                    context, widgetId, reloadIntent,
                    PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
                )
                setOnClickPendingIntent(R.id.btn_reload_ayah, pi)
            }
            applyDynamicScaling(appWidgetManager, widgetId, views, lang)
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
