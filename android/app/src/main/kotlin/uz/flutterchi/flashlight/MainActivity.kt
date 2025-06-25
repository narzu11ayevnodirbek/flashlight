package uz.flutterchi.flashlight

import io.flutter.embedding.android.FlutterActivity
import android.hardware.camera2.CameraAccessException
import android.hardware.camera2.CameraManager
import android.os.Bundle
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity(){
    private val CHANNEL = "com.example.flashlight/torch"

    override fun configureFlutterEngine(flutterEngine: io.flutter.embedding.engine.FlutterEngine){
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            val cameraManager = getSystemService(CAMERA_SERVICE) as CameraManager
            val cameraId = cameraManager.cameraIdList[0]

            try {
                when (call.method) {
                    "turnOn" -> {
                        cameraManager.setTorchMode(cameraId, true)
                        result.success("Torch turned on")
                    }
                    "turnOff" -> {
                        cameraManager.setTorchMode(cameraId, false)
                        result.success("Torch turned off")
                    }
                    else -> result.notImplemented()
                }
            } catch (e: CameraAccessException) {
                result.error("CAMERA_ERROR", "Camera access error", null)
            }
        }
    }
}
