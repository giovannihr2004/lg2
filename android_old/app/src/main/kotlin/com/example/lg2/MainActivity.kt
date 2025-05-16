// 📄 Archivo: MainActivity.kt
// 📍 Ubicación: android/app/src/main/kotlin/com/example/lg2/MainActivity.kt
// 📝 Descripción: Configuración de Facebook SDK para login
// 📅 Última actualización: 14/05/2025 - 17:58 (Hora de Colombia)

package com.example.lg2

import android.os.Bundle
import com.facebook.FacebookSdk
import com.facebook.appevents.AppEventsLogger
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // ✅ Inicializa el SDK de Facebook
        FacebookSdk.sdkInitialize(applicationContext)
        AppEventsLogger.activateApp(application)
    }
}
