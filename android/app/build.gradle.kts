// -----------------------------------------------------------------------------
// 📄 Archivo: build.gradle.kts
// 📍 Ubicación: android/app/build.gradle.kts
// 📝 Descripción: Configuración del módulo de app Android para Lector Global
// 📅 Última actualización: 18/05/2025 - 17:53 (Hora de Colombia)
// -----------------------------------------------------------------------------

plugins {
    id("com.android.application")
    id("kotlin-android")
    // El plugin de Flutter debe ir al final
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.lector_global"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973" // ✅ Actualizado para compatibilidad con Firestore y plugins

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // Identificador único de la aplicación
        applicationId = "com.example.lector_global"

        // Configuraciones mínimas y de destino
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion

        // Versión de la app
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    // ✅ Corrección obligatoria para Firestore en Android
    buildFeatures {
        buildConfig = true
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
