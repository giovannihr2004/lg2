// -----------------------------------------------------------------------------
// 📄 Archivo: main.dart
// 📍 Ubicación: lib/main.dart
// 📝 Descripción: Inicialización de Firebase + rutas + temas + recuperación
// Incluye logger profesional y detección de sesión activa
// 📅 Última actualización: 25/05/2025 - 23:45 (Hora de Colombia)
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
// INICIO PARTE 1 - Importaciones necesarias
// -----------------------------------------------------------------------------
import 'package:flutter/material.dart'; // Parte 1.1: Importa el paquete Flutter para la UI de la app
import 'package:flutter_localizations/flutter_localizations.dart'; // Parte 1.2: Importa las bibliotecas de localización para múltiples idiomas
import 'package:firebase_core/firebase_core.dart'; // Parte 1.3: Importa Firebase para la inicialización y el uso de sus servicios
import 'package:provider/provider.dart'; // Parte 1.4: Importa Provider para la gestión de estado
import 'l10n/app_localizations.dart'; // Parte 1.5: Importa el archivo de localización generado
import 'package:logger/logger.dart'; // Parte 1.6: Importa la librería Logger para realizar registros y seguimiento de eventos

import 'firebase_options.dart'; // Parte 1.7: Importa las opciones de configuración de Firebase
import 'providers/language_provider.dart'; // Parte 1.8: Importa el provider para gestionar el idioma y el tema
import 'screens/session/session_wrapper_screen.dart'; // Parte 1.9: Importa la pantalla que maneja la sesión del usuario
import 'screens/auth/login_screen.dart'; // Parte 1.10: Importa la pantalla de inicio de sesión
import 'screens/auth/register/register_screen.dart'; // Parte 1.11: Importa la pantalla de registro
import 'screens/auth/reset_password_screen.dart'; // Parte 1.12: Importa la pantalla para restablecer la contraseña
import 'screens/auth/phone_verification_screen.dart'; // Parte 1.13: Importa la pantalla de verificación telefónica
import 'screens/dashboard_screen.dart'; // Parte 1.14: Importa la pantalla principal (dashboard)
import 'screens/legal/terms_conditions_screen.dart'; // Parte 1.15: Importa la pantalla de términos y condiciones
import 'screens/legal/privacy_policy_screen.dart'; // Parte 1.16: Importa la pantalla de política de privacidad
import 'screens/testing/lazy_loading_demo.dart'; // Parte 1.17: Importa una pantalla de demostración para carga diferida (Lazy loading)
// -----------------------------------------------------------------------------
// FIN PARTE 1
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
// INICIO PARTE 2 - Función principal y ejecución con Provider
// -----------------------------------------------------------------------------
final logger =
    Logger(); // Parte 2.1: Inicializa el logger para realizar un seguimiento de eventos

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Parte 2.2: Asegura que los widgets estén completamente inicializados antes de la ejecución
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions
          .currentPlatform); // Parte 2.3: Inicializa Firebase con las opciones específicas para la plataforma actual
  logger.i(
      '✅ Firebase inicializado correctamente'); // Parte 2.4: Imprime un mensaje en el log si la inicialización de Firebase es exitosa

  // Parte 2.5: Ejecuta la aplicación Flutter y establece un provider para el idioma
  runApp(
    ChangeNotifierProvider(
      create: (_) =>
          LanguageProvider(), // Parte 2.6: Crea y proporciona el proveedor de lenguaje para gestionar el idioma y tema
      child: const MyApp(), // Parte 2.7: Llama al widget principal MyApp
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
    final languageProvider = Provider.of<LanguageProvider>(
        context); // Parte 3.1: Obtiene el proveedor de idioma y tema

    // Parte 3.2: Configura el MaterialApp con los temas, localización y rutas
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, // Parte 3.3: Desactiva el banner de depuración
      title: 'Lector Global', // Parte 3.4: Título de la aplicación
      locale: languageProvider
          .locale, // Parte 3.5: Configura el idioma de la app a través del provider
      supportedLocales: AppLocalizations
          .supportedLocales, // Parte 3.6: Establece los idiomas soportados
      localizationsDelegates: AppLocalizations
          .localizationsDelegates, // Parte 3.7: Establece los delegados de localización
      themeMode: languageProvider
          .themeMode, // Parte 3.8: Establece el modo de tema (oscuro o claro) a través del provider
      theme: ThemeData(
        brightness: Brightness.light, // Parte 3.9: Establece el tema claro
        scaffoldBackgroundColor:
            Colors.deepPurple[50], // Parte 3.10: Color de fondo del scaffold
        inputDecorationTheme: const InputDecorationTheme(
          // Parte 3.11: Configura la apariencia de los campos de entrada
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          // Parte 3.12: Configura el tema de los botones elevados
          style: ElevatedButton.styleFrom(
            backgroundColor:
                Colors.deepPurple, // Parte 3.13: Color de fondo del botón
            foregroundColor:
                Colors.white, // Parte 3.14: Color del texto del botón
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark, // Parte 3.15: Establece el tema oscuro
        scaffoldBackgroundColor: Colors
            .black, // Parte 3.16: Color de fondo del scaffold en tema oscuro
        inputDecorationTheme: const InputDecorationTheme(
          // Parte 3.17: Apariencia de los campos de entrada en el tema oscuro
          filled: true,
          fillColor: Colors.grey,
          border: OutlineInputBorder(),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors
                .deepPurple, // Parte 3.18: Color de fondo del botón en tema oscuro
            foregroundColor: Colors
                .white, // Parte 3.19: Color del texto del botón en tema oscuro
          ),
        ),
      ),
      // -----------------------------------------------------------------------------
      // FIN PARTE 3
      // -----------------------------------------------------------------------------

      // -----------------------------------------------------------------------------
      // INICIO PARTE 4 - Rutas de navegación nombradas
      // -----------------------------------------------------------------------------
      initialRoute: '/', // Parte 4.1: Establece la ruta inicial
      routes: {
        // Parte 4.2: Define las rutas nombradas de la aplicación
        '/': (context) =>
            const SessionWrapperScreen(), // Parte 4.3: Pantalla inicial
        '/login': (context) =>
            const LoginScreen(), // Parte 4.4: Pantalla de login
        '/register': (context) =>
            const RegisterScreen(), // Parte 4.5: Pantalla de registro
        '/resetPassword': (context) =>
            const ResetPasswordScreen(), // Parte 4.6: Pantalla para restablecer contraseña
        '/dashboard': (context) =>
            const DashboardScreen(), // Parte 4.7: Pantalla principal (Dashboard)
        '/terms': (context) =>
            const TermsConditionsScreen(), // Parte 4.8: Pantalla de términos y condiciones
        '/privacy': (context) =>
            const PrivacyPolicyScreen(), // Parte 4.9: Pantalla de política de privacidad
        '/lazy': (context) =>
            const LazyLoadingDemo(), // Parte 4.10: Pantalla de carga diferida (Lazy loading demo)
      },
      // -----------------------------------------------------------------------------
      // FIN PARTE 4
      // -----------------------------------------------------------------------------

      // -----------------------------------------------------------------------------
      // INICIO PARTE 5 - Rutas generadas dinámicamente con argumentos
      // -----------------------------------------------------------------------------
      onGenerateRoute: (settings) {
        // Parte 5.1: Configura rutas generadas dinámicamente
        if (settings.name == '/phoneVerification') {
          // Parte 5.2: Verifica la ruta de verificación telefónica
          final args = settings.arguments as Map<String,
              dynamic>; // Parte 5.3: Obtiene los argumentos de la ruta
          return MaterialPageRoute(
            builder: (context) => PhoneVerificationScreen(
              verificationId: args[
                  'verificationId'], // Parte 5.4: Pasa los argumentos necesarios a la pantalla
              phoneNumber: args['phoneNumber'],
            ),
          );
        }
        return null; // Si la ruta no coincide, devuelve null
      },
    );
  }
}
// -----------------------------------------------------------------------------
// FIN PARTE 5 - Fin del archivo completo
// -----------------------------------------------------------------------------
