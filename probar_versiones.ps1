# Script: probar_versiones.ps1 (versión sin emojis)
# Descripción: Prueba una versión y asegura restauración del pubspec.yaml

$pubspecPath = "pubspec.yaml"
$backupPath = "pubspec.original.bak"
$versionPrueba = "4.7.0"

Write-Host ""
Write-Host "Iniciando prueba para cloud_firestore $versionPrueba..."

# Crear respaldo si no existe
if (!(Test-Path $backupPath)) {
    Copy-Item $pubspecPath $backupPath -Force
    Write-Host "Respaldo creado como $backupPath"
}
else {
    Write-Host "Respaldo ya existe."
}

# Reemplazar versión en pubspec.yaml
(Get-Content $pubspecPath) `
    -replace "cloud_firestore:.*", "cloud_firestore: $versionPrueba" `
    | Set-Content $pubspecPath
Write-Host "pubspec.yaml modificado con cloud_firestore $versionPrueba."

# Ejecutar flutter pub get
flutter pub get

# Compilar para Windows
flutter build windows

# Restaurar pubspec.yaml original
Copy-Item $backupPath $pubspecPath -Force
Write-Host "pubspec.yaml restaurado al respaldo original."
