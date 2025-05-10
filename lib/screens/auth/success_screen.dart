// -----------------------------------------------------------------------------
// Pantalla de confirmación de registro para Lector Global
// Archivo: success_screen.dart
// Descripción: Muestra un mensaje de registro exitoso y permite volver al login.
// Versión: 1.0.0
// Fecha: 25/04/2025 - Hora: 01:07 (202504250107)
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'login_screen.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ícono de éxito
              const Icon(
                Icons.check_circle_outline,
                size: 100,
                color: Colors.deepPurple,
              ),

              const SizedBox(height: 32),

              // Mensaje de éxito
              const Text(
                '¡Registro exitoso!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              const Text(
                'Tu cuenta ha sido creada correctamente.\nYa puedes iniciar sesión.',
                style: TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              // Botón para volver al login
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Volver al inicio'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
