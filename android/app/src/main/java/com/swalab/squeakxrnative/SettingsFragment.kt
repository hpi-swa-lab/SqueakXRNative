package com.swalab.squeakxrnative

import android.content.Context
import android.os.Bundle
import androidx.preference.ListPreference
import androidx.preference.PreferenceFragmentCompat

class SettingsFragment: PreferenceFragmentCompat() {
    lateinit var outerContext: Context

    override fun onCreatePreferences(savedInstanceState: Bundle?, rootKey: String?) {
        setPreferencesFromResource(R.xml.preferences, rootKey)
    }

    override fun onAttach(context: Context) {
        outerContext = context
        super.onAttach(outerContext)
    }

    override fun onResume() {
        super.onResume()

        val images = Utils.getImageFiles(outerContext).sorted().toTypedArray()
        val selectedImagePref = findPreference<ListPreference>("selected_image")!!
        if (!images.contains(selectedImagePref.value)) {
            selectedImagePref.value = null
        }
        selectedImagePref.entries = images
        selectedImagePref.entryValues = images
    }
}