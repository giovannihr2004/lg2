import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:lector_global/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('🧪 Verifica que la app carga y muestra el título', (
    tester,
  ) async {
    app.main(); // Lanza la app completa
    await tester.pumpAndSettle(const Duration(seconds: 5)); // espera inicial

    // Intenta encontrar texto Lector Global
    final title = find.text('Lector Global');
    expect(title, findsWidgets);
  });
}
