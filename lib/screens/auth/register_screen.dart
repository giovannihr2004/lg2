// -----------------------------------------------------------------------------
// 📄 Archivo: register_screen.dart
// 📍 Ubicación: lib/screens/auth/register_screen.dart
// 📝 Descripción: Registro con validaciones visuales, checklist y accesibilidad.
// 📅 Última actualización: 19/05/2025 - 23:52 (Hora de Colombia)
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

// -----------------------------------------------------------------------------
// 1. Clase StatefulWidget para la pantalla de registro
// -----------------------------------------------------------------------------
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

// -----------------------------------------------------------------------------
// 2. Estado interno de la pantalla de registro
// -----------------------------------------------------------------------------
class _RegisterScreenState extends State<RegisterScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // 2.1 Controladores
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // 2.2 Estados
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _isLoading = false;

  // ---------------------------------------------------------------------------
  // 3. Función para mostrar mensajes con SnackBar
  // ---------------------------------------------------------------------------
  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 4. Función para registrar al usuario con validaciones
  // ---------------------------------------------------------------------------
  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      await userCredential.user!.sendEmailVerification();

      if (!mounted) return;
      _showSnackBar(AppLocalizations.of(context)!.registrationSuccess);
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      final loc = AppLocalizations.of(context)!;
      String msg;
      switch (e.code) {
        case 'email-already-in-use':
          msg = loc.emailAlreadyInUse;
          break;
        case 'invalid-email':
          msg = loc.invalidEmail;
          break;
        case 'weak-password':
          msg = loc.weakPassword;
          break;
        case 'operation-not-allowed':
          msg = loc.registrationDisabled;
          break;
        default:
          msg = '${loc.registrationError}: ${e.message}';
      }
      _showSnackBar(msg, isError: true);
    } catch (e) {
      if (!mounted) return;
      _showSnackBar(
        '${AppLocalizations.of(context)!.unexpectedError}: $e',
        isError: true,
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // ---------------------------------------------------------------------------
  // 5. Construcción del widget (formulario)
  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(loc.registerTitle)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // 5.1 Campo: Nombre
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: loc.nameLabel,
                  prefixIcon: const Icon(Icons.person_outline),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return loc.pleaseEnterName;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // 5.2 Campo: Email
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

              // 5.3 Campo: Teléfono
              IntlPhoneField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: loc.phoneLabel,
                  helperText: loc.includeCountryCode,
                  border: const OutlineInputBorder(),
                ),
                initialCountryCode: 'CO',
                onChanged: (phone) {},
                validator: (value) {
                  if (value == null || value.number.isEmpty) {
                    return loc.pleaseEnterPhone;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // 5.4 Campo: Contraseña
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: loc.passwordLabelRegister,
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed:
                        () => setState(
                          () => _obscurePassword = !_obscurePassword,
                        ),
                  ),
                ),
                onChanged: (_) => setState(() {}),
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
              const SizedBox(height: 8),

              // 5.4.1 Checklist visual
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCheckItem(
                      _passwordController.text.length >= 8,
                      '• Mínimo 8 caracteres',
                    ),
                    _buildCheckItem(
                      RegExp(r'[A-Z]').hasMatch(_passwordController.text),
                      '• Una letra mayúscula',
                    ),
                    _buildCheckItem(
                      RegExp(r'[a-z]').hasMatch(_passwordController.text),
                      '• Una letra minúscula',
                    ),
                    _buildCheckItem(
                      RegExp(r'[0-9]').hasMatch(_passwordController.text),
                      '• Un número',
                    ),
                    _buildCheckItem(
                      RegExp(
                        r'[!@#\$&*~%^_+=().,\-]',
                      ).hasMatch(_passwordController.text),
                      '• Un carácter especial',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 5.5 Campo: Confirmar Contraseña
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirm,
                decoration: InputDecoration(
                  labelText: loc.confirmPasswordLabel,
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirm ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed:
                        () =>
                            setState(() => _obscureConfirm = !_obscureConfirm),
                  ),
                ),
                validator: (value) {
                  if (value != _passwordController.text) {
                    return loc.passwordsDoNotMatch;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // 5.6 Botón: Registrarse
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

  // ---------------------------------------------------------------------------
  // 6. Widget para checklist visual
  // ---------------------------------------------------------------------------
  Widget _buildCheckItem(bool condition, String text) {
    return Row(
      children: [
        Icon(
          condition ? Icons.check_circle : Icons.cancel,
          color: condition ? Colors.green : Colors.red,
          size: 16,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            color: condition ? Colors.green : Colors.red,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
