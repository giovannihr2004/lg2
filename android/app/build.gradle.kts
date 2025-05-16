// -----------------------------------------------------------------------------
// 📄 Archivo: android/app/build.gradle.kts
// 📅 Última actualización: 15/05/2025 - 19:55 (Hora de Colombia)
// 📝 Descripción: Configuración completa con Firebase y Google Services
// -----------------------------------------------------------------------------

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("com.google.gms.google-services") // ✅ Plugin Firebase
    id("dev.flutter.flutter-gradle-plugin") // Siempre debe ir al final
}

android {
    namespace = "com.android.LectorGlobal"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.android.LectorGlobal"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
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

dependencies {
    // ✅ Plataforma BoM para versiones consistentes
    implementation(platform("com.google.firebase:firebase-bom:32.7.2"))

    // ✅ Módulo requerido para evitar el error del Instance ID
    implementation("com.google.firebase:firebase-analytics")
}
