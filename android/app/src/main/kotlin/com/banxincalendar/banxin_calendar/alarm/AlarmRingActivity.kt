package com.banxincalendar.banxin_calendar.alarm

import android.app.Activity
import android.content.Intent
import android.graphics.Color
import android.os.Build
import android.os.Bundle
import android.view.Gravity
import android.view.ViewGroup
import android.view.WindowManager
import android.widget.Button
import android.widget.LinearLayout
import android.widget.TextView
import com.banxincalendar.banxin_calendar.R

class AlarmRingActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O_MR1) {
            setShowWhenLocked(true)
            setTurnScreenOn(true)
        } else {
            @Suppress("DEPRECATION")
            window.addFlags(
                WindowManager.LayoutParams.FLAG_SHOW_WHEN_LOCKED or
                    WindowManager.LayoutParams.FLAG_TURN_SCREEN_ON,
            )
        }
        window.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
        setContentView(buildContent())
    }

    private fun buildContent(): LinearLayout {
        val density = resources.displayMetrics.density
        fun dp(value: Int) = (value * density).toInt()
        val title = intent.getStringExtra("title").orEmpty().ifBlank {
            getString(R.string.app_name)
        }
        val body = intent.getStringExtra("body").orEmpty()

        return LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            gravity = Gravity.CENTER
            setPadding(dp(28), dp(48), dp(28), dp(48))
            setBackgroundColor(Color.rgb(18, 17, 23))
            addView(
                TextView(context).apply {
                    text = title
                    textSize = 32f
                    gravity = Gravity.CENTER
                    setTextColor(Color.WHITE)
                },
                LinearLayout.LayoutParams(
                    ViewGroup.LayoutParams.MATCH_PARENT,
                    ViewGroup.LayoutParams.WRAP_CONTENT,
                ),
            )
            addView(
                TextView(context).apply {
                    text = body
                    textSize = 18f
                    gravity = Gravity.CENTER
                    setTextColor(Color.LTGRAY)
                    setPadding(0, dp(16), 0, dp(40))
                },
                LinearLayout.LayoutParams(
                    ViewGroup.LayoutParams.MATCH_PARENT,
                    ViewGroup.LayoutParams.WRAP_CONTENT,
                ),
            )
            addView(
                Button(context).apply {
                    text = getString(R.string.alarm_stop)
                    textSize = 18f
                    minHeight = dp(56)
                    setOnClickListener { stopAlarmAndFinish() }
                },
                LinearLayout.LayoutParams(
                    ViewGroup.LayoutParams.MATCH_PARENT,
                    ViewGroup.LayoutParams.WRAP_CONTENT,
                ),
            )
        }
    }

    private fun stopAlarmAndFinish() {
        startService(
            Intent(this, AlarmRingingService::class.java)
                .setAction(AlarmRingingService.actionStop),
        )
        finishAndRemoveTask()
    }
}
