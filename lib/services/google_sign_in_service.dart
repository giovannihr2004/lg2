// -----------------------------------------------------------------------------
// 📄 Archivo: google_sign_in_service.dart
// 📍 Ubicación: lib/services/google_sign_in_service.dart
// 📝 Descripción: Autenticación con Google (sin Firestore en esta versión web)
// 📅 Última actualización: 18/05/2025 - 18:12 (Hora de Colombia)
// -----------------------------------------------------------------------------

import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart'; // ❌ No se usa en esta rama
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
    serverClientId:
        '562353221228-09204evp201088rrbn5misusdjnrjljk.apps.googleusercontent.com',
  );

  static Future<void> signInWithGoogleAndNavigate(BuildContext context) async {
    try {
      final auth = FirebaseAuth.instance;
      // final firestore = FirebaseFirestore.instance; // ❌ Firestore desactivado

      UserCredential credential;

      print("🟡 Iniciando flujo de Google");

      if (kIsWeb) {
        final googleProvider = GoogleAuthProvider();
        credential = await auth.signInWithPopup(googleProvider);
      } else {
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        if (googleUser == null) {
          log('⚠️ Usuario canceló el inicio de sesión');
          return;
        }

        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        if (googleAuth.accessToken == null || googleAuth.idToken == null) {
          log('❌ No se obtuvo token válido de Google.');
          return;
        }

        final authCredential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        credential = await auth.signInWithCredential(authCredential);
      }

      final uid = credential.user?.uid;
      if (uid == null) {
        log('❌ UID nulo después del inicio de sesión.');
        return;
      }

      print("🟢 UID obtenido: $uid");

      // 🔽 Se omite Firestore en esta versión web
      /*
      final userDoc = await firestore.collection('usuarios').doc(uid).get();
      print("🔎 Documento Firestore existe: ${userDoc.exists}");

      if (!context.mounted) return;

      if (userDoc.exists && userDoc.data()!.containsKey('email')) {
        print("✅ Usuario reconocido en Firestore. Redirigiendo a /dashboard");
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else {
        final email = credential.user?.email;
        if (email != null) {
          await firestore.collection('usuarios').doc(uid).set({'email': email});
          print("📄 Documento creado en Firestore con el email: $email");
        } else {
          print("⚠️ No se pudo obtener el email del usuario.");
        }
        print("🆕 Usuario sin datos en Firestore. Redirigiendo a /register");
        Navigator.pushReplacementNamed(context, '/register');
      }
      */

      // 🔁 Redirección genérica en esta versión web (sin Firestore)
      if (!context.mounted) return;
      Navigator.pushReplacementNamed(context, '/dashboard');
    } catch (e) {
      log('❌ Error en signInWithGoogleAndNavigate: ${e.toString()}');
      print('❌ EXCEPCIÓN: ${e.toString()}');
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error al iniciar sesión con Google.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await _googleSignIn.signOut();
  }
}
