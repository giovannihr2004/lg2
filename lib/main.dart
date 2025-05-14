// -----------------------------------------------------------------------------
// 📄 Archivo: main.dart
// 📍 Ubicación: lib/main.dart
// 📝 Descripción: Inicialización de Firebase + LanguageProvider + Modo oscuro controlado manualmente
// 📅 Última actualización: 13/05/2025 - 21:20 (Hora de Colombia)
// -----------------------------------------------------------------------------

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:lector_global/providers/language_provider.dart';
import 'screens/language_selector_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ---------------------------------------------------------------------------
  // 1. Inicialización de Firebase para Web y otras plataformas
  // ---------------------------------------------------------------------------
  await Firebase.initializeApp(
    options:
        kIsWeb
            ? const FirebaseOptions(
              apiKey: "AIzaSyD2ihUQEbdSxsJvuf4t0YP7Sy9XYp-HRKs",
              authDomain: "lector-global-1c462.firebaseapp.com",
              projectId: "lector-global-1c462",
              storageBucket: "lector-global-1c462.firebasestorage.app",
              messagingSenderId: "562353221228",
              appId: "1:562353221228:web:580e0b1018505a8e8fb249",
            )
            : null,
  );

  // ---------------------------------------------------------------------------
  // 2. Inicia la app con LanguageProvider
  // ---------------------------------------------------------------------------
  runApp(
    ChangeNotifierProvider(
      create: (_) => LanguageProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lector Global',
      locale: languageProvider.locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,

      // 🌓 Tema gestionado por el LanguageProvider
      themeMode: languageProvider.themeMode,

      // 🌞 Tema claro personalizado
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.deepPurple[50],
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
          ),
        ),
      ),

      // 🌙 Tema oscuro personalizado
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey,
          border: OutlineInputBorder(),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
          ),
        ),
      ),

      home: const LanguageSelectorScreen(),
    );
  }
}
