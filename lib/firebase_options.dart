// -----------------------------------------------------------------------------
// 📄 Archivo: firebase_options.dart
// 📍 Ubicación: lib/firebase_options.dart
// 📝 Descripción: Configuración multiplataforma de Firebase para Flutter
// 📅 Última actualización: 18/05/2025 - 15:50 (Hora de Colombia)
// -----------------------------------------------------------------------------

// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart'
    show FirebaseOptions; // Parte 1: Importación de FirebaseOptions
import 'package:flutter/foundation.dart' // Parte 2: Importación de Flutter para acceder a la plataforma
    show
        defaultTargetPlatform,
        kIsWeb,
        TargetPlatform;

// Parte 3: Clase DefaultFirebaseOptions que maneja las configuraciones según la plataforma
class DefaultFirebaseOptions {
  // Parte 4: Getter que selecciona la configuración de Firebase según la plataforma
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      // Si la plataforma es web, devuelve la configuración de Firebase para Web
      return web;
    }
    switch (defaultTargetPlatform) {
      // Dependiendo de la plataforma (Android, iOS, etc.), devuelve la configuración adecuada
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform
            .linux: // Parte 5: Si es Linux, lanza un error ya que no está configurado para esta plataforma
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default: // Parte 6: Si la plataforma no es compatible, lanza un error
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  // Parte 7: Configuración de Firebase para la plataforma Web
  static const FirebaseOptions web = FirebaseOptions(
    apiKey:
        'AIzaSyD2ihUQEbdSxsJvuf4t0YP7Sy9XYp-HRKs', // Clave API para la plataforma Web
    appId: '1:562353221228:web:580e0b1018505a8e8fb249',
    messagingSenderId: '562353221228',
    projectId: 'lector-global-1c462',
    authDomain: 'lector-global-1c462.firebaseapp.com',
    storageBucket: 'lector-global-1c462.firebasestorage.app',
    measurementId: 'G-4Z6182TTRE',
    databaseURL:
        'https://lector-global-1c462.firebaseio.com', // URL de la base de datos para Web
  );

  // Parte 8: Configuración de Firebase para la plataforma Android
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAfvs1UKEmLVX1nkmiNNnBIUuSJZ0AvBb0', // Clave API para Android
    appId: '1:562353221228:android:db9ca3184fd54f2d8fb249',
    messagingSenderId: '562353221228',
    projectId: 'lector-global-1c462',
    storageBucket: 'lector-global-1c462.firebasestorage.app',
    databaseURL:
        'https://lector-global-1c462.firebaseio.com', // URL de la base de datos para Android
  );

  // Parte 9: Configuración de Firebase para la plataforma iOS
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDHyDeeGr59c9Z8KQqlZP_T7jGExaYNsZ0', // Clave API para iOS
    appId: '1:562353221228:ios:daa0b34a8f9d654e8fb249',
    messagingSenderId: '562353221228',
    projectId: 'lector-global-1c462',
    storageBucket: 'lector-global-1c462.firebasestorage.app',
    androidClientId:
        '562353221228-67ha8ei9djmbr2ehdsf9apmt8966839n.apps.googleusercontent.com', // ID de cliente para Google en Android
    iosClientId:
        '562353221228-drq2o9envrmbj5u5dds2amqf1vgc40vv.apps.googleusercontent.com', // ID de cliente para Google en iOS
    iosBundleId: 'com.example.lg2', // Identificador del paquete en iOS
    databaseURL:
        'https://lector-global-1c462.firebaseio.com', // URL de la base de datos para iOS
  );

  // Parte 10: Configuración de Firebase para macOS
  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDHyDeeGr59c9Z8KQqlZP_T7jGExaYNsZ0',
    appId: '1:562353221228:ios:daa0b34a8f9d654e8fb249',
    messagingSenderId: '562353221228',
    projectId: 'lector-global-1c462',
    storageBucket: 'lector-global-1c462.firebasestorage.app',
    androidClientId:
        '562353221228-67ha8ei9djmbr2ehdsf9apmt8966839n.apps.googleusercontent.com',
    iosClientId:
        '562353221228-drq2o9envrmbj5u5dds2amqf1vgc40vv.apps.googleusercontent.com',
    iosBundleId: 'com.example.lg2',
    databaseURL:
        'https://lector-global-1c462.firebaseio.com', // URL de la base de datos para macOS
  );

  // Parte 11: Configuración de Firebase para Windows
  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD2ihUQEbdSxsJvuf4t0YP7Sy9XYp-HRKs', // Clave API para Windows
    appId: '1:562353221228:web:64c9ac04ebcf1a8a8fb249',
    messagingSenderId: '562353221228',
    projectId: 'lector-global-1c462',
    authDomain: 'lector-global-1c462.firebaseapp.com',
    storageBucket: 'lector-global-1c462.firebasestorage.app',
    measurementId: 'G-2ZGGKZYVB9', // Medición de Firebase para Windows
    databaseURL:
        'https://lector-global-1c462.firebaseio.com', // URL de la base de datos para Windows
  );
}
