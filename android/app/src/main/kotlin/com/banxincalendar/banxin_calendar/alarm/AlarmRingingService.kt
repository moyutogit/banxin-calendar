package com.banxincalendar.banxin_calendar.alarm

import android.Manifest
import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.Color
import android.media.AudioAttributes
import android.media.MediaPlayer
import android.media.RingtoneManager
import android.os.Build
import android.os.Handler
import android.os.IBinder
import android.os.Looper
import android.os.PowerManager
import android.os.VibrationEffect
import android.os.Vibrator
import android.os.VibratorManager
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import androidx.core.content.ContextCompat
import com.banxincalendar.banxin_calendar.R

class AlarmRingingService : Service() {
    private val timeoutHandler = Handler(Looper.getMainLooper())
    private var mediaPlayer: MediaPlayer? = null
    private var vibrator: Vibrator? = null
    private var currentNotificationId: Int? = null

    override fun onBind(intent: Intent?): IBinder? = null

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        if (intent?.action == actionStop) {
            stopRinging()
            return START_NOT_STICKY
        }

        val platformAlarmId = intent?.getStringExtra(extraAlarmId) ?: return START_NOT_STICKY
        if (!platformAlarmId.startsWith("banxin_")) return START_NOT_STICKY
        val title = intent.getStringExtra(extraTitle).orEmpty().ifBlank {
            getString(R.string.app_name)
        }
        val body = intent.getStringExtra(extraBody).orEmpty()
        val vibrate = intent.getBooleanExtra(extraVibrate, true)
        val notificationId = platformAlarmId.hashCode()
        currentNotificationId = notificationId

