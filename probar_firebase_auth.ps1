# probar_firebase_auth.ps1 - Versión corregida
$versiones = @(
  "4.17.0", "4.16.0", "4.15.0", "4.14.0", "4.13.0",
  "4.12.0", "4.11.0", "4.10.0", "4.9.0", "4.8.0"
)

foreach ($v in $versiones) {
  Write-Host "`n🔄 Probando firebase_auth $v ..."

  # Reemplazar versión en pubspec.yaml
  (Get-Content .\pubspec.yaml) -replace 'firebase_auth:.*', "  firebase_auth: $v" | Set-Content .\pubspec.yaml

  # Limpiar, obtener paquetes
  & flutter clean
  & flutter pub get

  # Compilar y capturar resultado
  try {
    & flutter build windows
    if ($?) {
      Write-Host "`n✅ Compilación EXITOSA con firebase_auth $v"
      break
    }
  } catch {
    Write-Host "`n❌ Falló con firebase_auth $v"
  }
}
