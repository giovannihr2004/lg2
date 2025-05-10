// -----------------------------------------------------------------------------
// Pantalla intermedia con texto de la app
// Archivo: splash_text_screen.dart
// Descripción: Muestra "LECTOR GLOBAL" antes de la pantalla de prueba.
// Versión: 1.0.0
// Fecha: 25/04/2025
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'test_success_screen.dart'; // Importamos la pantalla de prueba

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

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const TestSuccessScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Center(
        child: FadeTransition(
          opacity: _fadeIn,
          child: const Text(
            'LECTOR GLOBAL',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
