package io.github.bulentozkir.kepli

import android.app.Activity
import android.content.ActivityNotFoundException
import android.content.Intent
import android.os.Bundle
import android.provider.DocumentsContract
import android.provider.OpenableColumns
import android.util.Log
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.IOException
import java.util.concurrent.Executors

class MainActivity : FlutterActivity() {
    private var pendingResult: MethodChannel.Result? = null
    private var pendingSource: String? = null
    private var successMessage = "Kepli"
    private var failureMessage = "Kepli"
    private val writer = Executors.newSingleThreadExecutor()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        pendingSource = savedInstanceState?.getString("kepli.export.source")
        successMessage = savedInstanceState?.getString("kepli.export.success") ?: "Kepli"
        failureMessage = savedInstanceState?.getString("kepli.export.failure") ?: "Kepli"
    }

    override fun onSaveInstanceState(outState: Bundle) {
        outState.putString("kepli.export.source", pendingSource)
        outState.putString("kepli.export.success", successMessage)
        outState.putString("kepli.export.failure", failureMessage)
        super.onSaveInstanceState(outState)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "kepli/storage")
            .setMethodCallHandler { call, result ->
                if (call.method != "saveExport") {
                    result.notImplemented()
                    return@setMethodCallHandler
                }
                if (pendingSource != null) {
                    result.error("export_busy", "A save dialog is already open.", null)
                    return@setMethodCallHandler
                }
                val sourcePath = call.argument<String>("sourcePath")
                val fileName = call.argument<String>("fileName")
                val mimeType = call.argument<String>("mimeType")
                if (sourcePath.isNullOrBlank() || fileName.isNullOrBlank() ||
                    mimeType.isNullOrBlank()) {
                    result.error("invalid_export", "The export details are incomplete.", null)
                    return@setMethodCallHandler
                }
                try {
                    val source = File(sourcePath).canonicalFile
                    val cachePrefix = cacheDir.canonicalPath + File.separator
                    if (!source.isFile || !source.path.startsWith(cachePrefix)) {
                        result.error("invalid_export", "Choose a generated Kepli export.", null)
                        return@setMethodCallHandler
                    }
                    pendingSource = source.path
                    pendingResult = result
                    successMessage = call.argument<String>("successMessage") ?: "Kepli"
                    failureMessage = call.argument<String>("failureMessage") ?: "Kepli"
                    val intent = Intent(Intent.ACTION_CREATE_DOCUMENT).apply {
                        addCategory(Intent.CATEGORY_OPENABLE)
                        type = mimeType
                        putExtra(Intent.EXTRA_TITLE, fileName)
                    }
                    @Suppress("DEPRECATION")
                    startActivityForResult(intent, exportRequestCode)
                } catch (error: IOException) {
                    failBeforePicker(result, error)
                } catch (error: SecurityException) {
                    failBeforePicker(result, error)
                } catch (error: ActivityNotFoundException) {
                    failBeforePicker(result, error)
                }
            }
    }

    private fun failBeforePicker(result: MethodChannel.Result, error: Exception) {
        pendingSource = null
        pendingResult = null
        Log.e("Kepli", "Could not open the save dialog", error)
        result.error("export_failed", error.message, null)
    }

    @Deprecated("Activity result dispatch remains supported by FlutterActivity.")
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        if (requestCode != exportRequestCode) {
            super.onActivityResult(requestCode, resultCode, data)
            return
        }
        val result = pendingResult
        val sourcePath = pendingSource
        pendingResult = null
        pendingSource = null
        val uri = data?.data
        if (resultCode != Activity.RESULT_OK || uri == null) {
            result?.success(null)
            return
        }
        if (sourcePath == null) {
            result?.error("export_failed", "The export source is no longer available.", null)
            Toast.makeText(this, failureMessage, Toast.LENGTH_LONG).show()
            return
        }
        writer.execute {
            try {
                contentResolver.openOutputStream(uri, "w")?.use { output ->
                    File(sourcePath).inputStream().use { input ->
                        input.copyTo(output, 64 * 1024)
                    }
                    output.flush()
                } ?: throw IOException("The selected document cannot be written.")
                val displayName = exportedName(uri)
                runOnUiThread {
                    if (result != null) result.success(displayName)
                    else Toast.makeText(
                        this, "$successMessage\n$displayName", Toast.LENGTH_LONG
                    ).show()
                }
            } catch (error: IOException) {
                failWrite(uri, result, error)
            } catch (error: SecurityException) {
                failWrite(uri, result, error)
            } catch (error: IllegalArgumentException) {
                failWrite(uri, result, error)
            } catch (error: IllegalStateException) {
                failWrite(uri, result, error)
            }
        }
    }

    private fun exportedName(uri: android.net.Uri): String {
        try {
            contentResolver.query(
                uri, arrayOf(OpenableColumns.DISPLAY_NAME), null, null, null
            )?.use { cursor ->
                if (cursor.moveToFirst() && !cursor.isNull(0)) {
                    return cursor.getString(0)
                }
            }
        } catch (error: SecurityException) {
            Log.w("Kepli", "Provider withheld the saved document name; using its URI", error)
        } catch (error: IllegalArgumentException) {
            Log.w("Kepli", "Provider does not support document names; using its URI", error)
        } catch (error: IllegalStateException) {
            Log.w("Kepli", "Provider could not return the saved document name", error)
        }
        return uri.toString()
    }

    private fun failWrite(
        uri: android.net.Uri,
        result: MethodChannel.Result?,
        error: Exception
    ) {
        Log.e("Kepli", "Export failed", error)
        var detail = error.message ?: error.javaClass.simpleName
        try {
            if (!DocumentsContract.deleteDocument(contentResolver, uri)) {
                detail += " The incomplete destination could not be removed."
            }
        } catch (cleanup: IOException) {
            Log.e("Kepli", "Partial export cleanup failed", cleanup)
            detail += " Remove the incomplete destination manually."
        } catch (cleanup: SecurityException) {
            Log.e("Kepli", "Partial export cleanup denied", cleanup)
            detail += " Remove the incomplete destination manually."
        } catch (cleanup: IllegalArgumentException) {
            Log.e("Kepli", "Provider could not remove the partial export", cleanup)
            detail += " Remove the incomplete destination manually."
        } catch (cleanup: IllegalStateException) {
            Log.e("Kepli", "Provider was unavailable during partial export cleanup", cleanup)
            detail += " Remove the incomplete destination manually."
        }
        runOnUiThread {
            if (result != null) result.error("export_failed", detail, null)
            else Toast.makeText(this, "$failureMessage\n$detail", Toast.LENGTH_LONG).show()
        }
    }

    override fun onDestroy() {
        writer.shutdown()
        super.onDestroy()
    }

    companion object {
        private const val exportRequestCode = 0x4b50
    }
}
