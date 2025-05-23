// -----------------------------------------------------------------------------
// 📄 Archivo: splash_text_screen.dart
// 📍 Ubicación: lib/screens/splash/splash_text_screen.dart
// 📝 Descripción: Pantalla con logo familiar, eslogan animado y transición automática a WelcomeScreen
// ♿ Mejora: Accesibilidad con Semantics en logo, título y eslogan
// 📅 Última actualización: 22/05/2025 - 22:45 (Hora de Colombia)
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../welcome_screen.dart';

class SplashTextScreen extends StatefulWidget {
  const SplashTextScreen({super.key});

  @override
  State<SplashTextScreen> createState() => _SplashTextScreenState();
}

class _SplashTextScreenState extends State<SplashTextScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    Future.delayed(const Duration(milliseconds: 6500), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const WelcomeScreen(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 800),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      body: Center(
        child: FadeTransition(
          opacity: _fadeIn,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // -----------------------------------------------------------------
                // Logo con accesibilidad
                // -----------------------------------------------------------------
                Semantics(
                  label: 'Logo familiar de Lector Global',
                  image: true,
                  child: Image.asset(
                    'assets/images/logo_bienvenida.png',
                    height: 220,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 20),

                // -----------------------------------------------------------------
                // Título "LECTOR GLOBAL" con accesibilidad
                // -----------------------------------------------------------------
                Semantics(
                  label: 'Nombre de la aplicación: Lector Global',
                  child: const Text(
                    'LECTOR GLOBAL',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),

                // -----------------------------------------------------------------
                // Eslogan accesible con traducción
                // -----------------------------------------------------------------
                Semantics(
                  label: loc?.splash_slogan ?? 'Eslogan de bienvenida',
                  child: Text(
                    loc?.splash_slogan ??
                        'Si puedes leer, puedes comprender.\n'
                            'Y si puedes comprender, puedes cambiar tu vida.\n'
                            'Y si cambiamos vidas, cambiamos el mundo.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.5,
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
