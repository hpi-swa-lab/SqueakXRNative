package com.swalab.squeakxrnative

import android.media.Image
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.provider.ContactsContract.CommonDataKinds.Im
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.EditText
import android.widget.TextView
import android.widget.Toast
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import androidx.preference.PreferenceManager
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
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

class ManageImagesActivity : AppCompatActivity() {
    class ImageInfo(var fileName: String) {
        fun changesFile(): String {
            return fileName.removeSuffix(".image") + ".changes"
        }
    }

    class ImageInfoAdapter(var images: MutableList<ImageInfo>, var externalFiles: File) : RecyclerView.Adapter<ImageInfoAdapter.ViewHolder>() {
        inner class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
            val imageNameView = itemView.findViewById<TextView>(R.id.imageName)
            val duplicateButton = itemView.findViewById<Button>(R.id.duplicateImage)
            val removeButton = itemView.findViewById<Button>(R.id.removeImage)

            init {
                duplicateButton.isEnabled = false
                duplicateButton.isClickable = false
            }
        }

        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ImageInfoAdapter.ViewHolder {
            val context = parent.context
            val inflater = LayoutInflater.from(context)
            val view = inflater.inflate(R.layout.image_layout, parent, false)
            return ViewHolder(view)
        }

        override fun getItemCount(): Int {
            return images.size
        }

        override fun onBindViewHolder(holder: ImageInfoAdapter.ViewHolder, position: Int) {
            val image = images[position]

            holder.imageNameView.text = image.fileName
            holder.removeButton.setOnClickListener {
                println("removing $position ${image.fileName}")
                File(externalFiles.absolutePath + "/" + image.fileName).delete()
                File(externalFiles.absolutePath + "/" + image.changesFile()).delete()
                images.removeAt(position)
                notifyItemRemoved(position)
                notifyItemRangeChanged(position, images.size - position)
            }
        }
    }

    lateinit var fetchUrl: EditText
    lateinit var fetchName: EditText
    lateinit var fetchButton: Button
    lateinit var imageFiles: MutableList<ImageInfo>

    @OptIn(DelicateCoroutinesApi::class)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_manage_images)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        imageFiles = Utils.getImageFiles(this)
            .sorted()
            .map { file -> ImageInfo(file) }
            .toMutableList()

        val recyclerView: RecyclerView = findViewById(R.id.manageImagesRecyclerView)
        recyclerView.adapter = ImageInfoAdapter(imageFiles, getExternalFilesDir(null)!!)
        recyclerView.layoutManager = LinearLayoutManager(this)

        fetchUrl = findViewById(R.id.fetchUrl)
        fetchName = findViewById(R.id.fetchName)
        fetchButton = findViewById(R.id.fetchButton)

        fetchButton.setOnClickListener {
            fetchButton.isEnabled = false
            fetchButton.isClickable = false
            val fetchImagesFailedToast = Toast.makeText(this, getString(R.string.fetching_images_failed), Toast.LENGTH_SHORT)
            GlobalScope.launch {
                val (success, fetchedImageName) = Utils.fetchImageFromRemote(fetchUrl.text.toString(), fetchName.text.toString(), false, getExternalFilesDir(null)!!)
                if (success) {
                    imageFiles.add(ImageInfo(fetchedImageName))
                } else {
                    fetchImagesFailedToast.show()
                }
                Handler(Looper.getMainLooper()).post {
                    if (success) {
                        recyclerView.adapter?.notifyItemChanged(imageFiles.size - 1)
                    }
                    fetchButton.isEnabled = true
                    fetchButton.isClickable = true
                }
            }
        }
    }
}