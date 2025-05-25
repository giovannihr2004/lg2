// -----------------------------------------------------------------------------
// 📄 Archivo: session_wrapper_screen.dart
// 📍 Ubicación: lib/screens/session/session_wrapper_screen.dart
// 📝 Descripción: Verifica si hay sesión activa en SecureStorage y redirige automáticamente
// 📅 Última actualización: 24/05/2025 - 13:15 (Hora de Colombia)
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/secure_storage_service.dart';
import '../dashboard_screen.dart';
import '../language_selector_screen.dart';

class SessionWrapperScreen extends StatefulWidget {
  const SessionWrapperScreen({super.key});

  @override
  State<SessionWrapperScreen> createState() => _SessionWrapperScreenState();
}

class _SessionWrapperScreenState extends State<SessionWrapperScreen> {
  final SecureStorageService _secureStorage = SecureStorageService();
  bool _checkingSession = true;
  Widget? _nextScreen;

  @override
  void initState() {
    super.initState();
    _detectarSesion();
  }

  Future<void> _detectarSesion() async {
    try {
      final uid = await _secureStorage.read('uid');
      final user = FirebaseAuth.instance.currentUser;

      if (uid != null && user != null && user.emailVerified) {
        _nextScreen = const DashboardScreen();
      } else {
        _nextScreen = const LanguageSelectorScreen();
      }
    } catch (_) {
      _nextScreen = const LanguageSelectorScreen();
    }

    if (mounted) {
      setState(() {
        _checkingSession = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_checkingSession) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return _nextScreen!;
  }
}
