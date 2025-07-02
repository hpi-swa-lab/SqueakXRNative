package com.swalab.squeakxrnative

import android.app.Activity
import android.content.Intent
import android.content.res.AssetManager
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.os.Environment
import android.os.Handler
import android.os.Looper
import android.widget.TextView
import androidx.preference.PreferenceManager
import com.swalab.squeakxrnative.databinding.ActivityMainBinding
import kotlinx.coroutines.DelicateCoroutinesApi
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.async
import kotlinx.coroutines.awaitAll
import kotlinx.coroutines.coroutineScope
import kotlinx.coroutines.launch
import java.io.BufferedInputStream
import java.io.File
import java.io.FileOutputStream
import java.net.HttpURLConnection
import java.net.URL

class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        storeImagePath(getExternalFilesDir(null)!!.absolutePath + "/" + squeakImageFiles["image"]!!)

        binding.button.setOnClickListener {
//            launch(getExternalFilesDir(null)!!.absolutePath + "/" + "not needed, pls remove")
            launchXrCoroutine()
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

        if (PreferenceManager.getDefaultSharedPreferences(this).getBoolean("launch_into_xr", false)) {
            launchXrCoroutine()
        }
    }

    @OptIn(DelicateCoroutinesApi::class)
    private fun launchXrCoroutine() {
        // The delay allows the Activity to handle the initial app focus event.
        // If we don't do this and click the Launch button first thing, the app will be killed.
        // A better way might be to do event polling inside of Squeak.
        Handler(Looper.getMainLooper()).postDelayed({
            GlobalScope.launch {
                startXr()
            }
        }, 1000)
        finish()
    }

    private suspend fun startXr() {
        val preferences = PreferenceManager.getDefaultSharedPreferences(this)
        storeStartScript(preferences.getString("start_script", "")!!)

        if (preferences.getBoolean("fetch_image_on_launch", false)) {
            if (!fetchImageFromRemote()) {
                throw RuntimeException("Fetching images failed!")
            }
        }

        val intent = Intent(this, VrActivity::class.java)
        startActivity(intent);
    }

    private suspend fun fetchImageFromRemote(): Boolean {
        val urlString =
            PreferenceManager.getDefaultSharedPreferences(this).getString("fetch_image_url", null)
                ?: throw RuntimeException("URL base is null")
        val imageName =
            PreferenceManager.getDefaultSharedPreferences(this).getString("fetch_image_name", null)
                ?: throw RuntimeException("URL base is null")
        val changesName =
            PreferenceManager.getDefaultSharedPreferences(this).getString("fetch_changes_name", null)
                ?: throw RuntimeException("URL base is null")

        val results = coroutineScope {
            awaitAll(async {
                fetchRemoteFile("$urlString/$imageName", squeakImageFiles["image"]!!)
            }, async {
                fetchRemoteFile("$urlString/$changesName", squeakImageFiles["changes"]!!)
            })
        }

        return results.all {it}
    }

    private fun fetchRemoteFile(urlString: String, filename: String): Boolean {
        println("Fetching $urlString and saving to $filename")
        var success = false;
        val url = URL(urlString)
        val connection = url.openConnection() as HttpURLConnection
        try {
            val inStream = BufferedInputStream(connection.inputStream)
            val externalFile = File(getExternalFilesDir(null)!!, filename)
            val outStream = FileOutputStream(externalFile)
            inStream.use {
                outStream.use {
                    inStream.copyTo(outStream)
                }
            }
            success = true;
        } catch(e: Exception) {
            System.err.println("Fetching failed: $e")
        } finally {
            connection.disconnect()
        }

        return success;
    }

    private val squeakImageFiles = mapOf(
        "changes" to "Squeak6.0-22148-64bit.changes",
        "image" to "Squeak6.0-22148-64bit.image",
//        "changes" to "squeak-ffi-test.changes",
//        "image" to "squeak-ffi-test.image",
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

    external fun launch(imagePath: String)
    external fun storeImagePath(imagePath: String)
    external fun storeStartScript(startScript: String)

    companion object {
        // Used to load the 'squeakxrnative' library on application startup.
        init {
            System.loadLibrary("squeakxrnative")
        }
    }
}