// -----------------------------------------------------------------------------
// 📄 Archivo: language_selector_test.dart
// 📍 Ubicación: integration_test/language_selector_test.dart
// 🧪 Descripción: Prueba de integración completa de LanguageSelectorScreen con navegación
// 📅 Última actualización: 24/05/2025 - 15:20 (Hora de Colombia)
// -----------------------------------------------------------------------------

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:integration_test/integration_test.dart';
import 'package:lector_global/screens/language_selector_screen.dart';
import 'package:lector_global/screens/splash/splash_logo_screen.dart';
import 'package:lector_global/providers/language_provider.dart';
import 'package:provider/provider.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('🧪 Selección de idioma y navegación a SplashLogoScreen', (
    tester,
  ) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => LanguageProvider(),
        child: MaterialApp(
          home: const LanguageSelectorScreen(),
          routes: {'/splashLogo': (_) => const SplashLogoScreen()},
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verifica que aparece el texto clave
    expect(find.text('Selecciona tu idioma'), findsOneWidget);

    // Toca el botón de idioma "Español"
    final spanishButton = find.text('Español');
    expect(spanishButton, findsOneWidget);
    await tester.tap(spanishButton);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Verifica que navega correctamente a SplashLogoScreen (por su widget específico)
    expect(find.byType(SplashLogoScreen), findsOneWidget);
  });
}
