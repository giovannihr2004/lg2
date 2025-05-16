// -----------------------------------------------------------------------------
// 📄 Archivo: android/app/build.gradle.kts
// 📝 Descripción: Configuración de compilación para la app Flutter en Android.
// 📅 Última actualización: 07/05/2025 - 23:50 (Hora de Colombia)
// -----------------------------------------------------------------------------

plugins {
    id("com.android.application")          // Plugin para compilar apps Android
    id("kotlin-android")                   // Plugin para soporte Kotlin
    id("dev.flutter.flutter-gradle-plugin") // Plugin de Flutter (debe ir al final)
}

android {
    namespace = "com.example.lg2"
    compileSdk = flutter.compileSdkVersion

    // -------------------------------------------------------------------------
    // ✅ CORRECCIÓN 1: Versión correcta del NDK para compatibilidad con plugins
    // -------------------------------------------------------------------------
    ndkVersion = "27.0.12077973"

    // -------------------------------------------------------------------------
    // ✅ CORRECCIÓN 2: Configuración de compatibilidad con Java 11 (evita warnings)
    // -------------------------------------------------------------------------
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    // -------------------------------------------------------------------------
    // ✅ CORRECCIÓN 3: Kotlin usa JVM 11 (recomendado por Gradle y plugins modernos)
    // -------------------------------------------------------------------------
    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // Identificador único de la aplicación (puedes personalizarlo)
        applicationId = "com.example.lg2"

        // Parámetros mínimos y objetivos de SDK definidos por Flutter
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion

        // Versión de la aplicación (se puede personalizar en pubspec.yaml también)
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // 🔐 Para firmar el APK release (de momento usa la llave debug por defecto)
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.." // Ruta raíz del proyecto Flutter
}
