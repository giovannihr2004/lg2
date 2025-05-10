// -----------------------------------------------------------------------------
// 📄 Archivo: login_screen.dart
// 📝 Descripción: Pantalla de login inteligente (correo o teléfono) con localizaciones, validaciones avanzadas, control de memoria y feedback profesional.
// 📅 Última actualización: 06/05/2025 - 18:10 (hora Colombia GMT-5)
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../widgets/language_selector.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailOrPhoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;
  bool _isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    emailOrPhoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool _isEmail(String input) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(input);
  }

  bool _isPhone(String input) {
    return RegExp(r'^\+?[0-9]{7,15}$').hasMatch(input);
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

  Future<void> _login() async {
    final input = emailOrPhoneController.text.trim();
    final password = passwordController.text.trim();
    final loc = AppLocalizations.of(context)!;

    if (input.isEmpty) {
      _showSnackBar(loc.pleaseEnterEmailOrPhone, isError: true);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    if (_isEmail(input)) {
      if (password.isEmpty) {
        _showSnackBar(loc.pleaseEnterPassword, isError: true);
        setState(() {
          _isLoading = false;
        });
        return;
      }

      try {
        await _auth.signInWithEmailAndPassword(email: input, password: password);
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, '/dashboard');
      } on FirebaseAuthException catch (e) {
        _showSnackBar('${loc.loginError}: ${e.message}', isError: true);
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
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
            if (mounted) {
              setState(() {
                _isLoading = false;
              });
            }
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
            if (mounted) {
              setState(() {
                _isLoading = false;
              });
            }
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            if (mounted) {
              setState(() {
                _isLoading = false;
              });
            }
          },
        );
      } catch (e) {
        _showSnackBar('${loc.unexpectedError}: $e', isError: true);
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    } else {
      _showSnackBar(loc.invalidFormat, isError: true);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.loginTitle),
        actions: const [LanguageSelector()],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: screenHeight * 0.05),

              Center(
                child: Image.asset("assets/images/logo1.png", height: 100),
              ),

              const SizedBox(height: 16),

              Center(
                child: Text(
                  loc.loginSubtitle,
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ),

              const SizedBox(height: 32),

              TextFormField(
                controller: emailOrPhoneController,
                decoration: InputDecoration(
                  labelText: loc.emailOrPhoneLabel,
                  prefixIcon: const Icon(Icons.person_outline),
                  border: const OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: loc.passwordLabelLogin,
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  border: const OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          loc.loginButton,
                          style: const TextStyle(fontSize: 18),
                        ),
                ),
              ),

              const SizedBox(height: 24),

              OutlinedButton.icon(
                onPressed: null, // Desactivado temporalmente
                icon: const Icon(Icons.g_mobiledata),
                label: Text('${loc.googleSignIn} (Coming soon)'),
              ),

              const SizedBox(height: 12),

              OutlinedButton.icon(
                onPressed: null, // Desactivado temporalmente
                icon: const Icon(Icons.facebook),
                label: Text('${loc.facebookSignIn} (Coming soon)'),
              ),

              const SizedBox(height: 24),

              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
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
