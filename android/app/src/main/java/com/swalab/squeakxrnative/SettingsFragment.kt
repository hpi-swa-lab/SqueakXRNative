package com.swalab.squeakxrnative

import android.content.Context
import android.os.Bundle
import androidx.preference.ListPreference
import androidx.preference.PreferenceFragmentCompat

class SettingsFragment: PreferenceFragmentCompat() {
    lateinit var images: Array<String>

    override fun onCreatePreferences(savedInstanceState: Bundle?, rootKey: String?) {
        setPreferencesFromResource(R.xml.preferences, rootKey)
        val selectedImagePref = findPreference<ListPreference>("selected_image")!!
        selectedImagePref.entries = images
        selectedImagePref.entryValues = images
    }

    override fun onAttach(context: Context) {
        super.onAttach(context)

        images = Utils.getImageFiles(context).toTypedArray()
    }
}