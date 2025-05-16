// -----------------------------------------------------------------------------
// 📄 Archivo: splash_wrapper_screen.dart
// 📍 Ubicación: lib/screens/splash/splash_wrapper_screen.dart
// 📝 Descripción: Pantalla intermedia para redirigir al logo tras el cambio de idioma.
// 📅 Última actualización: 15/05/2025 - 21:50 (Hora de Colombia)
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:lector_global/screens/splash/splash_logo_screen.dart';

class SplashWrapperScreen extends StatefulWidget {
  const SplashWrapperScreen({super.key});

  @override
  State<SplashWrapperScreen> createState() => _SplashWrapperScreenState();
}

class _SplashWrapperScreenState extends State<SplashWrapperScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const SplashLogoScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
