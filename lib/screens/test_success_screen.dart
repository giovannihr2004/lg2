// -----------------------------------------------------------------------------
// 📄 Archivo: test_success_screen.dart
// 📍 Ubicación: lib/screens/auth/test_success_screen.dart
// 📝 Descripción: Muestra un mensaje de éxito y permite regresar a las opciones.
// 📅 Última actualización: 06/05/2025 - 18:50 (Hora de Colombia)
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:lector_global/screens/auth/login_screen.dart';
import 'package:lector_global/screens/auth/register_screen.dart';

class TestSuccessScreen extends StatelessWidget {
  const TestSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle_outline,
                size: 80,
                color: Colors.green,
              ),
              const SizedBox(height: 24),
              const Text(
                '¡Registro exitoso!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Puedes regresar a las opciones de registro o iniciar sesión.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: const Text('Volver al inicio de sesión'),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterScreen()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: const Text('Volver al registro'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
