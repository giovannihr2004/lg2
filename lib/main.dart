// -----------------------------------------------------------------------------
// 📄 Archivo: main.dart
// 📍 Ubicación: lib/main.dart
// 📝 Descripción: Inicialización de Firebase + rutas + temas + recuperación
//                Incluye logger profesional y detección de sesión activa
// 📅 Última actualización: 24/05/2025 - 18:00 (Hora de Colombia)
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
// INICIO PARTE 1 - Importaciones necesarias
// -----------------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:logger/logger.dart';

import 'firebase_options.dart';
import 'providers/language_provider.dart';
import 'screens/session/session_wrapper_screen.dart'; // ✅ Detección de sesión activa
import 'screens/auth/login_screen.dart';
import 'screens/auth/register/register_screen.dart'; // ✅ Ruta corregida
import 'screens/auth/reset_password_screen.dart';
import 'screens/auth/phone_verification_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/legal/terms_conditions_screen.dart';
import 'screens/legal/privacy_policy_screen.dart';
import 'screens/testing/lazy_loading_demo.dart'; // ✅ Demo Lazy Loading
// -----------------------------------------------------------------------------
// FIN PARTE 1
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
// INICIO PARTE 2 - Función principal y ejecución con Provider
// -----------------------------------------------------------------------------
final logger = Logger(); // ✅ Instancia global del logger

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  logger.i('✅ Firebase inicializado correctamente');

  runApp(
    ChangeNotifierProvider(
      create: (_) => LanguageProvider(),
      child: const MyApp(),
    ),
  );
}
// -----------------------------------------------------------------------------
// FIN PARTE 2
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
// INICIO PARTE 3 - Widget raíz con configuración visual y localización
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
// -----------------------------------------------------------------------------
// FIN PARTE 3
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
// INICIO PARTE 4 - Rutas de navegación nombradas
// -----------------------------------------------------------------------------
      initialRoute: '/',
      routes: {
        '/': (context) => const SessionWrapperScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/resetPassword': (context) => const ResetPasswordScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/terms': (context) => const TermsConditionsScreen(),
        '/privacy': (context) => const PrivacyPolicyScreen(),
        '/lazy': (context) => const LazyLoadingDemo(),
      },
// -----------------------------------------------------------------------------
// FIN PARTE 4
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
// INICIO PARTE 5 - Rutas generadas dinámicamente con argumentos
// -----------------------------------------------------------------------------
      onGenerateRoute: (settings) {
        if (settings.name == '/phoneVerification') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => PhoneVerificationScreen(
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
// -----------------------------------------------------------------------------
// FIN PARTE 5 - Fin del archivo completo
// -----------------------------------------------------------------------------
