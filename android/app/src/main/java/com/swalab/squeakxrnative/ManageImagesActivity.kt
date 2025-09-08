package com.swalab.squeakxrnative

import android.media.Image
import android.os.Bundle
import android.provider.ContactsContract.CommonDataKinds.Im
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.TextView
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView

class ManageImagesActivity : AppCompatActivity() {
    class ImageInfo(var fileName: String) {

    }

    class ImageInfoAdapter(var images: List<ImageInfo>) : RecyclerView.Adapter<ImageInfoAdapter.ViewHolder>() {
        inner class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
            val imageNameView = itemView.findViewById<TextView>(R.id.imageName)
            val duplicateButton = itemView.findViewById<Button>(R.id.duplicateImage)
            val removeButton = itemView.findViewById<Button>(R.id.removeImage)

            init {
                duplicateButton.isEnabled = false
                duplicateButton.isClickable = false
                removeButton.isEnabled = false
                removeButton.isClickable = false
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
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_manage_images)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        val imageFiles = Utils.getImageFiles(this)
            .map { file -> ImageInfo(file) }

        val recyclerView: RecyclerView = findViewById(R.id.manageImagesRecyclerView)
        recyclerView.adapter = ImageInfoAdapter(imageFiles)
        recyclerView.layoutManager = LinearLayoutManager(this)
    }
}