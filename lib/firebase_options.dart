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
    appId: '1:562353221228:web:0b16b21f79aac8ac8fb249',
    messagingSenderId: '562353221228',
    projectId: 'lector-global-1c462',
    authDomain: 'lector-global-1c462.firebaseapp.com',
    storageBucket: 'lector-global-1c462.appspot.com',
    measurementId: 'G-CC7D3GYRYL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAfvs1UKEmLVX1nkmiNNnBIUuSJZ0AvBb0',
    appId: '1:562353221228:android:2da1afd6cf20e6298fb249',
    messagingSenderId: '562353221228',
    projectId: 'lector-global-1c462',
    storageBucket: 'lector-global-1c462.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDHyDeeGr59c9Z8KQqlZP_T7jGExaYNsZ0',
    appId: '1:562353221228:ios:b91996d075d7f5c78fb249',
    messagingSenderId: '562353221228',
    projectId: 'lector-global-1c462',
    storageBucket: 'lector-global-1c462.appspot.com',
    androidClientId:
        '562353221228-09204evp201088rrbn5misusdjnrjljk.apps.googleusercontent.com',
    iosClientId:
        '562353221228-phs5ku5i6513t7ki7hm3p0enplngjpf1.apps.googleusercontent.com',
    iosBundleId: 'com.example.lectorGlobal',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDHyDeeGr59c9Z8KQqlZP_T7jGExaYNsZ0',
    appId: '1:562353221228:ios:b91996d075d7f5c78fb249',
    messagingSenderId: '562353221228',
    projectId: 'lector-global-1c462',
    storageBucket: 'lector-global-1c462.appspot.com',
    androidClientId:
        '562353221228-09204evp201088rrbn5misusdjnrjljk.apps.googleusercontent.com',
    iosClientId:
        '562353221228-phs5ku5i6513t7ki7hm3p0enplngjpf1.apps.googleusercontent.com',
    iosBundleId: 'com.example.lectorGlobal',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD2ihUQEbdSxsJvuf4t0YP7Sy9XYp-HRKs',
    appId: '1:562353221228:web:9cd540c805fd3f998fb249',
    messagingSenderId: '562353221228',
    projectId: 'lector-global-1c462',
    authDomain: 'lector-global-1c462.firebaseapp.com',
    storageBucket: 'lector-global-1c462.appspot.com',
    measurementId: 'G-1G5XKMDWS6',
  );
}
