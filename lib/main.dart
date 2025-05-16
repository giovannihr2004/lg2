// -----------------------------------------------------------------------------
// 📄 Archivo: main.dart
// 📍 Ubicación: lib/main.dart
// 📝 Descripción: Inicialización de Firebase + rutas + temas + recuperación
// 📅 Última actualización: 15/05/2025 - 18:45 (Hora de Colombia)
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
// 1. Importaciones necesarias
// -----------------------------------------------------------------------------
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'providers/language_provider.dart';
import 'screens/language_selector_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/auth/reset_password_screen.dart';
import 'screens/auth/phone_verification_screen.dart'; // ✅ Nueva importación
import 'screens/dashboard_screen.dart';
import 'screens/legal/terms_screen.dart';
import 'screens/legal/privacy_policy_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ---------------------------------------------------------------------------
  // 2. Inicialización de Firebase
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
  // 3. Ejecutar app con Provider
  // ---------------------------------------------------------------------------
  runApp(
    ChangeNotifierProvider(
      create: (_) => LanguageProvider(),
      child: const MyApp(),
    ),
  );
}

// -----------------------------------------------------------------------------
// 4. Widget raíz con MaterialApp
// -----------------------------------------------------------------------------
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lector Global',

      // 🌐 Localización e idiomas
      locale: languageProvider.locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,

      // 🌓 Tema claro/oscuro controlado por el usuario
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

      // -----------------------------------------------------------------------
      // 5. Rutas de navegación nombradas
      // -----------------------------------------------------------------------
      initialRoute: '/',
      routes: {
        '/': (context) => const LanguageSelectorScreen(),
        '/register': (context) => const RegisterScreen(),
        '/resetPassword': (context) => const ResetPasswordScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/terms': (context) => const TermsScreen(),
        '/privacy': (context) => const PrivacyPolicyScreen(),
      },

      // -----------------------------------------------------------------------
      // 6. Rutas generadas dinámicamente con argumentos
      // -----------------------------------------------------------------------
      onGenerateRoute: (settings) {
        if (settings.name == '/phoneVerification') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder:
                (context) => PhoneVerificationScreen(
                  verificationId: args['verificationId'],
                  phoneNumber: args['phoneNumber'],
                ),
          );
        }
        return null; // Ruta no encontrada
      },
    );
  }
}
