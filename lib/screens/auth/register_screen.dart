// -----------------------------------------------------------------------------
// 📄 Archivo: register_screen.dart
// 📍 Ubicación: lib/screens/auth/register_screen.dart
// 📝 Descripción: Registro con validación en tiempo real e íconos de retroalimentación
// 📅 Última actualización: 16/05/2025 - 12:57 (Hora de Colombia)
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;
  double _buttonScale = 1.0;

  // Estado de aparición animada
  bool _showNameField = false;
  bool _showEmailField = false;
  bool _showPasswordField = false;
  bool _showConfirmPasswordField = false;

  // Estado de validación en tiempo real
  bool _isNameValid = false;
  bool _isEmailValid = false;
  bool _isPasswordValidField = false;

  @override
  void initState() {
    super.initState();
    _startFadeInAnimations();
  }

  void _startFadeInAnimations() async {
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() => _showNameField = true);
    await Future.delayed(const Duration(milliseconds: 150));
    setState(() => _showEmailField = true);
    await Future.delayed(const Duration(milliseconds: 150));
    setState(() => _showPasswordField = true);
    await Future.delayed(const Duration(milliseconds: 150));
    setState(() => _showConfirmPasswordField = true);
  }

  bool _validateName(String value) {
    return value.trim().isNotEmpty && !RegExp(r'[0-9]').hasMatch(value);
  }

  bool _validateEmail(String value) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
  }

  bool _validatePassword(String value) {
    return RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$',
    ).hasMatch(value);
  }

  Future<void> _register() async {
    final messenger = ScaffoldMessenger.of(context);
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        setState(() => _isLoading = false);
        messenger.showSnackBar(
          const SnackBar(content: Text('Usuario registrado exitosamente.')),
        );
      }
    }
  }

  Icon? _buildValidationIcon(bool isValid) {
    return isValid
        ? const Icon(Icons.check_circle, color: Colors.green)
        : const Icon(Icons.error_outline, color: Colors.redAccent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: const Text('Crear cuenta'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  '¡Bienvenido!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Crea tu cuenta para comenzar',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // Nombre
                AnimatedOpacity(
                  opacity: _showNameField ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      labelText: 'Nombre completo',
                      border: const OutlineInputBorder(),
                      suffixIcon:
                          _nameController.text.isEmpty
                              ? null
                              : _buildValidationIcon(_isNameValid),
                    ),
                    onChanged:
                        (value) =>
                            setState(() => _isNameValid = _validateName(value)),
                    validator: (value) {
                      if (!_validateName(value ?? '')) {
                        return 'Nombre inválido.';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),

                // Email
                AnimatedOpacity(
                  opacity: _showEmailField ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email),
                      labelText: 'Correo electrónico',
                      border: const OutlineInputBorder(),
                      suffixIcon:
                          _emailController.text.isEmpty
                              ? null
                              : _buildValidationIcon(_isEmailValid),
                    ),
                    onChanged:
                        (value) => setState(
                          () => _isEmailValid = _validateEmail(value),
                        ),
                    validator: (value) {
                      if (!_validateEmail(value ?? '')) {
                        return 'Correo inválido.';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),

                // Contraseña
                AnimatedOpacity(
                  opacity: _showPasswordField ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      labelText: 'Contraseña',
                      border: const OutlineInputBorder(),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (_passwordController.text.isNotEmpty)
                            _buildValidationIcon(_isPasswordValidField)!,
                          IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(
                                () => _isPasswordVisible = !_isPasswordVisible,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    onChanged:
                        (value) => setState(
                          () =>
                              _isPasswordValidField = _validatePassword(value),
                        ),
                    validator: (value) {
                      if (!_validatePassword(value ?? '')) {
                        return 'Mínimo 8 caracteres, mayúscula, minúscula, número y símbolo.';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),

                // Confirmar contraseña
                AnimatedOpacity(
                  opacity: _showConfirmPasswordField ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: !_isConfirmPasswordVisible,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outline),
                      labelText: 'Confirmar contraseña',
                      border: const OutlineInputBorder(),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (_confirmPasswordController.text.isNotEmpty)
                            _buildValidationIcon(
                              _confirmPasswordController.text ==
                                  _passwordController.text,
                            )!,
                          IconButton(
                            icon: Icon(
                              _isConfirmPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(
                                () =>
                                    _isConfirmPasswordVisible =
                                        !_isConfirmPasswordVisible,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    onChanged: (_) => setState(() {}),
                    validator: (value) {
                      if (value != _passwordController.text) {
                        return 'Las contraseñas no coinciden.';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 32),

                // Botón de registro
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : AnimatedScale(
                      scale: _buttonScale,
                      duration: const Duration(milliseconds: 200),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () async {
                          setState(() => _buttonScale = 0.95);
                          await Future.delayed(
                            const Duration(milliseconds: 100),
                          );
                          setState(() => _buttonScale = 1.0);
                          await _register();
                        },
                        child: const Text(
                          'Registrarse',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
