package com.banxincalendar.banxin_calendar.alarm

import android.app.AlarmManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.os.Build
import com.banxincalendar.banxin_calendar.MainActivity
import org.json.JSONObject

object AlarmScheduler {
    private const val preferencesName = "banxin_managed_alarms"
    private const val managedIdsKey = "managed_ids"
    private const val triggeredIdsKey = "triggered_ids"

    fun schedule(
        context: Context,
        platformAlarmId: String,
        triggerAtEpochMillis: Long,
        payloadHash: String,
        title: String,
        body: String,
        vibrate: Boolean,
        soundId: String?,
    ) {
        require(platformAlarmId.startsWith("banxin_"))
        require(triggerAtEpochMillis > System.currentTimeMillis())
        val manager = context.getSystemService(Context.ALARM_SERVICE) as AlarmManager
        val intent = alarmIntent(
            context,
            platformAlarmId,
            title,
            body,
            vibrate,
            soundId,
        )
        val pendingIntent = PendingIntent.getBroadcast(
            context,
            platformAlarmId.hashCode(),
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
        )
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.S || manager.canScheduleExactAlarms()) {
            val showIntent = PendingIntent.getActivity(
                context,
                platformAlarmId.hashCode(),
                Intent(context, MainActivity::class.java)
                    .setAction("$platformAlarmId.show"),
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
            )
            manager.setAlarmClock(
                AlarmManager.AlarmClockInfo(triggerAtEpochMillis, showIntent),
                pendingIntent,
            )
        } else {
            manager.setAndAllowWhileIdle(
                AlarmManager.RTC_WAKEUP,
                triggerAtEpochMillis,
                pendingIntent,
            )
        }
        persist(
            context,
            platformAlarmId,
            JSONObject()
                .put("triggerAt", triggerAtEpochMillis)
                .put("payloadHash", payloadHash)
                .put("title", title)
                .put("body", body)
                .put("vibrate", vibrate)
                .put("soundId", soundId),
        )
    }

    fun cancel(context: Context, platformAlarmId: String) {
        if (!platformAlarmId.startsWith("banxin_")) return
        val manager = context.getSystemService(Context.ALARM_SERVICE) as AlarmManager
        val pendingIntent = PendingIntent.getBroadcast(
            context,
            platformAlarmId.hashCode(),
            Intent(context, AlarmReceiver::class.java).setAction(platformAlarmId),
            PendingIntent.FLAG_NO_CREATE or PendingIntent.FLAG_IMMUTABLE,
        )
        if (pendingIntent != null) {
            manager.cancel(pendingIntent)
            pendingIntent.cancel()
        }
        remove(context, platformAlarmId)
    }

    fun listManagedAlarmIds(context: Context): Set<String> =
        preferences(context).getStringSet(managedIdsKey, emptySet())?.toSet() ?: emptySet()

    @Synchronized
    fun consumeTriggeredAlarmIds(context: Context): Set<String> {
        val preferences = preferences(context)
        val ids = preferences.getStringSet(triggeredIdsKey, emptySet())?.toSet() ?: emptySet()
        if (ids.isNotEmpty()) {
            preferences.edit().remove(triggeredIdsKey).commit()
        }
        return ids
    }

    fun restore(context: Context) {
        val preferences = preferences(context)
        val ids = listManagedAlarmIds(context)
        for (id in ids) {
            val raw = preferences.getString(id, null) ?: continue
            try {
                val record = JSONObject(raw)
                val triggerAt = record.getLong("triggerAt")
                if (triggerAt <= System.currentTimeMillis()) {
                    remove(context, id)
                    continue
                }
                schedule(
                    context = context,
                    platformAlarmId = id,
                    triggerAtEpochMillis = triggerAt,
                    payloadHash = record.getString("payloadHash"),
                    title = record.getString("title"),
                    body = record.getString("body"),
                    vibrate = record.optBoolean("vibrate", true),
                    soundId = record.optString("soundId").ifBlank { null },
                )
            } catch (_: Exception) {
                remove(context, id)
            }
        }
    }

    @Synchronized
    fun markTriggered(context: Context, platformAlarmId: String) {
        val preferences = preferences(context)
        val managedIds = listManagedAlarmIds(context).toMutableSet().apply {
            remove(platformAlarmId)
        }
        val triggeredIds = preferences.getStringSet(triggeredIdsKey, emptySet())
            ?.toMutableSet()
            ?.apply { add(platformAlarmId) }
            ?: mutableSetOf(platformAlarmId)
        preferences.edit()
            .remove(platformAlarmId)
            .putStringSet(managedIdsKey, managedIds)
            .putStringSet(triggeredIdsKey, triggeredIds)
            .commit()
    }

    private fun alarmIntent(
        context: Context,
        id: String,
        title: String,
        body: String,
        vibrate: Boolean,
        soundId: String?,
    ) = Intent(context, AlarmReceiver::class.java)
        .setAction(id)
        .putExtra("platformAlarmId", id)
        .putExtra("title", title)
        .putExtra("body", body)
        .putExtra("vibrate", vibrate)
        .putExtra("soundId", soundId)

    private fun persist(context: Context, id: String, record: JSONObject) {
        val preferences = preferences(context)
        val ids = listManagedAlarmIds(context).toMutableSet().apply { add(id) }
        preferences.edit().putString(id, record.toString()).putStringSet(managedIdsKey, ids).commit()
    }

    private fun remove(context: Context, id: String) {
        val preferences = preferences(context)
        val ids = listManagedAlarmIds(context).toMutableSet().apply { remove(id) }
        preferences.edit().remove(id).putStringSet(managedIdsKey, ids).commit()
    }

    private fun preferences(context: Context) =
        context.getSharedPreferences(preferencesName, Context.MODE_PRIVATE)
}
