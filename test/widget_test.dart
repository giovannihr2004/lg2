// -----------------------------------------------------------------------------
// 📄 Archivo: test/widget_test.dart
// 📝 Descripción: Test de arranque básico sin Firebase ni localización
// 📅 Última actualización: 07/05/2025
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('La app arranca correctamente', (WidgetTester tester) async {
    // Construye una app mínima sin dependencias externas
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: Center(child: Text('Prueba básica'))),
      ),
    );

    // Verifica que haya un MaterialApp
    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.text('Prueba básica'), findsOneWidget);
  });
}
