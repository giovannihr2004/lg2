// -----------------------------------------------------------------------------
// Servicio de autenticación con Google para Lector Global
// Archivo: google_sign_in_service.dart
// Descripción: Maneja la lógica para iniciar sesión con cuenta de Google.
// Versión: 1.0
// Fecha: 23/04/2025 - Hora: 22:57 (202504232257)
// -----------------------------------------------------------------------------

import 'dart:developer'; // Para usar log()
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// Inicia sesión con Google y devuelve la cuenta si fue exitoso.
  static Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      final account = await _googleSignIn.signIn();
      return account; // Retorna el usuario si el login fue exitoso
    } catch (e) {
      log('Error al iniciar sesión con Google: $e');
      return null;
    }
  }

  /// Cierra la sesión del usuario de Google
  static Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
