// -----------------------------------------------------------------------------
// 📄 Archivo: welcome_screen.dart
// 📍 Ubicación: lib/screens/welcome_screen.dart
// 📝 Descripción: Pantalla de bienvenida con traducciones y selector de idioma
// ♿ Mejora: Accesibilidad con Semantics en logo, textos y botón
// 📅 Última actualización: 22/05/2025 - 22:10 (Hora de Colombia)
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'auth/login_screen.dart';
import '../widgets/language_selector.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        title: Text(loc?.welcome_title ?? 'Lector Global'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: LanguageSelector(),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 32.0,
              vertical: 48.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // -----------------------------------------------------------------
                // 1. Logo de bienvenida con Semantics
                // -----------------------------------------------------------------
                Semantics(
                  label: 'Logotipo de Lector Global',
                  image: true,
                  child: Image.asset(
                    'assets/images/logo_welcome.png',
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 30),

                // -----------------------------------------------------------------
                // 2. Título principal accesible
                // -----------------------------------------------------------------
                Semantics(
                  label: loc?.welcome_title ?? 'Bienvenido a Lector Global',
                  child: Text(
                    loc?.welcome_title ?? 'Bienvenido a Lector Global',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),

                // -----------------------------------------------------------------
                // 3. Eslogan accesible
                // -----------------------------------------------------------------
                Semantics(
                  label: loc?.welcome_message ?? 'Bienvenido',
                  child: Text(
                    loc?.welcome_message ?? 'Bienvenido',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.deepPurple,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // -----------------------------------------------------------------
                // 4. Información del desarrollador accesible
                // -----------------------------------------------------------------
                Semantics(
                  label:
                      '${loc?.developed_by ?? 'Desarrollado por Giovanni Holguín'}, '
                      '${loc?.version_info ?? 'Versión 1.0.0'}, '
                      '${loc?.date_info ?? '7 de mayo de 2025'}',
                  child: Column(
                    children: [
                      Text(
                        loc?.developed_by ??
                            'Desarrollado por Giovanni Holguín',
                        style: const TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          color: Colors.black45,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        loc?.version_info ?? 'Versión 1.0.0',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black38,
                        ),
                      ),
                      Text(
                        loc?.date_info ?? '7 de mayo de 2025',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black38,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // -----------------------------------------------------------------
                // 5. Botón "Iniciar" con Semantics
                // -----------------------------------------------------------------
                Semantics(
                  label: 'Botón para iniciar sesión',
                  button: true,
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                      ),
                      child: Text(
                        loc?.start_button ?? 'Iniciar',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
