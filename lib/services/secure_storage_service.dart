// -----------------------------------------------------------------------------
// 📄 Archivo: secure_storage_service.dart
// 📍 Ubicación: lib/services/secure_storage_service.dart
// 📝 Descripción: Servicio para almacenar, leer y eliminar datos seguros en local
// 📅 Última actualización: 23/05/2025 - 17:45 (Hora de Colombia)
// -----------------------------------------------------------------------------

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  // Instancia única del almacenamiento seguro
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // ---------------------------------------------------------------------------
  // 1. Guardar un valor seguro (por ejemplo: token, email encriptado, etc.)
  // ---------------------------------------------------------------------------
  Future<void> save(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  // ---------------------------------------------------------------------------
  // 2. Leer un valor seguro
  // ---------------------------------------------------------------------------
  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  // ---------------------------------------------------------------------------
  // 3. Eliminar un valor seguro
  // ---------------------------------------------------------------------------
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  // ---------------------------------------------------------------------------
  // 4. Eliminar todo (por ejemplo, al cerrar sesión completamente)
  // ---------------------------------------------------------------------------
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}
