package com.swalab.squeakxrnative

import android.content.Context
import kotlinx.coroutines.async
import kotlinx.coroutines.awaitAll
import kotlinx.coroutines.coroutineScope
import java.io.BufferedInputStream
import java.io.File
import java.io.FileOutputStream
import java.net.HttpURLConnection
import java.net.URL

class Utils {
    companion object {
        fun getImageFiles(context: Context): List<String> {
            val externalFilesDir = context.getExternalFilesDir(null)
            val externalFiles = externalFilesDir?.list() ?: emptyArray()
            return externalFiles.filter { file -> file.endsWith(".image" )}
        }

        suspend fun fetchImageFromRemote(fetchUrl: String, remoteImageName: String, forceOverwrite: Boolean, externalFiles: File): Pair<Boolean, String> {
            val localImageName = if (forceOverwrite) remoteImageName else getNextFileName(remoteImageName, externalFiles)
            val remoteChangesName = remoteImageName.removeSuffix(".image") + ".changes"
            val localChangesName = localImageName.removeSuffix(".image") + ".changes"

            val results = coroutineScope {
                awaitAll(async {
                    fetchRemoteFile("$fetchUrl/$remoteImageName", localImageName, externalFiles)
                }, async {
                    fetchRemoteFile("$fetchUrl/$remoteChangesName", localChangesName, externalFiles)
                })
            }

            return Pair(results.all { it }, localImageName)
        }

        private fun getNextFileName(filename: String, externalFiles: File): String {
            val list = externalFiles.list()!!
            val filenameBase = filename.removeSuffix(".image")
            val regex = "$filenameBase \\((.*)\\).image$".toRegex()
            val version = list
                .mapNotNull { name -> regex.matchEntire(name)?.groupValues?.get(1)?.toInt()}
                .maxOrNull() ?: 0
            return if (version == 0 && !list.contains(filename))
                filename
            else
                filenameBase + " (${version + 1}).image"
        }

        private fun fetchRemoteFile(urlString: String, filename: String, externalFiles: File): Boolean {
            println("Fetching $urlString and saving to $filename")
            var success = false;
            val url = URL(urlString)
            val connection = url.openConnection() as HttpURLConnection
            try {
                val inStream = BufferedInputStream(connection.inputStream)
                val externalFile = File(externalFiles, filename)
                val outStream = FileOutputStream(externalFile)
                inStream.use {
                    outStream.use {
                        inStream.copyTo(outStream)
                    }
                }
                success = true;
            } catch (e: Exception) {
                System.err.println("Fetching failed: $e")
            } finally {
                connection.disconnect()
            }

            return success;
        }
    }
}