// -----------------------------------------------------------------------------
// 📄 Archivo: login_screen.dart
// 📍 Ubicación: lib/screens/auth/login_screen.dart
// 📝 Descripción: Pantalla de login con animaciones, validaciones personalizadas, modo oscuro y errores visuales
// 📅 Última actualización: 14/05/2025 - 13:45 (Hora de Colombia)
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
// 2. Widget principal con estado: LoginScreen
// -----------------------------------------------------------------------------
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// -----------------------------------------------------------------------------
// 3. Clase de estado para LoginScreen
// -----------------------------------------------------------------------------
class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  // 3.1 Controladores y variables
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailOrPhoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;
  bool _isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 3.2 Animaciones para logo y eslogan
  late AnimationController _logoController;
  late AnimationController _sloganController;

  // 3.3 Inicialización
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

  // 3.4 Liberación de recursos
  @override
  void dispose() {
    emailOrPhoneController.dispose();
    passwordController.dispose();
    _logoController.dispose();
    _sloganController.dispose();
    super.dispose();
  }

  // 3.5 Validaciones de entrada
  bool _isEmail(String input) =>
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(input);

  bool _isPhone(String input) => RegExp(r'^\+?[0-9]{7,15}$').hasMatch(input);

  bool _isValidPassword(String input) => RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$',
  ).hasMatch(input);

  // 3.6 Mensajes visuales tipo snackbar
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
  // 4. Lógica de autenticación
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
  // 5. Construcción visual de la interfaz
  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final inputText = emailOrPhoneController.text.trim();
    final passwordText = passwordController.text.trim();
    final isEmailLogin = _isEmail(inputText);

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

              // 5.1 Logo animado
              FadeTransition(
                opacity: _logoController,
                child: Center(
                  child: Image.asset("assets/images/logo1.png", height: 100),
                ),
              ),

              const SizedBox(height: 12),

              // 5.2 Eslogan animado
              FadeTransition(
                opacity: _sloganController,
                child: Text(
                  loc.loginSlogan,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: theme.textTheme.bodyMedium?.color,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // 5.3 Campo de correo o teléfono con mensaje de error personalizado
              TextFormField(
                controller: emailOrPhoneController,
                decoration: InputDecoration(
                  labelText: loc.emailOrPhoneLabel,
                  prefixIcon: const Icon(Icons.person_outline),
                  suffixIcon:
                      _isEmail(inputText) || _isPhone(inputText)
                          ? const Icon(Icons.check_circle, color: Colors.green)
                          : null,
                  errorStyle: const TextStyle(fontSize: 12),
                ),
                keyboardType: TextInputType.emailAddress,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (_) => setState(() {}),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '⚠️ ${loc.pleaseEnterEmailOrPhone}';
                  }
                  if (!_isEmail(value.trim()) && !_isPhone(value.trim())) {
                    return '⚠️ ${loc.invalidFormat}';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // 5.4 Campo de contraseña con mensaje de error personalizado
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
                  errorStyle: const TextStyle(fontSize: 12),
                ),
                onChanged: (_) => setState(() {}),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (!isEmailLogin) return null;
                  if (value == null || value.trim().isEmpty) {
                    return '⚠️ ${loc.pleaseEnterPassword}';
                  }
                  if (!_isValidPassword(value.trim())) {
                    return '⚠️ Debe tener al menos 8 caracteres, mayúscula, minúscula, número y símbolo.';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // 5.5 Botón de ingreso
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

              // 5.6 Botones autenticación externa (inactivos)
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

              // 5.7 Enlace de registro
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

              // 5.8 Términos y condiciones con estilo adaptado
              Text(
                loc.termsAndPrivacy,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  color: theme.textTheme.bodySmall?.color?.withAlpha(
                    (255 * 0.6).toInt(),
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
