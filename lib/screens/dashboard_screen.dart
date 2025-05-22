// -----------------------------------------------------------------------------
// 📄 Archivo: dashboard_screen.dart
// 📍 Ubicación: lib/screens/dashboard_screen.dart
// 📝 Descripción: Pantalla principal con saludo personalizado, logout real y botones de navegación.
// 📅 Última actualización: 20/05/2025 - 23:40 (Hora de Colombia)
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Traducciones

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtener el usuario actual
    final user = FirebaseAuth.instance.currentUser;

    // Mostrar displayName si está disponible, si no, tomar el nombre de la dirección de correo
    final String userName =
        user?.displayName?.trim().isNotEmpty == true
            ? user!.displayName!
            : (user?.email?.split('@').first ?? 'Usuario');

    // Acceso a las traducciones
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
              Future.delayed(Duration.zero, () {
                navigator.pushReplacementNamed('/login');
              });
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${localizations.welcome}, $userName',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                localizations.startYourReadingJourney,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(localizations.lessonsComingSoon)),
                  );
                },
                icon: const Icon(Icons.menu_book),
                label: Text(localizations.lessons),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 24,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(localizations.progressComingSoon)),
                  );
                },
                icon: const Icon(Icons.show_chart),
                label: Text(localizations.myProgress),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 24,
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
