// -----------------------------------------------------------------------------
// 📄 Archivo: splash_logo_screen.dart
// 📍 Ubicación: lib/screens/auth/splash_logo_screen.dart
// 📝 Descripción: Muestra el logo centrado y navega automáticamente después de 3 segundos.
// 📅 Última actualización: 06/05/2025 - 20:00 (Hora de Colombia)
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'splash_text_screen.dart';

class SplashLogoScreen extends StatefulWidget {
  const SplashLogoScreen({super.key});

  @override
  State<SplashLogoScreen> createState() => _SplashLogoScreenState();
}

class _SplashLogoScreenState extends State<SplashLogoScreen> {
  @override
  void initState() {
    super.initState();
    // Espera 3 segundos y navega automáticamente a la pantalla de texto de presentación
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const SplashTextScreen(),
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 800),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      body: Center(child: Image.asset('assets/images/logo1.png', height: 180)),
    );
  }
}
