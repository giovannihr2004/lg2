// -----------------------------------------------------------------------------
// 📄 Archivo: email_verification_screen.dart
// 📍 Ubicación: lib/screens/auth/email_verification_screen.dart
// 📝 Descripción: Pantalla para confirmar la verificación del correo electrónico
// 📅 Última actualización: 24/05/2025 - 18:40 (Hora de Colombia)
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
// INICIO PARTE 1 - Importaciones necesarias
// -----------------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// -----------------------------------------------------------------------------
// FIN PARTE 1
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
// INICIO PARTE 2 - Widget principal de la pantalla
// -----------------------------------------------------------------------------
class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool _checking = false;

  Future<void> _checkVerification() async {
    setState(() => _checking = true);
    final user = FirebaseAuth.instance.currentUser;

    await user?.reload(); // 🔄 Refrescar datos
    final refreshedUser = FirebaseAuth.instance.currentUser;

    if (refreshedUser?.emailVerified ?? false) {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else {
      setState(() => _checking = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            '❌ Tu correo aún no ha sido verificado. Intenta nuevamente.',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.verifyEmailTitle),
        backgroundColor: Colors.deepPurple,
      ),
      backgroundColor: Colors.deepPurple[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.mark_email_read_rounded,
                size: 80,
                color: Colors.deepPurple,
              ),
              const SizedBox(height: 16),
              Text(
                loc.verifyEmailInstruction,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              _checking
                  ? const CircularProgressIndicator()
                  : ElevatedButton.icon(
                    onPressed: _checkVerification,
                    icon: const Icon(Icons.refresh),
                    label: Text(loc.checkVerificationButton),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// FIN PARTE 2 - Fin del archivo completo
// -----------------------------------------------------------------------------
