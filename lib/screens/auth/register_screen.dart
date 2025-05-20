// -----------------------------------------------------------------------------
// 📄 Archivo: register_screen.dart
// 📍 Ubicación: lib/screens/auth/register_screen.dart
// 📝 Descripción: Registro con checklist visual y botón condicional.
// 📅 Última actualización: 19/05/2025 - 23:52 (Hora de Colombia)
// -----------------------------------------------------------------------------

import 'dart:async'; // Para debounce

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

  // 2.1 Controladores para campos del formulario
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // 2.2 Estados para visibilidad y carga
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _isLoading = false;

  bool _isEmailChecking = false;
  bool _isEmailDuplicate = false;
  String? _emailErrorMessage;

  Timer? _debounceTimer;

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
  // 5. Función para verificar si el correo ya está registrado (debounce)
  // ---------------------------------------------------------------------------
  void _onEmailChanged(String email) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _checkEmailDuplicate(email);
    });
  }

  Future<void> _checkEmailDuplicate(String email) async {
    if (email.trim().isEmpty) return;

    setState(() {
      _isEmailChecking = true;
      _emailErrorMessage = null;
      _isEmailDuplicate = false;
    });

    try {
      final methods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(
        email.trim(),
      );
      if (methods.isNotEmpty) {
        setState(() {
          _isEmailDuplicate = true;
          _emailErrorMessage = AppLocalizations.of(context)!.emailAlreadyInUse;
        });
      }
    } catch (e) {
      setState(() {
        _emailErrorMessage = AppLocalizations.of(context)!.invalidEmail;
      });
    } finally {
      if (mounted) setState(() => _isEmailChecking = false);
    }
  }

  // ---------------------------------------------------------------------------
  // 6. Construcción del widget (formulario)
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
              // Campo: Nombre
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: loc.nameLabel,
                  prefixIcon: const Icon(Icons.person_outline),
                ),
                onChanged: (_) => setState(() {}),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return loc.pleaseEnterName;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo: Email con debounce y verificación duplicado
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: loc.emailLabel,
                  prefixIcon: const Icon(Icons.email_outlined),
                  suffixIcon:
                      _isEmailChecking
                          ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                          : _isEmailDuplicate
                          ? const Icon(Icons.error, color: Colors.red)
                          : const Icon(Icons.check_circle, color: Colors.green),
                ),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  setState(() {});
                  _onEmailChanged(value);
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return loc.pleaseEnterEmail;
                  }
                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value)) {
                    return loc.invalidEmail;
                  }
                  if (_isEmailDuplicate) {
                    return _emailErrorMessage;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Campo: Teléfono
              IntlPhoneField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: loc.phoneLabel,
                  helperText: loc.includeCountryCode,
                  border: const OutlineInputBorder(),
                ),
                initialCountryCode: 'CO',
                onChanged: (_) => setState(() {}),
                validator: (value) {
                  if (value == null || value.number.isEmpty) {
                    return loc.pleaseEnterPhone;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo: Contraseña
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

              // Checklist visual
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
              // Campo: Confirmar Contraseña
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
                onChanged: (_) => setState(() {}),
                validator: (value) {
                  if (value != _passwordController.text) {
                    return loc.passwordsDoNotMatch;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Botón: Registrarse
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _isLoading || !_isFormValid() ? null : _register,
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

  // Widget para checklist visual
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

  // Validación del formulario
  bool _isFormValid() {
    final password = _passwordController.text;
    final confirm = _confirmPasswordController.text;
    final email = _emailController.text;
    final name = _nameController.text;
    final phone = _phoneController.text;

    final validPassword =
        password.length >= 8 &&
        RegExp(r'[A-Z]').hasMatch(password) &&
        RegExp(r'[a-z]').hasMatch(password) &&
        RegExp(r'[0-9]').hasMatch(password) &&
        RegExp(r'[!@#\$&*~%^_+=().,\-]').hasMatch(password);

    final validEmail = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    ).hasMatch(email);
    final validPhone = phone.isNotEmpty;
    final validName = name.trim().isNotEmpty;

    return validName &&
        validEmail &&
        validPhone &&
        validPassword &&
        password == confirm &&
        !_isEmailDuplicate;
  }

  @override
  void dispose() {
    // Liberar recursos de los controladores para evitar fugas de memoria
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }
}
