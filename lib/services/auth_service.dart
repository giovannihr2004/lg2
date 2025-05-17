// -----------------------------------------------------------------------------
// 📄 Archivo: lib/services/auth_service.dart
// 📝 Descripción: Servicio centralizado de autenticación con login, registro,
// Google. Eliminada integración con Facebook.
// 📅 Última actualización: 16/05/2025 - 23:50 (Hora de Colombia)
// -----------------------------------------------------------------------------

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Servicio de autenticación con Firebase.
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // -------------------------------------------------------------------------
  // Parte 1: Autenticación con correo y contraseña
  // -------------------------------------------------------------------------

  /// Iniciar sesión con correo y contraseña
  Future<UserCredential> signInWithEmail(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Registrar nuevo usuario con correo y contraseña
  Future<UserCredential> registerWithEmail(
    String email,
    String password,
  ) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // -------------------------------------------------------------------------
  // Parte 2: Autenticación con Google
  // -------------------------------------------------------------------------

  /// Iniciar sesión con cuenta de Google
  Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) return null; // El usuario canceló

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await _auth.signInWithCredential(credential);
  }

  // -------------------------------------------------------------------------
  // Parte 3: Cerrar sesión
  // -------------------------------------------------------------------------

  /// Cerrar sesión del usuario
  Future<void> signOut() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
  }

  /// Obtener el usuario actual
  User? get currentUser => _auth.currentUser;

  /// Escuchar los cambios de autenticación
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
