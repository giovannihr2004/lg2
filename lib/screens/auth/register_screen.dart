// -----------------------------------------------------------------------------
// 📄 Archivo: register_screen.dart
// 📍 Ubicación: lib/screens/auth/register_screen.dart
// 📝 Descripción: Registro con validaciones, verificación, almacenamiento y displayName
// ♿ Mejora: Accesibilidad con Semantics implementada en campos clave
// 📅 Última actualización: 22/05/2025 - 21:00 (Hora de Colombia)
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
// 1. Importaciones necesarias
// -----------------------------------------------------------------------------
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

// -----------------------------------------------------------------------------
// 2. Definición del StatefulWidget RegisterScreen
// -----------------------------------------------------------------------------
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

// -----------------------------------------------------------------------------
// 3. Estado interno del formulario de registro con controladores y lógica
// -----------------------------------------------------------------------------
class _RegisterScreenState extends State<RegisterScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _isLoading = false;
  bool _isEmailChecking = false;
  bool _isEmailDuplicate = false;
  String? _emailErrorMessage;

  String selectedCountryCode = '+57';
  String selectedFlagEmoji = '🇨🇴';
  String fullPhoneNumber = '';

  Timer? _debounceTimer;

  // ---------------------------------------------------------------------------
  // 4. Mostrar snackbar con mensaje contextual
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
  // 5. Función principal de registro
  // ✔️ Verifica campos, crea usuario, guarda displayName, envía verificación
  // ✔️ Guarda información en Firestore (colección: usuarios)
  // ---------------------------------------------------------------------------
  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      // 5.1 Crear usuario en Firebase Auth
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      final user = userCredential.user;
      if (user == null) throw Exception("No se pudo crear el usuario");

      // 5.2 Guardar displayName en el perfil del usuario
      await user.updateDisplayName(_nameController.text.trim());

      // 5.3 Enviar correo de verificación
      await user.sendEmailVerification();

      // 5.4 Preparar datos adicionales para Firestore
      final name = _nameController.text.trim();
      final email = _emailController.text.trim();
      final phone = fullPhoneNumber;
      final uid = user.uid;

      // 5.5 Guardar usuario completo en Firestore
      await FirebaseFirestore.instance.collection('usuarios').doc(uid).set({
        'uid': uid,
        'email': email,
        'displayName': name,
        'phoneNumber': phone,
        'countryCode': selectedCountryCode,
        'flagEmoji': selectedFlagEmoji,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // 5.6 Mostrar éxito y navegar al dashboard
      if (!mounted) return;
      _showSnackBar(AppLocalizations.of(context)!.registrationSuccess);
      Navigator.pushReplacementNamed(context, '/dashboard');
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
  // 6. Verificación de correo duplicado con debounce
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
      final methods = await _auth.fetchSignInMethodsForEmail(email.trim());
      if (methods.isNotEmpty) {
        setState(() {
          _isEmailDuplicate = true;
          _emailErrorMessage = AppLocalizations.of(context)!.emailAlreadyInUse;
        });
      }
    } on FirebaseAuthException catch (_) {
      setState(() {
        _emailErrorMessage = AppLocalizations.of(context)!.invalidEmail;
      });
    } finally {
      if (mounted) setState(() => _isEmailChecking = false);
    }
  }

  // ---------------------------------------------------------------------------
  // 7. Inicio del formulario visual con campos accesibles
  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(loc.registerTitle)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // -----------------------------------------------------------------
              // Campo 1: Nombre con Semantics
              // -----------------------------------------------------------------
              Semantics(
                label: 'Nombre completo',
                textField: true,
                child: TextFormField(
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
              ),
              const SizedBox(height: 16),

              // -----------------------------------------------------------------
              // Campo 2: Correo electrónico con Semantics
              // -----------------------------------------------------------------
              Semantics(
                label: 'Correo electrónico',
                textField: true,
                child: TextFormField(
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
                            : const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),
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
              ),
              const SizedBox(height: 16),

              // -----------------------------------------------------------------
              // Campo 3: Número de teléfono con Semantics
              // -----------------------------------------------------------------
              Semantics(
                label: 'Número de teléfono con código de país',
                textField: true,
                child: IntlPhoneField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: loc.phoneLabel,
                    helperText: loc.includeCountryCode,
                    border: const OutlineInputBorder(),
                  ),
                  initialCountryCode: 'CO',
                  onChanged: (phone) {
                    selectedCountryCode = '+${phone.countryCode}';
                    selectedFlagEmoji =
                        phone.countryISOCode == 'CO' ? '🇨🇴' : '🌐';
                    fullPhoneNumber = phone.completeNumber;
                    setState(() {});
                  },
                  validator: (value) {
                    if (value == null || value.number.isEmpty) {
                      return loc.pleaseEnterPhone;
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),

              // -----------------------------------------------------------------
              // Campo 4: Contraseña con Semantics y botón de visibilidad
              // -----------------------------------------------------------------
              Semantics(
                label:
                    'Contraseña. Mínimo 8 caracteres, mayúscula, minúscula, número y símbolo',
                textField: true,
                child: TextFormField(
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
                          () => setState(() {
                            _obscurePassword = !_obscurePassword;
                          }),
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
              ),
              const SizedBox(height: 8),

              // -----------------------------------------------------------------
              // Checklist visual de requisitos de contraseña
              // -----------------------------------------------------------------
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
                    _buildCheckItem(
                      _confirmPasswordController.text ==
                          _passwordController.text,
                      '• Las contraseñas coinciden',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // -----------------------------------------------------------------
              // Campo 5: Confirmar contraseña con Semantics
              // -----------------------------------------------------------------
              Semantics(
                label: 'Confirmar contraseña. Debe coincidir con la anterior',
                textField: true,
                child: TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirm,
                  decoration: InputDecoration(
                    labelText: loc.confirmPasswordLabel,
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirm
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed:
                          () => setState(() {
                            _obscureConfirm = !_obscureConfirm;
                          }),
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
              ),
              const SizedBox(height: 24),
              // -----------------------------------------------------------------
              // Botón principal de registro con Semantics
              // -----------------------------------------------------------------
              Semantics(
                label: 'Botón para crear cuenta',
                button: true,
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _isLoading || !_isFormValid() ? null : _register,
                    child:
                        _isLoading
                            ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                            : Text(loc.registerButton),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 8. Ítem visual del checklist de contraseña
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

  // ---------------------------------------------------------------------------
  // 9. Validación completa del formulario (todos los campos clave)
  // ---------------------------------------------------------------------------
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

  // ---------------------------------------------------------------------------
  // 10. Liberar recursos al cerrar la pantalla
  // ---------------------------------------------------------------------------
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }
}
