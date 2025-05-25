import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:lector_global/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('🧪 Verifica que la app carga y muestra contenido inicial', (
    tester,
  ) async {
    app.main(); // Lanza la app completa
    await tester.pumpAndSettle(
      const Duration(seconds: 5),
    ); // espera animaciones

    // Busca algo que aparece en LanguageSelectorScreen
    expect(find.text('Selecciona tu idioma'), findsOneWidget);
  });
}
