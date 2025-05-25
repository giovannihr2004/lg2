// -----------------------------------------------------------------------------
// 📄 Archivo: splash_screen.dart (Paso 1: animación suave)
// 📝 Descripción: Pantalla temporal con texto animado
// ♿ Mejora: Accesibilidad con Semantics aplicada al contenido visible
// 📅 Última actualización: 22/05/2025 - 22:30 (Hora de Colombia)
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
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
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: _fadeIn,
          // ♿ Descripción audible para usuarios con lector de pantalla
          child: Semantics(
            label: 'Cargando aplicación',
            child: const Text(
              'Cargando...',
              style: TextStyle(
                fontSize: 24,
                color: Colors.deepPurple,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
