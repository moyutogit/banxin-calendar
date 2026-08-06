package com.banxincalendar.banxin_calendar.alarm

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent

class AlarmReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        val id = intent.getStringExtra("platformAlarmId") ?: intent.action ?: return
        if (!id.startsWith("banxin_")) return
        try {
            AlarmRingingService.start(
                context = context,
                platformAlarmId = id,
                title = intent.getStringExtra("title") ?: "",
                body = intent.getStringExtra("body") ?: "",
                vibrate = intent.getBooleanExtra("vibrate", true),
            )
        } catch (_: Exception) {
            AlarmRingingService.postFallbackNotification(
                context = context,
                platformAlarmId = id,
                title = intent.getStringExtra("title") ?: "",
                body = intent.getStringExtra("body") ?: "",
                vibrate = intent.getBooleanExtra("vibrate", true),
            )
        }
        AlarmScheduler.markTriggered(context, id)
    }
}
