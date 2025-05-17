// -----------------------------------------------------------------------------
// 📄 Archivo: lib/firebase_options.dart
// 📝 Descripción: Configuración automática generada por FlutterFire CLI para conectar la app a Firebase.
// 📅 Última actualización: 15/05/2025 - 21:35 (Hora de Colombia)
// -----------------------------------------------------------------------------

// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this ejecutando FlutterFire CLI de nuevo.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions no soportado para esta plataforma.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD2ihUQEbdSxsJvuf4t0YP7Sy9XYp-HRKs',
    appId: '1:562353221228:web:580e0b1018505a8e8fb249',
    messagingSenderId: '562353221228',
    projectId: 'lector-global-1c462',
    authDomain: 'lector-global-1c462.firebaseapp.com',
    storageBucket: 'lector-global-1c462.firebasestorage.app',
    measurementId: 'G-4Z6182TTRE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAfvs1UKEmLVX1nkmiNNnBIUuSJZ0AvBb0',
    appId: '1:562353221228:android:db9ca3184fd54f2d8fb249',
    messagingSenderId: '562353221228',
    projectId: 'lector-global-1c462',
    storageBucket: 'lector-global-1c462.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDHyDeeGr59c9Z8KQqlZP_T7jGExaYNsZ0',
    appId: '1:562353221228:ios:dd91bcb463e2f8da8fb249',
    messagingSenderId: '562353221228',
    projectId: 'lector-global-1c462',
    storageBucket: 'lector-global-1c462.firebasestorage.app',
    androidClientId: '562353221228-affetitg1b1l6ijrvcan3pt9ncvki8hh.apps.googleusercontent.com',
    iosClientId: '562353221228-drq2o9envrmbj5u5dds2amqf1vgc40vv.apps.googleusercontent.com',
    iosBundleId: 'com.example.lg2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDHyDeeGr59c9Z8KQqlZP_T7jGExaYNsZ0',
    appId: '1:562353221228:ios:dd91bcb463e2f8da8fb249',
    messagingSenderId: '562353221228',
    projectId: 'lector-global-1c462',
    storageBucket: 'lector-global-1c462.firebasestorage.app',
    androidClientId: '562353221228-affetitg1b1l6ijrvcan3pt9ncvki8hh.apps.googleusercontent.com',
    iosClientId: '562353221228-drq2o9envrmbj5u5dds2amqf1vgc40vv.apps.googleusercontent.com',
    iosBundleId: 'com.example.lg2',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD2ihUQEbdSxsJvuf4t0YP7Sy9XYp-HRKs',
    appId: '1:562353221228:web:64c9ac04ebcf1a8a8fb249',
    messagingSenderId: '562353221228',
    projectId: 'lector-global-1c462',
    authDomain: 'lector-global-1c462.firebaseapp.com',
    storageBucket: 'lector-global-1c462.firebasestorage.app',
    measurementId: 'G-2ZGGKZYVB9',
  );

}