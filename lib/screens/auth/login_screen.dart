// -----------------------------------------------------------------------------
// 📄 Archivo: login_screen.dart
// 📍 Ubicación: lib/screens/auth/login_screen.dart
// 📝 Descripción: Pantalla de login con validaciones visuales (correo/contraseña)
// 📅 Última actualización: 13/05/2025 - 22:20 (Hora de Colombia)
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
// 1. Importaciones
// -----------------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../providers/language_provider.dart';
import '../../widgets/language_selector.dart';

// -----------------------------------------------------------------------------
// 2. Widget principal con estado: LoginScreen
// -----------------------------------------------------------------------------
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// -----------------------------------------------------------------------------
// 3. Estado de LoginScreen: variables, validadores, lógica
// -----------------------------------------------------------------------------
class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailOrPhoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;
  bool _isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Limpieza de controladores al salir de la pantalla
  @override
  void dispose() {
    emailOrPhoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // 3.1 Validadores auxiliares
  // ---------------------------------------------------------------------------
  bool _isEmail(String input) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(input);
  }

  bool _isPhone(String input) {
    return RegExp(r'^\+?[0-9]{7,15}$').hasMatch(input);
  }

  // Validador seguro de contraseña (mínimo 8, mayús, minús, número, símbolo)
  bool _isValidPassword(String input) {
    return RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$',
    ).hasMatch(input);
  }

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
  // 3.2 Lógica de login
  // ---------------------------------------------------------------------------
  Future<void> _login() async {
    final input = emailOrPhoneController.text.trim();
    final password = passwordController.text.trim();
    final loc = AppLocalizations.of(context)!;

    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    if (_isEmail(input)) {
      try {
        await _auth.signInWithEmailAndPassword(
          email: input,
          password: password,
        );
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, '/dashboard');
      } on FirebaseAuthException catch (e) {
        _showSnackBar('${loc.loginError}: ${e.message}', isError: true);
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    } else if (_isPhone(input)) {
      try {
        await _auth.verifyPhoneNumber(
          phoneNumber: input.startsWith('+') ? input : '+57$input',
          verificationCompleted: (credential) async {
            await _auth.signInWithCredential(credential);
            if (!mounted) return;
            Navigator.pushReplacementNamed(context, '/dashboard');
          },
          verificationFailed: (e) {
            _showSnackBar('${loc.loginError}: ${e.message}', isError: true);
            if (mounted) setState(() => _isLoading = false);
          },
          codeSent: (id, _) {
            if (!mounted) return;
            Navigator.pushNamed(
              context,
              '/phoneVerification',
              arguments: {'verificationId': id, 'phoneNumber': input},
            );
            if (mounted) setState(() => _isLoading = false);
          },
          codeAutoRetrievalTimeout: (_) {
            if (mounted) setState(() => _isLoading = false);
          },
        );
      } catch (e) {
        _showSnackBar('${loc.unexpectedError}: $e', isError: true);
        if (mounted) setState(() => _isLoading = false);
      }
    } else {
      _showSnackBar(loc.invalidFormat, isError: true);
      setState(() => _isLoading = false);
    }
  }

  // ---------------------------------------------------------------------------
  // 4. Interfaz visual
  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final inputText = emailOrPhoneController.text.trim();
    final passwordText = passwordController.text.trim();

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.loginTitle),
        actions: [
          const LanguageSelector(),
          IconButton(
            icon: const Icon(Icons.brightness_6),
            tooltip: 'Cambiar tema',
            onPressed: () {
              Provider.of<LanguageProvider>(
                context,
                listen: false,
              ).toggleThemeMode();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),

              // Logo principal
              Center(
                child: Image.asset("assets/images/logo1.png", height: 100),
              ),

              const SizedBox(height: 24),

              // -----------------------------------------------------------------------
              // 4.1 Campo de correo o teléfono con validación e ícono ✅
              // -----------------------------------------------------------------------
              TextFormField(
                controller: emailOrPhoneController,
                decoration: InputDecoration(
                  labelText: loc.emailOrPhoneLabel,
                  prefixIcon: const Icon(Icons.person_outline),
                  suffixIcon:
                      _isEmail(inputText) || _isPhone(inputText)
                          ? const Icon(Icons.check_circle, color: Colors.green)
                          : null,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color:
                          (_isEmail(inputText) || _isPhone(inputText))
                              ? Colors.green
                              : Colors.grey,
                    ),
                  ),
                  border: const OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (_) => setState(() {}),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return loc.pleaseEnterEmailOrPhone;
                  }
                  if (!_isEmail(value.trim()) && !_isPhone(value.trim())) {
                    return loc.invalidFormat;
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // -----------------------------------------------------------------------
              // 4.2 Campo de contraseña con validación fuerte y visual
              // -----------------------------------------------------------------------
              TextFormField(
                controller: passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: loc.passwordLabelLogin,
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon:
                      _isValidPassword(passwordText)
                          ? const Icon(Icons.check_circle, color: Colors.green)
                          : IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed:
                                () => setState(
                                  () => _obscureText = !_obscureText,
                                ),
                          ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color:
                          _isValidPassword(passwordText)
                              ? Colors.green
                              : Colors.grey,
                    ),
                  ),
                  border: const OutlineInputBorder(),
                ),
                onChanged: (_) => setState(() {}),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (!_isEmail(inputText)) return null;
                  if (value == null || value.trim().isEmpty) {
                    return loc.pleaseEnterPassword;
                  }
                  if (!_isValidPassword(value.trim())) {
                    return 'Debe tener al menos 8 caracteres, mayúscula, minúscula, número y símbolo.';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // Botón de inicio de sesión
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                  ),
                  child:
                      _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                            loc.loginButton,
                            style: const TextStyle(fontSize: 18),
                          ),
                ),
              ),

              const SizedBox(height: 24),

              // Botones sociales desactivados
              OutlinedButton.icon(
                onPressed: null,
                icon: const Icon(Icons.g_mobiledata),
                label: Text('${loc.googleSignIn} (Coming soon)'),
              ),

              const SizedBox(height: 12),

              OutlinedButton.icon(
                onPressed: null,
                icon: const Icon(Icons.facebook),
                label: Text('${loc.facebookSignIn} (Coming soon)'),
              ),

              const SizedBox(height: 24),

              // Enlace a registro
              Center(
                child: TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/register'),
                  child: Text.rich(
                    TextSpan(
                      text: '${loc.noAccount} ',
                      children: [
                        TextSpan(
                          text: loc.registerHere,
                          style: const TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Texto legal
              Text(
                loc.termsAndPrivacy,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 11, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
