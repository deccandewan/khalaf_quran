package com.abuhashim.khalafquran

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.appwidget.AppWidgetManager

class WidgetUpdateBroadcaster : BroadcastReceiver() {
    override fun onReceive(context: Context?, intent: Intent?) {
        if (context == null) return
        
        android.util.Log.d("WidgetUpdateBroadcaster", "Alarm triggered, updating widgets")
        
        // Update small widget
        val smallWidgetIntent = Intent(context, QuranWidgetProvider::class.java).apply {
            action = AppWidgetManager.ACTION_APPWIDGET_UPDATE
        }
        context.sendBroadcast(smallWidgetIntent)
        
        // Update large widget
        val largeWidgetIntent = Intent(context, QuranWidgetProviderLarge::class.java).apply {
            action = AppWidgetManager.ACTION_APPWIDGET_UPDATE
        }
        context.sendBroadcast(largeWidgetIntent)

        // Update Ayah widget
        val ayahWidgetIntent = Intent(context, AyahWidgetProvider::class.java).apply {
            action = AppWidgetManager.ACTION_APPWIDGET_UPDATE
        }
        context.sendBroadcast(ayahWidgetIntent)
    }
}
