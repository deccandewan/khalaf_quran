package com.abuhashim.khalafquran
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import androidx.core.content.FileProvider
import androidx.core.splashscreen.SplashScreen.Companion.installSplashScreen
import android.app.AlarmManager
import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.os.SystemClock
import java.io.File
class MainActivity : FlutterActivity() {
    private val WIDGET_CHANNEL = "com.abuhashim.khalafquran/widget"
    private val INTENT_CHANNEL = "com.abuhashim.khalafquran/intent"
    override fun onCreate(savedInstanceState: android.os.Bundle?) {
        installSplashScreen()
        super.onCreate(savedInstanceState)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        // 1. Widget Channel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, WIDGET_CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "scheduleWidgetUpdate" -> {
                        scheduleWidgetUpdate()
                        result.success(null)
                    }
                    "updateWidget" -> {
                        broadcastWidgetUpdate()
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }
        // 2. Intent/Installer Channel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, INTENT_CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method == "openFile") {
                    val path = call.argument<String>("path") ?: return@setMethodCallHandler result.error("NO_PATH", "Path is null", null)
                    try {
                        val file = File(path)
                        val uri = FileProvider.getUriForFile(this, "$packageName.provider", file)
                        val intent = Intent(Intent.ACTION_VIEW).apply {
                            setDataAndType(uri, "application/vnd.android.package-archive")
                            addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION or Intent.FLAG_ACTIVITY_NEW_TASK)
                        }
                        startActivity(intent)
                        result.success(null)
                    } catch (e: Exception) {
                        result.error("INSTALL_ERROR", e.localizedMessage, null)
                    }
                } else {
                    result.notImplemented()
                }
            }
    }
    private fun broadcastWidgetUpdate() {
        val manager = AppWidgetManager.getInstance(this)
        listOf(
            QuranWidgetProvider::class.java,
            QuranWidgetProviderLarge::class.java,
            AyahWidgetProvider::class.java
        ).forEach { providerClass ->
            val ids = try {
                manager.getAppWidgetIds(ComponentName(this, providerClass))
            } catch (e: Exception) { intArrayOf() }
            if (ids.isNotEmpty()) {
                val intent = Intent(this, providerClass).apply {
                    action = AppWidgetManager.ACTION_APPWIDGET_UPDATE
                    putExtra(AppWidgetManager.EXTRA_APPWIDGET_IDS, ids)
                }
                sendBroadcast(intent)
            }
        }
        android.util.Log.d("MainActivity", "Widget update broadcast sent")
    }
    private fun scheduleWidgetUpdate() {
        val alarmManager = getSystemService(Context.ALARM_SERVICE) as AlarmManager
        val intent = Intent(this, WidgetUpdateBroadcaster::class.java)
        val pendingIntent = PendingIntent.getBroadcast(
            this,
            0,
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )
        alarmManager.setRepeating(
            AlarmManager.ELAPSED_REALTIME_WAKEUP,
            SystemClock.elapsedRealtime() + 60000,
            60000,
            pendingIntent
        )
        android.util.Log.d("MainActivity", "Widget update alarm scheduled")
    }
}