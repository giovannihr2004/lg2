// -----------------------------------------------------------------------------
// 📄 Archivo: build.gradle.kts
// 📍 Ubicación: android/build.gradle.kts
// 📝 Descripción: Configuración global de Gradle para el proyecto Android
// 📅 Última actualización: 18/05/2025 - 17:53 (Hora de Colombia)
// -----------------------------------------------------------------------------

buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath("com.android.tools.build:gradle:8.2.1")
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.9.0")
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}
