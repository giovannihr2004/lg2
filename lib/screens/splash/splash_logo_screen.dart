// -----------------------------------------------------------------------------
// 📄 Archivo: splash_logo_screen.dart
// 📍 Ubicación: lib/screens/splash/splash_logo_screen.dart
// 📝 Descripción: Muestra el logo animado y redirige con transición a SplashTextScreen
// 📅 Última actualización: 13/05/2025 - 17:57 (Hora de Colombia)
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
// 1. Importaciones necesarias
// -----------------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'splash_text_screen.dart'; // ⚠️ Asegúrate de que esta pantalla exista

// -----------------------------------------------------------------------------
// 2. Widget principal con estado: SplashLogoScreen
// -----------------------------------------------------------------------------
class SplashLogoScreen extends StatefulWidget {
  const SplashLogoScreen({super.key});

  @override
  State<SplashLogoScreen> createState() => _SplashLogoScreenState();
}

// -----------------------------------------------------------------------------
// 3. Clase de estado con animación y navegación automática
// -----------------------------------------------------------------------------
class _SplashLogoScreenState extends State<SplashLogoScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();

    // Configura animación fade-in
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    // Navegación automática tras la animación
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const SplashTextScreen(),
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
  // 4. Construcción visual con el logo centrado y animado
  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      body: Center(
        child: FadeTransition(
          opacity: _fadeIn,
          child: Image.asset(
            'assets/images/logo1.png', // ⚠️ Verifica que esté incluido en pubspec.yaml
            height: 160,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
