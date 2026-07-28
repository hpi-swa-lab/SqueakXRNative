package com.swalab.squeakxrnative

import android.content.Context
import android.net.Uri
import kotlinx.coroutines.async
import kotlinx.coroutines.awaitAll
import kotlinx.coroutines.coroutineScope
import java.io.BufferedInputStream
import java.io.ByteArrayOutputStream
import java.io.File
import java.io.FileOutputStream
import java.net.HttpURLConnection
import java.net.URL
import java.net.URLDecoder
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale
import java.util.concurrent.atomic.AtomicLong

data class RemoteImage(
    val name: String,
    val lastModified: Long,
    val sizeBytes: Long
) {
    fun label(): String {
        val details = mutableListOf<String>()
        if (sizeBytes >= 0) details.add(formatSize(sizeBytes))
        if (lastModified > 0) {
            details.add(SimpleDateFormat("yyyy-MM-dd HH:mm", Locale.US).format(Date(lastModified)))
        }
        return if (details.isEmpty()) name else "$name   (${details.joinToString(", ")})"
    }

    private fun formatSize(bytes: Long): String {
        val mib = bytes.toDouble() / (1024 * 1024)
        return if (mib >= 1024) {
            String.format(Locale.US, "%.1f GiB", mib / 1024)
        } else {
            String.format(Locale.US, "%.0f MiB", mib)
        }
    }
}

