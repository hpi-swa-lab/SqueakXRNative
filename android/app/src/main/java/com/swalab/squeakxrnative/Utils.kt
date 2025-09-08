package com.swalab.squeakxrnative

import android.content.Context
import com.swalab.squeakxrnative.ManageImagesActivity.ImageInfo

class Utils {
    companion object Static {
        fun getImageFiles(context: Context): List<String> {
            val externalFilesDir = context.getExternalFilesDir(null)
            val externalFiles = externalFilesDir?.list() ?: emptyArray()
            return externalFiles.filter { file -> file.endsWith(".image" )}
        }
    }
}