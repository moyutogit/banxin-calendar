package com.banxincalendar.banxin_calendar

import android.Manifest
import android.app.AlarmManager
import android.app.NotificationManager
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import android.provider.Settings
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import com.banxincalendar.banxin_calendar.alarm.AlarmScheduler
import com.banxincalendar.banxin_calendar.alarm.AlarmRingingService
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val channelName = "banxin_calendar/alarm"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "capability" -> result.success(alarmCapability())
                    "requestCapability" -> {
                        requestAlarmCapability()
                        result.success(alarmCapability())
                    }
                    "schedule" -> {
                        try {
                            AlarmScheduler.schedule(
                                context = this,
                                platformAlarmId = call.argument<String>("platformAlarmId")!!,
                                triggerAtEpochMillis = call.argument<Number>("triggerAtEpochMillis")!!.toLong(),
                                payloadHash = call.argument<String>("payloadHash")!!,
                                title = call.argument<String>("title") ?: getString(R.string.app_name),
                                body = call.argument<String>("body") ?: "",
                                vibrate = call.argument<Boolean>("vibrate") ?: true,
                                soundId = call.argument<String>("soundId"),
                            )
                            result.success(null)
                        } catch (error: Exception) {
                            result.error("alarm_schedule_failed", error.javaClass.simpleName, null)
                        }
                    }
                    "cancel" -> {
                        AlarmScheduler.cancel(
                            this,
                            call.argument<String>("platformAlarmId")!!,
                        )
                        result.success(null)
                    }
                    "listManagedAlarmIds" -> result.success(
                        AlarmScheduler.listManagedAlarmIds(this).toList(),
                    )
                    "consumeTriggeredAlarmIds" -> result.success(
                        AlarmScheduler.consumeTriggeredAlarmIds(this).toList(),
                    )
                    else -> result.notImplemented()
                }
            }
    }

    private fun alarmCapability(): String {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU &&
            ContextCompat.checkSelfPermission(this, Manifest.permission.POST_NOTIFICATIONS) !=
            PackageManager.PERMISSION_GRANTED
        ) {
            return "permissionRequired"
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            val manager = getSystemService(Context.ALARM_SERVICE) as AlarmManager
            if (!manager.canScheduleExactAlarms()) return "permissionRequired"
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val notifications = getSystemService(NotificationManager::class.java)
            val channel = notifications.getNotificationChannel(AlarmRingingService.channelId)
            if (channel != null && channel.importance == NotificationManager.IMPORTANCE_NONE) {
                return "permissionRequired"
            }
        }
        return "available"
    }

    private fun requestAlarmCapability() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU &&
            ContextCompat.checkSelfPermission(this, Manifest.permission.POST_NOTIFICATIONS) !=
            PackageManager.PERMISSION_GRANTED
        ) {
            ActivityCompat.requestPermissions(
                this,
                arrayOf(Manifest.permission.POST_NOTIFICATIONS),
                notificationRequestCode,
            )
            return
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            val manager = getSystemService(Context.ALARM_SERVICE) as AlarmManager
            if (!manager.canScheduleExactAlarms()) {
                startActivity(
                    Intent(
                        Settings.ACTION_REQUEST_SCHEDULE_EXACT_ALARM,
                        Uri.parse("package:$packageName"),
                    ),
                )
                return
            }
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val notifications = getSystemService(NotificationManager::class.java)
            val channel = notifications.getNotificationChannel(AlarmRingingService.channelId)
            if (channel != null && channel.importance == NotificationManager.IMPORTANCE_NONE) {
                startActivity(
                    Intent(Settings.ACTION_CHANNEL_NOTIFICATION_SETTINGS)
                        .putExtra(Settings.EXTRA_APP_PACKAGE, packageName)
                        .putExtra(Settings.EXTRA_CHANNEL_ID, AlarmRingingService.channelId),
                )
            }
        }
    }

    companion object {
        private const val notificationRequestCode = 7301
    }
}
