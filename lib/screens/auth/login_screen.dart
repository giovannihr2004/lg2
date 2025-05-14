// -----------------------------------------------------------------------------
// 📄 Archivo: login_screen.dart
// 📍 Ubicación: lib/screens/auth/login_screen.dart
// 📝 Descripción: Pantalla de login con validaciones, animaciones y enlace legal
// 📅 Última actualización: 14/05/2025 - 14:58 (Hora de Colombia)
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
// 1. Importaciones necesarias
// -----------------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../providers/language_provider.dart';
import '../../widgets/language_selector.dart';

// -----------------------------------------------------------------------------
// 2. Clase principal con estado
// -----------------------------------------------------------------------------
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// -----------------------------------------------------------------------------
// 3. Estado y lógica del login
// -----------------------------------------------------------------------------
class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailOrPhoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _obscureText = true;
  bool _isLoading = false;

  late AnimationController _logoController;
  late AnimationController _sloganController;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _sloganController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _logoController.forward().whenComplete(() => _sloganController.forward());
  }

  @override
  void dispose() {
    emailOrPhoneController.dispose();
    passwordController.dispose();
    _logoController.dispose();
    _sloganController.dispose();
    super.dispose();
  }

  bool _isEmail(String input) =>
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(input);

  bool _isPhone(String input) => RegExp(r'^\+?[0-9]{7,15}$').hasMatch(input);

  bool _isValidPassword(String input) => RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$',
  ).hasMatch(input);

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
  // 3.1 Lógica de inicio de sesión (correo o teléfono)
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
          verificationCompleted: (PhoneAuthCredential credential) async {
            await _auth.signInWithCredential(credential);
            if (!mounted) return;
            Navigator.pushReplacementNamed(context, '/dashboard');
          },
          verificationFailed: (FirebaseAuthException e) {
            _showSnackBar('${loc.loginError}: ${e.message}', isError: true);
            if (mounted) setState(() => _isLoading = false);
          },
          codeSent: (String verificationId, int? resendToken) {
            if (!mounted) return;
            Navigator.pushNamed(
              context,
              '/phoneVerification',
              arguments: {
                'verificationId': verificationId,
                'phoneNumber': input,
              },
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
  // 4. Construcción de la interfaz visual
  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final inputText = emailOrPhoneController.text.trim();
    final passwordText = passwordController.text.trim();
    final isEmailLogin = _isEmail(inputText);
    final theme = Theme.of(context);

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
            children: [
              const SizedBox(height: 40),

              // 4.1 Logo animado
              FadeTransition(
                opacity: _logoController,
                child: Center(
                  child: Image.asset("assets/images/logo1.png", height: 100),
                ),
              ),

              const SizedBox(height: 12),

              // 4.2 Eslogan animado
              FadeTransition(
                opacity: _sloganController,
                child: Text(
                  loc.loginSlogan,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: Colors.black87,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // 4.3 Campo de email o teléfono
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

              // 4.4 Campo de contraseña
              TextFormField(
                controller: passwordController,
                enabled: isEmailLogin,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: loc.passwordLabelLogin,
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon:
                      isEmailLogin && _isValidPassword(passwordText)
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
                          isEmailLogin && _isValidPassword(passwordText)
                              ? Colors.green
                              : Colors.grey,
                    ),
                  ),
                  border: const OutlineInputBorder(),
                ),
                onChanged: (_) => setState(() {}),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (!isEmailLogin) return null;
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

              // 4.5 Botón ingresar
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  child:
                      _isLoading
                          ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Colors.white,
                            ),
                          )
                          : Text(
                            loc.loginButton,
                            style: const TextStyle(fontSize: 18),
                          ),
                ),
              ),

              const SizedBox(height: 24),

              // 4.6 Botones externos (desactivados)
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

              // 4.7 Enlaces de navegación
              TextButton(
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

              const SizedBox(height: 8),

              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/terms'),
                child: Text(
                  loc.termsAndPrivacy,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    color: theme.textTheme.bodySmall?.color?.withAlpha(
                      204,
                    ), // 204 ≈ 80% opacidad
                    decoration: TextDecoration.underline,
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
