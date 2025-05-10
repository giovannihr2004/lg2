// -----------------------------------------------------------------------------
// Pantalla de presentación con texto motivador
// Archivo: splash_text_screen.dart
// Descripción: Muestra un texto de bienvenida y navega automáticamente.
// Versión: 1.0.0
// Fecha: 04/05/2025 - Hora: 12:43 (202505041243)
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import '../welcome_screen.dart';

class SplashTextScreen extends StatefulWidget {
  const SplashTextScreen({super.key});

  @override
  State<SplashTextScreen> createState() => _SplashTextScreenState();
}

class _SplashTextScreenState extends State<SplashTextScreen> {
  @override
  void initState() {
    super.initState();
    // Espera 3 segundos y navega automáticamente a la pantalla de bienvenida
    Future.delayed(const Duration(seconds: 3), () {
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      body: const Center(
        child: Text(
          'LECTOR GLOBAL',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
      ),
    );
  }
}
