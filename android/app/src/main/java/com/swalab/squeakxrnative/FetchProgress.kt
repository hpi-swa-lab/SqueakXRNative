package com.swalab.squeakxrnative

import android.view.View
import android.widget.ProgressBar
import android.widget.TextView

/** The download progress bar and byte counter, as used by both activities. */
class FetchProgress(private val bar: ProgressBar, private val text: TextView) {

    fun show(visible: Boolean) {
        val visibility = if (visible) View.VISIBLE else View.GONE
        bar.visibility = visibility
        text.visibility = visibility
        if (visible) {
            bar.isIndeterminate = true
            text.text = bar.context.getString(R.string.fetch_starting)
        }
    }

    /** Determinate once the server has told us a total. */
    fun update(downloaded: Long, total: Long) {
        val mib = 1024 * 1024
        if (total > 0) {
            bar.isIndeterminate = false
            bar.progress = ((downloaded * 100) / total).toInt()
            text.text = "${downloaded / mib} / ${total / mib} MiB"
        } else {
            text.text = "${downloaded / mib} MiB"
        }
    }
}
