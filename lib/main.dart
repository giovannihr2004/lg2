// -----------------------------------------------------------------------------
// 📄 Archivo: main.dart
// 📍 Ubicación: lib/main.dart
// 📝 Descripción: Inicialización de Firebase + rutas + temas + recuperación
// 📅 Última actualización: 15/05/2025 - 21:58 (Hora de Colombia)
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
// 1. Importaciones necesarias
// -----------------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'firebase_options.dart'; // ✅ Importación añadida
import 'providers/language_provider.dart';
import 'screens/language_selector_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/auth/reset_password_screen.dart';
import 'screens/auth/phone_verification_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/legal/terms_screen.dart';
import 'screens/legal/privacy_policy_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ---------------------------------------------------------------------------
  // 2. Inicialización de Firebase con opciones según plataforma
  // ---------------------------------------------------------------------------
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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
        '/login': (context) => const LoginScreen(),
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
        return null;
      },
    );
  }
}
