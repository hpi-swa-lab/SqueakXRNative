package com.swalab.squeakxrnative

import android.content.res.AssetManager
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.os.Environment
import android.widget.TextView
import com.swalab.squeakxrnative.databinding.ActivityMainBinding
import java.io.File
import java.io.FileOutputStream

class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        // Example of a call to a native method
        binding.sampleText.text = stringFromJNI()

        binding.button.setOnClickListener {
            println("Button pressed")
            launch(getExternalFilesDir(null)!!.absolutePath + "/" + "Squeak6.0-22148-64bit.image")
        }

        updateImageInfo()

        binding.buttonResetImage.setOnClickListener {
            for (filename in squeakImageFiles.values) {
                val inStream = assets.open(filename, AssetManager.ACCESS_BUFFER)
                val externalFile = File(getExternalFilesDir(null)!!, filename)
                println("Copying $filename to ${externalFile.absolutePath}")
                val outStream = FileOutputStream(externalFile)
                inStream.copyTo(outStream)
                inStream.close()
                outStream.close()
            }
        }
    }

    private val squeakImageFiles = mapOf(
        "changes" to "Squeak6.0-22148-64bit.changes",
        "image" to "Squeak6.0-22148-64bit.image",
        "sources" to "SqueakV60.sources"
    )

    private fun updateImageInfo() {
        var externalStorageDesc = "not readable or writable"
        if (Environment.getExternalStorageState() == Environment.MEDIA_MOUNTED) {
            externalStorageDesc = "writeable"
        } else if (Environment.getExternalStorageState() == Environment.MEDIA_MOUNTED_READ_ONLY) {
            externalStorageDesc = "read only"
        }

        val externalFilesDir = getExternalFilesDir(null)
        val externalFiles = externalFilesDir?.list() ?: emptyArray()

        val assetFiles: List<String> = assets.list("")?.map { file -> file.toString() } ?: emptyList<String>()
        val fileStatus = squeakImageFiles.values.joinToString("\n" ) { file ->
            val presentInAssetManager = "${if (file in assetFiles) "" else "not"} present in AssetManager"
            val presentInExternalStorage = "${if (file in externalFiles) "" else "not"} present in ExternalStorage"
            "\t$file\n\t\t$presentInAssetManager\n\t\t$presentInExternalStorage"
        }

        binding.textImageStatus.text = "External storage: $externalStorageDesc\nExternal storage dir: $externalFilesDir\nFile status:\n$fileStatus"
    }

    /**
     * A native method that is implemented by the 'squeakxrnative' native library,
     * which is packaged with this application.
     */
    external fun stringFromJNI(): String
    external fun launch(imagePath: String)

    companion object {
        // Used to load the 'squeakxrnative' library on application startup.
        init {
            System.loadLibrary("squeakxrnative")
        }
    }
}