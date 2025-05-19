// -----------------------------------------------------------------------------
// 📄 Archivo: register_screen.dart
// 📍 Ubicación: lib/screens/auth/register_screen.dart
// 📝 Descripción: Pantalla de registro con validación, envío de verificación y Firebase
// 📅 Última actualización: 18/05/2025 - (Hora de Colombia)
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscureText = true;

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  Future<void> _register() async {
    final loc = AppLocalizations.of(context)!;

    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );

      await userCredential.user!.sendEmailVerification();

      _showSnackBar(loc.registrationSuccess);
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = loc.emailAlreadyInUse;
          break;
        case 'invalid-email':
          errorMessage = loc.invalidEmail;
          break;
        case 'weak-password':
          errorMessage = loc.weakPassword;
          break;
        case 'operation-not-allowed':
          errorMessage = loc.registrationDisabled;
          break;
        default:
          errorMessage = '${loc.registrationError}: ${e.message}';
      }
      _showSnackBar(errorMessage, isError: true);
    } catch (e) {
      _showSnackBar('${loc.unexpectedError}: $e', isError: true);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(loc.registerTitle)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: loc.emailLabel,
                  prefixIcon: const Icon(Icons.email_outlined),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return loc.pleaseEnterEmail;
                  }
                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value)) {
                    return loc.invalidEmail;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: loc.passwordLabelRegister,
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed:
                        () => setState(() => _obscureText = !_obscureText),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return loc.pleaseEnterPassword;
                  }
                  if (value.length < 8) {
                    return loc.passwordTooShort;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _register,
                  child:
                      _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(loc.registerButton),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
