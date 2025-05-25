// -----------------------------------------------------------------------------
// 📄 Archivo: reset_password_screen.dart
// 📍 Ubicación: lib/screens/auth/reset_password_screen.dart
// 📝 Descripción: Pantalla para recuperar contraseña por correo (Firebase)
// ♿ Mejora: Accesibilidad con Semantics aplicada en campos clave
// 📅 Última actualización: 22/05/2025 - 21:40 (Hora de Colombia)
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
// 1. Importaciones necesarias
// -----------------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// -----------------------------------------------------------------------------
// 2. Widget con estado: ResetPasswordScreen
// -----------------------------------------------------------------------------
class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

// -----------------------------------------------------------------------------
// 3. Lógica de la pantalla y validaciones
// -----------------------------------------------------------------------------
class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool _isSending = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // 3.1 Validación básica de correo electrónico
  // ---------------------------------------------------------------------------
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  // ---------------------------------------------------------------------------
  // 3.2 Enviar correo de recuperación (Firebase)
  // ---------------------------------------------------------------------------
  Future<void> _sendResetEmail() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSending = true);
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.resetPasswordSuccess),
        ),
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${AppLocalizations.of(context)!.loginError}: ${e.message}',
          ),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  // ---------------------------------------------------------------------------
  // 4. Construcción visual de la interfaz accesible
  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(loc.forgotPassword)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 40),

              // -----------------------------------------------------------------
              // 4.1 Campo de correo electrónico con accesibilidad
              // -----------------------------------------------------------------
              Semantics(
                label: 'Correo electrónico para recuperar la contraseña',
                textField: true,
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: loc.emailLabel,
                    prefixIcon: const Icon(Icons.email_outlined),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return loc.pleaseEnterEmailOrPhone;
                    }
                    if (!_isValidEmail(value.trim())) {
                      return loc.invalidEmail;
                    }
                    return null;
                  },
                ),
              ),

              const SizedBox(height: 24),

              // -----------------------------------------------------------------
              // 4.2 Botón "Recuperar contraseña" con Semantics
              // -----------------------------------------------------------------
              Semantics(
                label: 'Enviar enlace para recuperar contraseña',
                button: true,
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: _isSending ? null : _sendResetEmail,
                    icon: const Icon(Icons.send),
                    label:
                        _isSending
                            ? const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            )
                            : Text(loc.resetPasswordButton),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
