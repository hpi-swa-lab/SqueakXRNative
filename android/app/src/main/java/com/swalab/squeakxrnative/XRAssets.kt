package com.swalab.squeakxrnative

import android.content.Context
import java.io.File

object XRAssets {
    private const val APK_ASSETS_DIR = "xr-assets"
    private const val TARGET_DIR = "assets"
    private const val STAMP_FILE = ".installed"

    fun installIfOutdated(context: Context): Boolean {
        val target = File(context.getExternalFilesDir(null)!!, TARGET_DIR)
        val stampFile = File(target, STAMP_FILE)
        val stamp = context.packageManager.getPackageInfo(context.packageName, 0).lastUpdateTime.toString()
        if (stampFile.exists() && stampFile.readText() == stamp) return true

        AppLog.info("Extracting assets to ${target.absolutePath}")
        return try {
            target.deleteRecursively()
            val count = copy(context, APK_ASSETS_DIR, target)
            stampFile.writeText(stamp)
            AppLog.info("Extracted $count asset file(s)")
            true
        } catch (e: Exception) {
            AppLog.error("Extracting assets failed: $e")
            false
        }
    }

    private fun copy(context: Context, assetPath: String, destination: File): Int {
        val children = context.assets.list(assetPath) ?: emptyArray()
        if (children.isEmpty()) {
            destination.parentFile?.mkdirs()
            context.assets.open(assetPath).use { input ->
                destination.outputStream().use { output -> input.copyTo(output) }
            }
            return 1
        }
        destination.mkdirs()
        return children.sumOf { child -> copy(context, "$assetPath/$child", File(destination, child)) }
    }
}
