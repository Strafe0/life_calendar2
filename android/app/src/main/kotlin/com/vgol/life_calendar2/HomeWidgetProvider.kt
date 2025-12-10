package com.vgol.life_calendar

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider
import android.view.View

class HomeWidgetProvider : HomeWidgetProvider() {

    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray, widgetData: SharedPreferences) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.home_widget_layout).apply {
                
                val weeksText = widgetData.getString("id_weeks_text", "--/--")
                val percentText = widgetData.getString("id_percent_text", "0%")
                val goalsText = widgetData.getString("id_goals_text", "Нет целей")
                val eventsText = widgetData.getString("id_events_text", "Нет событий")
                
                var progressValue = 0
                try {
                     progressValue = widgetData.getInt("id_progress_value", 0)
                } catch (e: Exception) {
                     progressValue = 0
                }

                // 2. Устанавливаем тексты
                setTextViewText(R.id.widget_weeks_text, weeksText)
                setTextViewText(R.id.widget_percent_text, percentText)
                setTextViewText(R.id.widget_goals_text, goalsText)
                setTextViewText(R.id.widget_events_text, eventsText)

                // 3. Устанавливаем прогресс полоски
                setInt(R.id.widget_linear_progress, "setProgress", progressValue)
            }

            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}