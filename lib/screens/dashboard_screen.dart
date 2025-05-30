// -----------------------------------------------------------------------------
// 📄 Archivo: dashboard_screen.dart
// 📍 Ubicación: lib/screens/dashboard_screen.dart
// 📝 Descripción: Pantalla principal con saludo real usando displayName de Firebase.
// 🤩 Mejora radical: Usa displayName de Firebase para el saludo.
// 📅 Última actualización: 24/05/2025 - 19:40 (Hora de Colombia)
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
// INICIO PARTE 1 - Importaciones necesarias
// -----------------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../services/secure_storage_service.dart';
// -----------------------------------------------------------------------------
// FIN PARTE 1
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
// INICIO PARTE 2 - StatefulWidget y carga del displayName real
// -----------------------------------------------------------------------------
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String userName = 'Usuario';
  final SecureStorageService _storage = SecureStorageService();

  @override
  void initState() {
    super.initState();
    _loadDisplayName();
  }

  Future<void> _loadDisplayName() async {
    final user = FirebaseAuth.instance.currentUser;
    final nameFromFirebase = user?.displayName;
    final email = await _storage.read('email');

    if (mounted) {
      setState(() {
        if (nameFromFirebase != null && nameFromFirebase.trim().isNotEmpty) {
          userName = nameFromFirebase;
        } else if (email != null && email.trim().isNotEmpty) {
          userName = email.split('@').first;
        } else {
          userName = 'Usuario';
        }
      });
    }
  }
  // ---------------------------------------------------------------------------
  // FIN PARTE 2
  // ---------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
  // INICIO PARTE 3 - AppBar y estructura general del Scaffold
  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.dashboardTitle),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: localizations.logout,
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final navigator = Navigator.of(context);
              await FirebaseAuth.instance.signOut();
              await _storage.deleteAll();
              Future.delayed(Duration.zero, () {
                navigator.pushReplacementNamed('/login');
              });
            },
          ),
        ],
      ),
      // -----------------------------------------------------------------------
      // FIN PARTE 3
      // -----------------------------------------------------------------------

      // -----------------------------------------------------------------------
      // INICIO PARTE 4 - Saludo personalizado, mensaje motivacional y botones
      // -----------------------------------------------------------------------
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Semantics(
                label: '${AppLocalizations.of(context)!.welcome}, $userName',
                child: Text(
                  '${AppLocalizations.of(context)!.welcome}, $userName',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
              Semantics(
                label: AppLocalizations.of(context)!.startYourReadingJourney,
                child: Text(
                  AppLocalizations.of(context)!.startYourReadingJourney,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40),
              Semantics(
                label: 'Abrir sección de lecciones',
                button: true,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          AppLocalizations.of(context)!.lessonsComingSoon,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.menu_book),
                  label: Text(AppLocalizations.of(context)!.lessons),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 24,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Semantics(
                label: 'Ver mi progreso',
                button: true,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          AppLocalizations.of(context)!.progressComingSoon,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.show_chart),
                  label: Text(AppLocalizations.of(context)!.myProgress),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 24,
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
// FIN PARTE 4 - Fin del archivo completo
// -----------------------------------------------------------------------------
