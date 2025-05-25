// -----------------------------------------------------------------------------
// 📄 Archivo: main_test.dart
// 📍 Ubicación: integration_test/main_test.dart
// 🧪 Descripción: Prueba mínima funcional de entorno en Web (sin Firebase, sin sesión)
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('🧪 Prueba mínima funcional en web', (tester) async {
    // Lanza una app muy simple
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: Center(child: Text('Prueba funcionando'))),
      ),
    );

    // Espera a que se renderice
    await tester.pumpAndSettle();

    // Verifica que el texto aparece
    expect(find.text('Prueba funcionando'), findsOneWidget);
  });
}
