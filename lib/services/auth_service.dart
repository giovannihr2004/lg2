// ----------------------------------------------------------
// Archivo: lib/services/auth_service.dart
// Fecha de creación: 2025-04-21
// ----------------------------------------------------------
// Descripción: Servicio centralizado de autenticación que
// maneja login, registro, Google y Facebook.
// ----------------------------------------------------------

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
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
  // Parte 3: Autenticación con Facebook
  // -------------------------------------------------------------------------

  /// Iniciar sesión con cuenta de Facebook
  Future<UserCredential?> signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status != LoginStatus.success) return null;

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(result.accessToken!.token);

    return await _auth.signInWithCredential(facebookAuthCredential);
  }

  // -------------------------------------------------------------------------
  // Parte 4: Cerrar sesión
  // -------------------------------------------------------------------------

  /// Cerrar sesión del usuario
  Future<void> signOut() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
  }

  /// Obtener el usuario actual
  User? get currentUser => _auth.currentUser;

  /// Escuchar los cambios de autenticación
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
