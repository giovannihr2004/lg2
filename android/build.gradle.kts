// -----------------------------------------------------------------------------
// 📄 Archivo: android/build.gradle.kts
// 📝 Descripción: Configuración raíz sin errores Kotlin DSL.
// 📅 Última actualización: 08/05/2025 - 00:05 (Hora de Colombia)
// -----------------------------------------------------------------------------

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// ✅ Reconfigura la carpeta de salida build para todos los subproyectos
val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
