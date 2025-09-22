package com.swalab.squeakxrnative

import android.content.Intent
import android.content.res.AssetManager
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.os.Environment
import android.os.Handler
import android.os.Looper
import android.widget.Toast
import androidx.preference.PreferenceManager
import com.swalab.squeakxrnative.databinding.ActivityMainBinding
import kotlinx.coroutines.DelicateCoroutinesApi
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import java.io.File
import java.io.FileOutputStream

class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        binding.button.setOnClickListener {
            launchXrCoroutine()
        }

        binding.manageImagesButton.setOnClickListener {
            val intent = Intent(this, ManageImagesActivity::class.java)
            startActivity(intent);
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
        val setButtonEnabled = {enabled: Boolean ->
            binding.button.isEnabled = enabled
            binding.button.isClickable = enabled
        }
        setButtonEnabled(false)

        val preferences = PreferenceManager.getDefaultSharedPreferences(this)
        val fetchImageOnLaunch = preferences.getBoolean("fetch_image_on_launch", false)
        var selectedImage: String

        if (fetchImageOnLaunch) {
            selectedImage = "Squeak6.0-22148-64bit.image"
        } else {
            selectedImage = preferences.getString("selected_image", "")!!
            if (selectedImage.isEmpty()) {
                System.err.println(getString(R.string.no_image_selected))
                Toast.makeText(this, getString(R.string.no_image_selected), Toast.LENGTH_SHORT).show()
                setButtonEnabled(true)
                return
            }
        }

        val fetchImagesFailedToast = Toast.makeText(this, getString(R.string.fetching_images_failed), Toast.LENGTH_SHORT)
        GlobalScope.launch {
            var setupSuccessful = true
            if (fetchImageOnLaunch) {
                val fetchResult = Utils.fetchImageFromRemote("http://localhost:8080", selectedImage/*preferences.getString("selected_image", "")!!*/, true, getExternalFilesDir(null)!!)
                if (!fetchResult.first) {
                    setupSuccessful = false
                    System.err.println(getString(R.string.fetching_images_failed))
                    fetchImagesFailedToast.show()
                }
            }
            if (setupSuccessful) {
                finish()
                delay(1000)
                startXr(selectedImage)
            } else {
                Handler(Looper.getMainLooper()).post {
                    setButtonEnabled(true)
                }
            }
        }
    }

    private fun startXr(imageFileName: String) {
        storeImagePath(getExternalFilesDir(null)!!.absolutePath + "/" + imageFileName)
        val preferences = PreferenceManager.getDefaultSharedPreferences(this)
        storeStartScript(preferences.getString("start_script", "")!!)

        val intent = Intent(this, VrActivity::class.java)
        startActivity(intent);
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
        val fileStatus = /*squeakImageFiles.values*/arrayOf(squeakImageFiles["sources"]).joinToString("\n" ) { file ->
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