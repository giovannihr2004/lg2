// -----------------------------------------------------------------------------
// 📄 Archivo: register_screen.dart
// 📝 Descripción: Registro de usuario moderno, validaciones estrictas, animaciones suaves.
// 📅 Última actualización: 06/05/2025 - (hora Colombia GMT-5)
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with TickerProviderStateMixin {
  // ---------------------------------------------------------------------------
  // Controladores y Variables
  // ---------------------------------------------------------------------------

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;
  double _buttonScale = 1.0;

  // Variables para controlar la animación de FadeIn
  bool _showNameField = false;
  bool _showEmailField = false;
  bool _showPasswordField = false;
  bool _showConfirmPasswordField = false;

  @override
  void initState() {
    super.initState();
    _startFadeInAnimations();
  }

  // Secuencia de aparición de campos
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

  // ---------------------------------------------------------------------------
  // Validadores de Campos
  // ---------------------------------------------------------------------------

  bool _isPasswordValid(String password) {
    final RegExp regex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$',
    );
    return regex.hasMatch(password);
  }

  bool _isEmailValid(String email) {
    final RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email);
  }

  Future<void> _register() async {
    final messenger = ScaffoldMessenger.of(context);
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        messenger.showSnackBar(
          const SnackBar(content: Text('Usuario registrado exitosamente.')),
        );
      }
    }
  }

  // ---------------------------------------------------------------------------
  // Construcción de la interfaz
  // ---------------------------------------------------------------------------

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
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: 'Nombre completo',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Por favor ingresa tu nombre completo.';
                      }
                      if (RegExp(r'[0-9]').hasMatch(value)) {
                        return 'El nombre no debe contener números.';
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
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: 'Correo electrónico',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Por favor ingresa tu correo electrónico.';
                      }
                      if (!_isEmailValid(value.trim())) {
                        return 'Por favor ingresa un correo válido.';
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
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor crea una contraseña.';
                      }
                      if (!_isPasswordValid(value)) {
                        return 'Debe tener mínimo 8 caracteres, una mayúscula, una minúscula, un número y un símbolo.';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),

                // Confirmar Contraseña
                AnimatedOpacity(
                  opacity: _showConfirmPasswordField ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: !_isConfirmPasswordVisible,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outline),
                      labelText: 'Confirmar Contraseña',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isConfirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isConfirmPasswordVisible =
                                !_isConfirmPasswordVisible;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor confirma tu contraseña.';
                      }
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
                          setState(() {
                            _buttonScale = 0.95;
                          });
                          await Future.delayed(
                            const Duration(milliseconds: 100),
                          );
                          setState(() {
                            _buttonScale = 1.0;
                          });

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
