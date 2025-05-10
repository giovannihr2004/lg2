// -----------------------------------------------------------------------------
// Pantalla de inicio de sesión por teléfono
// Archivo: phone_login_screen.dart
// Descripción: Permite al usuario ingresar su número de teléfono para recibir un código SMS.
// Versión: 1.0.1
// Fecha: 04/05/2025 - Hora: 15:16 (202505041516)
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'phone_verification_screen.dart';

class PhoneLoginScreen extends StatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  final _phoneController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isSendingCode = false;

  Future<void> _sendVerificationCode() async {
    setState(() {
      _isSendingCode = true;
    });

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: _phoneController.text.trim(),
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error de verificación: ${e.message}')),
            );
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          if (mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) =>
                        PhoneVerificationScreen(verificationId: verificationId),
              ),
            );
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al enviar código: ${e.message}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSendingCode = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(title: const Text('Iniciar sesión por Teléfono')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Número de teléfono (+57 ...)',
                ),
              ),
              const SizedBox(height: 24),
              _isSendingCode
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                    onPressed: _sendVerificationCode,
                    child: const Text('Enviar Código'),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
