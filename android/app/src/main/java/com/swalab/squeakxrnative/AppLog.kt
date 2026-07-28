package com.swalab.squeakxrnative

import android.os.Handler
import android.os.Looper
import android.util.Log
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale

object AppLog {
    private const val TAG = "SqueakXRLauncher"
    private const val MAX_LINES = 300

    private val lines = ArrayDeque<String>()
    private val mainHandler = Handler(Looper.getMainLooper())
    private val timestampFormat = SimpleDateFormat("HH:mm:ss", Locale.US)

    private var listener: (() -> Unit)? = null

    fun info(message: String) = append(message, isError = false)

    fun error(message: String) = append(message, isError = true)

    @Synchronized
    private fun append(message: String, isError: Boolean) {
        if (isError) Log.e(TAG, message) else Log.i(TAG, message)

        val prefix = if (isError) "! " else "  "
        lines.addLast(timestampFormat.format(Date()) + prefix + message)
        while (lines.size > MAX_LINES) {
            lines.removeFirst()
        }

        listener?.let { mainHandler.post(it) }
    }

    @Synchronized
    fun contents(): String = lines.joinToString("\n")

    /** Pass null on pause, otherwise this object outlives the view hierarchy. */
    @Synchronized
    fun setListener(newListener: (() -> Unit)?) {
        listener = newListener
    }

    @Synchronized
    fun clear() {
        lines.clear()
        listener?.let { mainHandler.post(it) }
    }
}