        createChannel(this)
        startForeground(
            notificationId,
            buildNotification(this, platformAlarmId, title, body, vibrate),
        )
        startSound()
        if (vibrate) startVibration()
        timeoutHandler.removeCallbacksAndMessages(null)
        timeoutHandler.postDelayed(::stopRinging, maximumRingDurationMillis)
        return START_NOT_STICKY
    }

    override fun onDestroy() {
        timeoutHandler.removeCallbacksAndMessages(null)
        releaseAlertingResources()
        super.onDestroy()
    }

    private fun startSound() {
        releaseMediaPlayer()
        val alarmUri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_ALARM)
            ?: RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION)
            ?: return
        try {
            mediaPlayer = MediaPlayer().apply {
                setAudioAttributes(
                    AudioAttributes.Builder()
                        .setUsage(AudioAttributes.USAGE_ALARM)
                        .setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION)
                        .build(),
                )
                setDataSource(applicationContext, alarmUri)
                isLooping = true
                setWakeMode(applicationContext, PowerManager.PARTIAL_WAKE_LOCK)
                prepare()
                start()
            }
        } catch (_: Exception) {
            releaseMediaPlayer()
        }
    }

    private fun startVibration() {
        vibrator = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            getSystemService(VibratorManager::class.java).defaultVibrator
        } else {
            @Suppress("DEPRECATION")
            getSystemService(Context.VIBRATOR_SERVICE) as Vibrator
        }
        val effect = VibrationEffect.createWaveform(
            longArrayOf(0, 700, 350, 700),
            0,
        )
        vibrator?.vibrate(effect)
    }

    private fun stopRinging() {
        timeoutHandler.removeCallbacksAndMessages(null)
        releaseAlertingResources()
        currentNotificationId?.let {
            NotificationManagerCompat.from(this).cancel(it)
        }
        stopForeground(STOP_FOREGROUND_REMOVE)
        stopSelf()
    }

    private fun releaseAlertingResources() {
        releaseMediaPlayer()
        vibrator?.cancel()
        vibrator = null
    }

    private fun releaseMediaPlayer() {
        mediaPlayer?.runCatching {
            if (isPlaying) stop()
            release()
        }
        mediaPlayer = null
    }

    companion object {
        const val channelId = "banxin_schedule_alarms_v2"
        private const val extraAlarmId = "platformAlarmId"
        private const val extraTitle = "title"
        private const val extraBody = "body"
        private const val extraVibrate = "vibrate"
        private const val actionStart = "banxin.alarm.START"
        const val actionStop = "banxin.alarm.STOP"
        private const val maximumRingDurationMillis = 10 * 60 * 1000L

        fun start(
            context: Context,
            platformAlarmId: String,
            title: String,
            body: String,
            vibrate: Boolean,
        ) {
            val intent = serviceIntent(
                context,
                platformAlarmId,
                title,
                body,
                vibrate,
            )
            ContextCompat.startForegroundService(context, intent)
        }

        fun postFallbackNotification(
            context: Context,
            platformAlarmId: String,
            title: String,
            body: String,
            vibrate: Boolean,
        ) {
            createChannel(context)
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU &&
                ContextCompat.checkSelfPermission(
                    context,
                    Manifest.permission.POST_NOTIFICATIONS,
                ) != PackageManager.PERMISSION_GRANTED
            ) {
                return
            }
            NotificationManagerCompat.from(context).notify(
                platformAlarmId.hashCode(),
                buildNotification(context, platformAlarmId, title, body, vibrate),
            )
        }

        private fun serviceIntent(
            context: Context,
            platformAlarmId: String,
            title: String,
            body: String,
            vibrate: Boolean,
        ) = Intent(context, AlarmRingingService::class.java)
            .setAction(actionStart)
            .putExtra(extraAlarmId, platformAlarmId)
            .putExtra(extraTitle, title)
            .putExtra(extraBody, body)
            .putExtra(extraVibrate, vibrate)

        private fun buildNotification(
            context: Context,
            platformAlarmId: String,
            title: String,
            body: String,
            vibrate: Boolean,
        ): Notification {
            val ringIntent = Intent(context, AlarmRingActivity::class.java)
                .setAction("$platformAlarmId.ring")
                .putExtra(extraAlarmId, platformAlarmId)
                .putExtra(extraTitle, title)
                .putExtra(extraBody, body)
            val ringPendingIntent = PendingIntent.getActivity(
                context,
                platformAlarmId.hashCode(),
                ringIntent,
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
            )
            val stopIntent = Intent(context, AlarmRingingService::class.java)
                .setAction(actionStop)
                .putExtra(extraAlarmId, platformAlarmId)
            val stopPendingIntent = PendingIntent.getService(
                context,
                platformAlarmId.hashCode(),
                stopIntent,
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
            )
            return NotificationCompat.Builder(context, channelId)
                .setSmallIcon(R.mipmap.ic_launcher)
                .setContentTitle(title.ifBlank { context.getString(R.string.app_name) })
                .setContentText(body.ifBlank { context.getString(R.string.alarm_ringing) })
                .setContentIntent(ringPendingIntent)
                .setFullScreenIntent(ringPendingIntent, true)
                .setCategory(NotificationCompat.CATEGORY_ALARM)
                .setPriority(NotificationCompat.PRIORITY_MAX)
                .setVisibility(NotificationCompat.VISIBILITY_PUBLIC)
                .setOngoing(true)
                .setAutoCancel(false)
                .setVibrate(if (vibrate) longArrayOf(0, 700, 350, 700) else null)
                .addAction(0, context.getString(R.string.alarm_stop), stopPendingIntent)
                .build()
        }

        private fun createChannel(context: Context) {
            if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O) return
            val manager = context.getSystemService(NotificationManager::class.java)
            if (manager.getNotificationChannel(channelId) != null) return
            val alarmUri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_ALARM)
            val audioAttributes = AudioAttributes.Builder()
                .setUsage(AudioAttributes.USAGE_ALARM)
                .setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION)
                .build()
            manager.createNotificationChannel(
                NotificationChannel(
                    channelId,
                    context.getString(R.string.alarm_channel_name),
                    NotificationManager.IMPORTANCE_HIGH,
                ).apply {
                    description = context.getString(R.string.alarm_channel_description)
                    enableLights(true)
                    lightColor = Color.rgb(179, 178, 255)
                    enableVibration(true)
                    vibrationPattern = longArrayOf(0, 700, 350, 700)
                    setSound(alarmUri, audioAttributes)
                    lockscreenVisibility = Notification.VISIBILITY_PUBLIC
                },
            )
        }
    }
}
