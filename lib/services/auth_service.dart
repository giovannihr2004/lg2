// -----------------------------------------------------------------------------
// 📄 Archivo: lib/services/auth_service.dart
// 📝 Descripción: Servicio centralizado de autenticación con login, registro,
// Google y almacenamiento seguro de sesión (uid y email).
// 📅 Última actualización: 24/05/2025 - 12:55 (Hora de Colombia)
// -----------------------------------------------------------------------------

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'secure_storage_service.dart'; // 🔐 Servicio seguro para guardar sesión

/// Servicio de autenticación con Firebase.
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // -------------------------------------------------------------------------
  // Parte 1: Autenticación con correo y contraseña
  // -------------------------------------------------------------------------

  /// Iniciar sesión con correo y contraseña
  Future<UserCredential> signInWithEmail(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = credential.user;
    if (user != null) {
      // 🔐 Guardar sesión en almacenamiento seguro
      await SecureStorageService().save('uid', user.uid);
      await SecureStorageService().save('email', user.email ?? '');
    }

    return credential;
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

    final result = await _auth.signInWithCredential(credential);

    final user = result.user;
    if (user != null) {
      // 🔐 Guardar sesión en almacenamiento seguro
      await SecureStorageService().save('uid', user.uid);
      await SecureStorageService().save('email', user.email ?? '');
    }

    return result;
  }

  // -------------------------------------------------------------------------
  // Parte 3: Cerrar sesión
  // -------------------------------------------------------------------------

  /// Cerrar sesión del usuario y limpiar sesión segura
  Future<void> signOut() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
    await SecureStorageService().deleteAll(); // 🔐 Borrar sesión segura
  }

  /// Obtener el usuario actual
  User? get currentUser => _auth.currentUser;

  /// Escuchar los cambios de autenticación
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
