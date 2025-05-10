// -----------------------------------------------------------------------------
// Pantalla de verificación por SMS
// Archivo: phone_verification_screen.dart
// Descripción: Permite al usuario ingresar el código de verificación recibido.
// Versión: 1.0.0
// Fecha: 04/05/2025 - Hora: 13:08 (202505041308)
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PhoneVerificationScreen extends StatefulWidget {
  final String verificationId;

  const PhoneVerificationScreen({super.key, required this.verificationId});

  @override
  State<PhoneVerificationScreen> createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  final _codeController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isVerifying = false;

  Future<void> _verifyCode() async {
    setState(() {
      _isVerifying = true;
    });

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: _codeController.text.trim(),
      );

      await _auth.signInWithCredential(credential);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Inicio de sesión exitoso')));

      Navigator.popUntil(context, (route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al verificar el código: ${e.message}')),
      );
    } finally {
      setState(() {
        _isVerifying = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(title: const Text('Verificar Código')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _codeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Código de verificación',
                ),
              ),
              const SizedBox(height: 24),
              _isVerifying
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                    onPressed: _verifyCode,
                    child: const Text('Verificar'),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
