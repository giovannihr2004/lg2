// -----------------------------------------------------------------------------
// 📄 Archivo: google_sign_in_service.dart
// 📍 Ubicación: lib/services/google_sign_in_service.dart
// 📝 Descripción: Servicio centralizado para autenticación con Google.
//                Compatible con Android y Web mediante FirebaseAuth.
// 📅 Última actualización: 14/05/2025 - 15:24 (Hora de Colombia)
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
// 1. Importaciones necesarias
// -----------------------------------------------------------------------------
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// -----------------------------------------------------------------------------
// 2. Clase de servicio para inicio/cierre de sesión con Google
// -----------------------------------------------------------------------------
class GoogleSignInService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  // ---------------------------------------------------------------------------
  // 2.1 Iniciar sesión con Google y Firebase
  // ---------------------------------------------------------------------------
  static Future<UserCredential?> signInWithGoogle() async {
    try {
      final auth = FirebaseAuth.instance;

      if (kIsWeb) {
        // Plataforma: WEB
        final googleProvider = GoogleAuthProvider();
        return await auth.signInWithPopup(googleProvider);
      } else {
        // Plataforma: ANDROID
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        if (googleUser == null) return null; // Usuario canceló

        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        return await auth.signInWithCredential(credential);
      }
    } catch (e) {
      log('Error al iniciar sesión con Google: $e');
      return null;
    }
  }

  // ---------------------------------------------------------------------------
  // 2.2 Cerrar sesión tanto de Google como de Firebase
  // ---------------------------------------------------------------------------
  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await _googleSignIn.signOut();
  }
}
