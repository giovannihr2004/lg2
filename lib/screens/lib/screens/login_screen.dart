// -----------------------------------------------------------------------------
// Pantalla de inicio de sesión
// Archivo: login_screen.dart
// Descripción: Permite a los usuarios iniciar sesión en Lector Global.
// Versión: 1.2.0
// Fecha: 04/05/2025 - Hora: 13:08 (202505041308)
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'phone_verification_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailOrPhoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  Future<void> _signIn() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final input = _emailOrPhoneController.text.trim();
      final password = _passwordController.text.trim();

      if (input.contains('@')) {
        // Iniciar sesión con correo electrónico
        await _auth.signInWithEmailAndPassword(
          email: input,
          password: password,
        );
      } else {
        // Enviar SMS de verificación al teléfono
        await _auth.verifyPhoneNumber(
          phoneNumber: '+57$input', // Ajustar el código de país si es necesario
          verificationCompleted: (PhoneAuthCredential credential) async {
            // Inicio de sesión automático
            await _auth.signInWithCredential(credential);
          },
          verificationFailed: (FirebaseAuthException e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error en la verificación: ${e.message}')),
            );
          },
          codeSent: (String verificationId, int? resendToken) {
            // Navegar a la pantalla para ingresar el código
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) =>
                        PhoneVerificationScreen(verificationId: verificationId),
              ),
            );
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al iniciar sesión: ${e.message}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(title: const Text('Iniciar Sesión')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _emailOrPhoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico o teléfono',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña (solo para correo)',
                ),
              ),
              const SizedBox(height: 24),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                    onPressed: _signIn,
                    child: const Text('Ingresar'),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