class Utils {
    companion object {
        const val PREF_FETCH_URL = "fetch_image_url"
        const val DEFAULT_FETCH_URL = "http://localhost:8080"

        private val HREF_REGEX = Regex("""href\s*=\s*["']([^"']+)["']""", RegexOption.IGNORE_CASE)

        private val BARE_NAME_REGEX = Regex("""[^\s"'<>]+\.image""", RegexOption.IGNORE_CASE)

        private const val LISTING_CONNECT_TIMEOUT_MS = 5000
        private const val LISTING_READ_TIMEOUT_MS = 10000
        private const val LISTING_MAX_BYTES = 4 * 1024 * 1024

        private const val PROBE_BATCH_SIZE = 8
        private const val PROBE_CONNECT_TIMEOUT_MS = 5000
        private const val PROBE_READ_TIMEOUT_MS = 5000
        private const val PROGRESS_INTERVAL_MS = 200

        fun getImageFiles(context: Context): List<String> {
            val externalFilesDir = context.getExternalFilesDir(null)
            val externalFiles = externalFilesDir?.list() ?: emptyArray()
            return externalFiles.filter { file -> file.endsWith(".image" )}
        }

        suspend fun listRemoteImages(fetchUrl: String): List<RemoteImage> {
            val body = fetchRemoteText(fetchUrl) ?: return emptyList()

            val hrefs = HREF_REGEX.findAll(body).map { it.groupValues[1] }.toList()
            val candidates = hrefs.ifEmpty {
                BARE_NAME_REGEX.findAll(body).map { it.value }.toList()
            }

            val names = candidates
                .map { toFileName(it) }
                .filter { it.endsWith(".image", ignoreCase = true) }
                .distinct()

            if (names.isEmpty()) {
                AppLog.info("Server lists no images")
                return emptyList()
            }

            val baseUrl = fetchUrl.trimEnd('/')
            val probed = mutableListOf<RemoteImage>()
            var unavailable = 0
            for (batch in names.chunked(PROBE_BATCH_SIZE)) {
                val results = coroutineScope {
                    batch.map { name -> async { probeRemoteImage(baseUrl, name) } }.awaitAll()
                }
                results.forEach { if (it == null) unavailable++ else probed.add(it) }
            }

            AppLog.info(
                "Server lists ${probed.size} image(s)" +
                    if (unavailable > 0) ", $unavailable listed but not available" else ""
            )
            return probed.sortedWith(
                compareByDescending<RemoteImage> { it.lastModified }.thenBy { it.name.lowercase() }
            )
        }

        private fun probeRemoteImage(baseUrl: String, name: String): RemoteImage? {
            val urlString = "$baseUrl/${Uri.encode(name)}"
            val connection = try {
                URL(urlString).openConnection() as HttpURLConnection
            } catch (e: Exception) {
                AppLog.error("Probing $name failed: $e")
                return null
            }

            try {
                connection.requestMethod = "HEAD"
                connection.connectTimeout = PROBE_CONNECT_TIMEOUT_MS
                connection.readTimeout = PROBE_READ_TIMEOUT_MS
                val status = connection.responseCode
                if (status !in 200..299) {
                    AppLog.info("Skipping $name: HTTP $status")
                    return null
                }
                return RemoteImage(name, connection.lastModified, connection.contentLengthLong)
            } catch (e: Exception) {
                AppLog.error("Probing $name failed: $e")
                return null
            } finally {
                connection.disconnect()
            }
        }

        private fun toFileName(href: String): String {
            val withoutQuery = href.substringBefore('?').substringBefore('#')
            val decoded = try {
                URLDecoder.decode(withoutQuery, "UTF-8")
            } catch (e: Exception) {
                withoutQuery
            }
            return decoded.trimEnd('/').substringAfterLast('/')
        }

        private fun fetchRemoteText(urlString: String): String? {
            AppLog.info("Listing images at $urlString")
            val connection = try {
                URL(urlString).openConnection() as HttpURLConnection
            } catch (e: Exception) {
                AppLog.error("Listing $urlString failed: $e")
                return null
            }

            try {
                connection.connectTimeout = LISTING_CONNECT_TIMEOUT_MS
                connection.readTimeout = LISTING_READ_TIMEOUT_MS
                val status = connection.responseCode
                if (status !in 200..299) {
                    AppLog.error("Listing $urlString failed: HTTP $status")
                    return null
                }
                return BufferedInputStream(connection.inputStream).use { stream ->
                    val body = ByteArrayOutputStream()
                    val chunk = ByteArray(8192)
                    while (body.size() < LISTING_MAX_BYTES) {
                        val read = stream.read(chunk)
                        if (read < 0) break
                        body.write(chunk, 0, read)
                    }
                    body.toString("UTF-8")
                }
            } catch (e: Exception) {
                AppLog.error("Listing $urlString failed: $e")
                return null
            } finally {
                connection.disconnect()
            }
        }

        suspend fun fetchImageFromRemote(
            fetchUrl: String,
            remoteImageName: String,
            forceOverwrite: Boolean,
            externalFiles: File,
            onProgress: ((downloaded: Long, total: Long) -> Unit)? = null
        ): Pair<Boolean, String> {
            val localImageName = if (forceOverwrite) remoteImageName else getNextFileName(remoteImageName, externalFiles)
            val remoteChangesName = remoteImageName.removeSuffix(".image") + ".changes"
            val localChangesName = localImageName.removeSuffix(".image") + ".changes"

            val downloaded = AtomicLong()
            val total = AtomicLong()
            val lastReportMs = AtomicLong()

            fun report(force: Boolean) {
                if (onProgress == null) return
                val now = System.currentTimeMillis()
                val last = lastReportMs.get()
                if (force || now - last >= PROGRESS_INTERVAL_MS) {
                    lastReportMs.set(now)
                    onProgress(downloaded.get(), total.get())
                }
            }

            val baseUrl = fetchUrl.trimEnd('/')
            val results = coroutineScope {
                awaitAll(async {
                    fetchRemoteFile("$baseUrl/${Uri.encode(remoteImageName)}", localImageName, externalFiles,
                        onTotalKnown = { total.addAndGet(it); report(true) },
                        onBytes = { downloaded.addAndGet(it); report(false) })
                }, async {
                    fetchRemoteFile("$baseUrl/${Uri.encode(remoteChangesName)}", localChangesName, externalFiles,
                        onTotalKnown = { total.addAndGet(it); report(true) },
                        onBytes = { downloaded.addAndGet(it); report(false) })
                })
            }
            report(true)

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

        private fun fetchRemoteFile(
            urlString: String,
            filename: String,
            externalFiles: File,
            onTotalKnown: (Long) -> Unit = {},
            onBytes: (Long) -> Unit = {}
        ): Boolean {
            AppLog.info("Fetching $urlString -> $filename")
            var success = false;
            val url = URL(urlString)
            val connection = url.openConnection() as HttpURLConnection
            try {
                val contentLength = connection.contentLengthLong
                if (contentLength > 0) onTotalKnown(contentLength)

                val inStream = BufferedInputStream(connection.inputStream)
                val externalFile = File(externalFiles, filename)
                val outStream = FileOutputStream(externalFile)
                var bytes = 0L
                inStream.use { input ->
                    outStream.use { output ->
                        val buffer = ByteArray(64 * 1024)
                        while (true) {
                            val read = input.read(buffer)
                            if (read < 0) break
                            output.write(buffer, 0, read)
                            bytes += read
                            onBytes(read.toLong())
                        }
                    }
                }
                AppLog.info("Fetched $filename (${bytes / 1024} KiB)")
                success = true;
            } catch (e: Exception) {
                AppLog.error("Fetching $urlString failed: $e")
            } finally {
                connection.disconnect()
            }

            return success;
        }
    }
}