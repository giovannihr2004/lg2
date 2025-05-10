// -----------------------------------------------------------------------------
// Pantalla de bienvenida
// Archivo: welcome_screen.dart
// Descripción: Pantalla inicial después de la presentación en Lector Global.
// Versión: 1.0.0
// Fecha: 04/05/2025 - Hora: 12:53 (202505041253)
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(title: const Text('Bienvenido')),
      body: const Center(
        child: Text(
          '¡Bienvenido a Lector Global!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
      ),
    );
  }
}
