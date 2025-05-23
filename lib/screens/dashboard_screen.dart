// -----------------------------------------------------------------------------
// 📄 Archivo: dashboard_screen.dart
// 📍 Ubicación: lib/screens/dashboard_screen.dart
// 📝 Descripción: Pantalla principal con saludo personalizado, logout real y botones de navegación.
// ♿ Mejora: Accesibilidad implementada con Semantics
// 📅 Última actualización: 22/05/2025 - 21:55 (Hora de Colombia)
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
// 1. Importaciones necesarias
// -----------------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Traducciones

// -----------------------------------------------------------------------------
// 2. Declaración del widget sin estado
// -----------------------------------------------------------------------------
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  // ---------------------------------------------------------------------------
  // 3. Construcción visual con Semantics
  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // 3.1 Obtener usuario actual de Firebase Auth
    final user = FirebaseAuth.instance.currentUser;

    // 3.2 Extraer displayName o email como nombre visible
    final String userName =
        user?.displayName?.trim().isNotEmpty == true
            ? user!.displayName!
            : (user?.email?.split('@').first ?? 'Usuario');

    // 3.3 Acceso a localizaciones
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
              // -----------------------------------------------------------------
              // 4.1 Saludo personalizado con Semantics
              // -----------------------------------------------------------------
              Semantics(
                label: 'Bienvenida. ${localizations.welcome}, $userName',
                child: Text(
                  '${localizations.welcome}, $userName',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 16),

              // -----------------------------------------------------------------
              // 4.2 Mensaje motivacional accesible
              // -----------------------------------------------------------------
              Semantics(
                label: localizations.startYourReadingJourney,
                child: Text(
                  localizations.startYourReadingJourney,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 40),

              // -----------------------------------------------------------------
              // 4.3 Botón "Lecciones" con Semantics
              // -----------------------------------------------------------------
              Semantics(
                label: 'Abrir sección de lecciones',
                button: true,
                child: ElevatedButton.icon(
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
              ),

              const SizedBox(height: 20),
              // -----------------------------------------------------------------
              // 4.4 Botón "Mi progreso" con Semantics
              // -----------------------------------------------------------------
              Semantics(
                label: 'Ver mi progreso',
                button: true,
                child: ElevatedButton.icon(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
