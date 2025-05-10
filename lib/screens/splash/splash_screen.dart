// -----------------------------------------------------------------------------
// 📄 Archivo: splash_screen.dart
// 📍 Ubicación: lib/screens/auth/splash_screen.dart
// 📝 Descripción: Muestra el logo animado y redirige automáticamente al login.
// 📅 Última actualización: 06/05/2025 - 19:10 (Hora de Colombia)
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:lector_global/screens/auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Inicialización del controlador de animación
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();

    // Curva de animación para el logo
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );

    // Redirigir automáticamente al login luego de 3 segundos
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Construcción de la interfaz
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Image.asset('assets/images/logo1.png', height: 160),
        ),
      ),
    );
  }
}
