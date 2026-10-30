package com.mkce.smartmemory

import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.ClipData
import android.content.ContentUris
import android.content.Intent
import android.media.MediaMetadataRetriever
import android.media.MediaPlayer
import android.net.Uri
import android.os.Build
import android.provider.MediaStore
import androidx.exifinterface.media.ExifInterface
import java.io.File
import java.util.concurrent.Executors

class MainActivity : FlutterFragmentActivity() {
    private var player: MediaPlayer? = null
    private var audioPath: String? = null
    private var audioPrepared = false
    private var pendingAudioResult: MethodChannel.Result? = null
    private val io = Executors.newSingleThreadExecutor()
    private fun uri(args: Map<*, *>): Uri {
        val id = (args["id"] as String).toLongOrNull() ?: error("This sample has no gallery original")
        return ContentUris.withAppendedId(if (args["video"] == true) MediaStore.Video.Media.EXTERNAL_CONTENT_URI else MediaStore.Images.Media.EXTERNAL_CONTENT_URI, id)
    }
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "smart_memory/device_media").setMethodCallHandler { call, result ->
            try {
                when (call.method) {
                    "share", "open" -> {
                        val args = call.arguments as Map<*, *>
                        val media = if (call.method == "share") args["media"] as List<*> else listOf(args)
                        require(media.isNotEmpty()) { "Select at least one photo or video" }
                        val uris = ArrayList(media.map { uri(it as Map<*, *>) })
                        // Verify access before opening the system sheet; never silently omit a selection.
                        uris.forEach { contentResolver.openAssetFileDescriptor(it, "r")?.use { _ -> } ?: error("Media is no longer available") }
                        val allVideo = media.all { (it as Map<*, *>)["video"] == true }
                        val allImage = media.all { (it as Map<*, *>)["video"] != true }
                        val mime = if (allVideo) "video/*" else if (allImage) "image/*" else "*/*"
                        val intent = if (call.method == "open") Intent(Intent.ACTION_VIEW).setDataAndType(uris.first(), mime)
                            else Intent(if (uris.size == 1) Intent.ACTION_SEND else Intent.ACTION_SEND_MULTIPLE).apply {
                                type = mime
                                if (uris.size == 1) putExtra(Intent.EXTRA_STREAM, uris.first()) else putParcelableArrayListExtra(Intent.EXTRA_STREAM, uris)
                            }
                        intent.clipData = ClipData.newUri(contentResolver, "Selected memories", uris.first()).also { clip -> uris.drop(1).forEach { clip.addItem(ClipData.Item(it)) } }
                        intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
                        startActivity(Intent.createChooser(intent, if (call.method == "share") "Share selected memories" else "Open original media"))
                        result.success(null)
                    }
                    "location" -> {
                        val args = call.arguments as Map<*, *>
                        io.execute {
                            val location = try {
                                val source = uri(args)
                                if (args["video"] == true) {
                                    val retriever = MediaMetadataRetriever()
                                    try {
                                        retriever.setDataSource(this, source)
                                        val raw = retriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_LOCATION) ?: ""
                                        val match = Regex("([+-]\\d+(?:\\.\\d+)?)([+-]\\d+(?:\\.\\d+)?)").find(raw)
                                        match?.let { mapOf("latitude" to it.groupValues[1].toDouble(), "longitude" to it.groupValues[2].toDouble()) }
                                    } finally { retriever.release() }
                                } else {
                                    val original = if (Build.VERSION.SDK_INT >= 29) MediaStore.setRequireOriginal(source) else source
                                    contentResolver.openInputStream(original)?.use { stream ->
                                        ExifInterface(stream).latLong?.let { mapOf("latitude" to it[0], "longitude" to it[1]) }
                                    }
                                }
                            } catch (_: Exception) { null }
                            runOnUiThread { result.success(location) }
                        }
                    }
                    "audioPlay" -> {
                        val path = call.argument<String>("path") ?: error("Recording path missing")
                        val file = File(path).canonicalFile
                        val privateRoot = File(applicationInfo.dataDir).canonicalPath + File.separator
                        require(file.path.startsWith(privateRoot) && file.isFile) { "Recording unavailable" }
                        if (player != null && audioPath == path && audioPrepared) { player!!.start(); result.success(null) }
                        else {
                            stopAudio()
                            val current = MediaPlayer(); player = current; audioPath = path
                            pendingAudioResult = result
                            current.setOnPreparedListener {
                                if (player === it) {
                                    audioPrepared = true
                                    try {
                                        it.start()
                                        val pending = pendingAudioResult; pendingAudioResult = null
                                        pending?.success(null)
                                    } catch (_: Exception) { stopAudio() }
                                }
                            }
                            current.setOnErrorListener { failed, _, _ ->
                                if (player === failed) stopAudio()
                                true
                            }
                            try {
                                current.setDataSource(path)
                                current.prepareAsync()
                            } catch (_: Exception) { stopAudio() }
                        }
                    }
                    "audioPause" -> { if (audioPrepared && player?.isPlaying == true) player?.pause(); result.success(null) }
                    "audioStop" -> { stopAudio(); result.success(null) }
                    "audioStatus" -> result.success(mapOf("position" to (if (audioPrepared) player?.currentPosition ?: 0 else 0), "duration" to (if (audioPrepared) player?.duration ?: 0 else 0), "playing" to (audioPrepared && player?.isPlaying == true)))
                    else -> result.notImplemented()
                }
            } catch (e: Exception) { result.error("media_unavailable", e.message, null) }
        }
    }
    private fun stopAudio() {
        val pending = pendingAudioResult; pendingAudioResult = null
        player?.release(); player = null; audioPath = null; audioPrepared = false
        pending?.error("audio", "Recording playback stopped", null)
    }
    override fun onStop() {
        if (!audioPrepared) stopAudio() else player?.let { if (it.isPlaying) it.pause() }
        super.onStop()
    }
    override fun onDestroy() { stopAudio(); io.shutdown(); super.onDestroy() }
}
