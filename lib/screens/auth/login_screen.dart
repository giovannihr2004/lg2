// -----------------------------------------------------------------------------
// 📄 Archivo: login_screen.dart
// 📍 Ubicación: lib/screens/auth/login_screen.dart
// 📝 Descripción: Pantalla de login con validaciones, animaciones y enlaces legales
// 🤩 Mejora: Integración con almacenamiento seguro para guardar correo tras login
// 📅 Última actualización: 23/05/2025 - 17:50 (Hora de Colombia)
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
// INICIO PARTE 1 - Importaciones necesarias
// -----------------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../providers/language_provider.dart';
import '../../widgets/language_selector.dart';
import '../../services/google_sign_in_service.dart';
import '../../services/secure_storage_service.dart'; // ✅ Nueva importación
import 'register_screen.dart';

// -----------------------------------------------------------------------------
// FIN PARTE 1
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// INICIO PARTE 2 - Declaración de widget con estado y controladores
// -----------------------------------------------------------------------------
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

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
  final SecureStorageService _secureStorage =
      SecureStorageService(); // ✅ Nueva instancia

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

  // -----------------------------------------------------------------------------
  // FIN PARTE 2
  // -----------------------------------------------------------------------------
  // -----------------------------------------------------------------------------
  // INICIO PARTE 3 - Validaciones y función de snackbar
  // -----------------------------------------------------------------------------
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

  // -----------------------------------------------------------------------------
  // FIN PARTE 3
  // -----------------------------------------------------------------------------
  // -----------------------------------------------------------------------------
  // INICIO PARTE 4 - Función principal de login con almacenamiento seguro
  // -----------------------------------------------------------------------------
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

        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await user.reload();
          if (!user.emailVerified) {
            _showSnackBar(
              "Por favor, verifica tu correo antes de iniciar sesión.",
            );
            return;
          }

          // ✅ Guardar el correo en almacenamiento seguro
          await _secureStorage.save('email', input);
        }

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

  // -----------------------------------------------------------------------------
  // FIN PARTE 4
  // -----------------------------------------------------------------------------
  // -----------------------------------------------------------------------------
  // INICIO PARTE 5 - Login con Google y método build inicial
  // -----------------------------------------------------------------------------
  Future<void> _signInWithGoogle() async {
    await GoogleSignInService.signInWithGoogleAndNavigate(context);
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final inputText = emailOrPhoneController.text.trim();
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
              // -----------------------------------------------------------------------------
              // FIN PARTE 5
              // -----------------------------------------------------------------------------
              // -----------------------------------------------------------------------------
              // INICIO PARTE 6 - Logo, eslogan, campo de email/teléfono
              // -----------------------------------------------------------------------------
              const SizedBox(height: 40),
              FadeTransition(
                opacity: _logoController,
                child: Semantics(
                  label: 'Logo de Lector Global',
                  image: true,
                  child: Center(
                    child: Image.asset(
                      "assets/images/logo_login.webp",
                      height: 220,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              FadeTransition(
                opacity: _sloganController,
                child: Semantics(
                  label: loc.loginSlogan,
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
              ),
              const SizedBox(height: 24),
              Semantics(
                label: 'Correo electrónico o número de teléfono',
                textField: true,
                child: TextFormField(
                  controller: emailOrPhoneController,
                  decoration: InputDecoration(
                    labelText: loc.emailOrPhoneLabel,
                    prefixIcon: const Icon(Icons.person_outline),
                    suffixIcon:
                        _isEmail(inputText) || _isPhone(inputText)
                            ? const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            )
                            : null,
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
              ),
              const SizedBox(height: 16),
              // -----------------------------------------------------------------------------
              // FIN PARTE 6
              // -----------------------------------------------------------------------------
              // -----------------------------------------------------------------------------
              // INICIO PARTE 7 - Campo de contraseña y enlace de recuperación
              // -----------------------------------------------------------------------------
              Semantics(
                label:
                    'Contraseña. Debe tener mínimo 8 caracteres, mayúscula, minúscula, número y símbolo',
                textField: true,
                child: TextFormField(
                  controller: passwordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    labelText: loc.passwordLabelLogin,
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed:
                          () => setState(() => _obscureText = !_obscureText),
                    ),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (_) => setState(() {}),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return loc.pleaseEnterPassword;
                    }
                    if (!_isValidPassword(value.trim())) {
                      return 'Debe tener al menos 8 caracteres, mayúscula, minúscula, número y símbolo.';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 8),
              Semantics(
                label: '¿Olvidaste tu contraseña?',
                button: true,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed:
                        () => Navigator.pushNamed(context, '/resetPassword'),
                    child: Text(
                      loc.forgotPassword,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // -----------------------------------------------------------------------------
              // FIN PARTE 7
              // -----------------------------------------------------------------------------
              // -----------------------------------------------------------------------------
              // INICIO PARTE 8 - Botón de login y login con Google
              // -----------------------------------------------------------------------------
              Semantics(
                label: 'Botón para iniciar sesión',
                button: true,
                child: SizedBox(
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
              ),
              const SizedBox(height: 24),
              Semantics(
                label: 'Iniciar sesión con cuenta de Google',
                button: true,
                child: OutlinedButton.icon(
                  onPressed: _signInWithGoogle,
                  icon: Image.asset("assets/images/google.webp", height: 20),
                  label: Text(loc.googleSignIn),
                ),
              ),
              const SizedBox(height: 24),
              // -----------------------------------------------------------------------------
              // FIN PARTE 8
              // -----------------------------------------------------------------------------
              // -----------------------------------------------------------------------------
              // INICIO PARTE 9 - Botón de registro y enlaces legales
              // -----------------------------------------------------------------------------
              Semantics(
                label: '¿No tienes cuenta? Regístrate aquí',
                button: true,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
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
              Semantics(
                label: 'Lee nuestros términos y condiciones aquí',
                link: true,
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/terms'),
                  child: Text(
                    'Lee nuestros términos y condiciones aquí.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11,
                      color: theme.textTheme.bodySmall?.color?.withAlpha(204),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Semantics(
                label: 'Lee nuestra política de privacidad aquí',
                link: true,
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/privacy'),
                  child: Text(
                    'Lee nuestra política de privacidad aquí.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11,
                      color: theme.textTheme.bodySmall?.color?.withAlpha(204),
                      decoration: TextDecoration.underline,
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

// -----------------------------------------------------------------------------
// FIN PARTE 9 - Fin del archivo completo
// -----------------------------------------------------------------------------
