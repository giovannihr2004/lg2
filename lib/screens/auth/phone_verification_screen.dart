// -----------------------------------------------------------------------------
// 📄 Archivo: phone_verification_screen.dart
// 📍 Ubicación: lib/screens/auth/phone_verification_screen.dart
// 📝 Descripción: Pantalla para ingresar el código SMS de verificación.
// 📅 Última actualización: 24/05/2025 - 15:40 (Hora de Colombia)
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PhoneVerificationScreen extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;

  const PhoneVerificationScreen({
    super.key,
    required this.verificationId,
    required this.phoneNumber,
  });

  @override
  State<PhoneVerificationScreen> createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  final TextEditingController _codeController = TextEditingController();
  bool _isVerifying = false;
  String? _currentVerificationId;
  int? _resendToken;

  @override
  void initState() {
    super.initState();
    _currentVerificationId = widget.verificationId;
  }

  // 🔐 Verifica el código SMS ingresado
  Future<void> _verifyCode() async {
    setState(() => _isVerifying = true);

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _currentVerificationId!,
        smsCode: _codeController.text.trim(),
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ ¡Inicio de sesión exitoso!')),
      );

      Navigator.pushReplacementNamed(context, '/dashboard');
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Error al verificar el código: ${e.message}')),
      );
    } finally {
      if (mounted) setState(() => _isVerifying = false);
    }
  }

  // 🔁 Reenvía un nuevo código SMS
  Future<void> _resendCode() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: widget.phoneNumber,
      timeout: const Duration(seconds: 60),
      forceResendingToken: _resendToken,
      verificationCompleted: (_) {},
      verificationFailed: (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('❌ Error al reenviar código: ${e.message}')),
        );
      },
      codeSent: (verificationId, resendToken) {
        setState(() {
          _currentVerificationId = verificationId;
          _resendToken = resendToken;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('📩 Código reenviado exitosamente')),
        );
      },
      codeAutoRetrievalTimeout: (_) {},
    );
  }

  // 🖼️ Interfaz de usuario
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verificar Código'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white, // ✅ Mejora de contraste
      ),
      backgroundColor: Colors.deepPurple[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Introduce el código SMS enviado a:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                widget.phoneNumber,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _codeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Código de verificación',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: _resendCode,
                child: const Text(
                  '¿No recibiste el código? Reenviar SMS',
                  style: TextStyle(color: Colors.deepPurple),
                ),
              ),
              const SizedBox(height: 8),
              _isVerifying
                  ? const CircularProgressIndicator()
                  : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _verifyCode,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Verificar'),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
