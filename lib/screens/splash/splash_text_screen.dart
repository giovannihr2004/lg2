// -----------------------------------------------------------------------------
// 📄 Archivo: splash_text_screen.dart
// 📍 Ubicación: lib/screens/splash/splash_text_screen.dart
// 📝 Descripción: Pantalla con eslogan animado y transición automática a WelcomeScreen
// 📅 Última actualización: 13/05/2025 - 18:00 (Hora de Colombia)
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
// 1. Importaciones necesarias
// -----------------------------------------------------------------------------
import 'package:flutter/material.dart';
import '../welcome_screen.dart'; // ⚠️ Verifica que welcome_screen.dart exista en lib/screens/

// -----------------------------------------------------------------------------
// 2. Widget principal: SplashTextScreen
// -----------------------------------------------------------------------------
class SplashTextScreen extends StatefulWidget {
  const SplashTextScreen({super.key});

  @override
  State<SplashTextScreen> createState() => _SplashTextScreenState();
}

// -----------------------------------------------------------------------------
// 3. Estado con animación fade-in y navegación automática
// -----------------------------------------------------------------------------
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

    // Navega automáticamente a WelcomeScreen tras 4.5 segundos
    Future.delayed(const Duration(milliseconds: 4500), () {
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

  // ---------------------------------------------------------------------------
  // 4. Construcción visual: nombre de la app y eslogan institucional
  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      body: Center(
        child: FadeTransition(
          opacity: _fadeIn,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'LECTOR GLOBAL',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  'Si puedes leer, puedes comprender.\n'
                  'Y si puedes comprender, puedes cambiar tu vida.\n'
                  'Y si cambiamos vidas, cambiamos el mundo.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    height: 1.5,
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
