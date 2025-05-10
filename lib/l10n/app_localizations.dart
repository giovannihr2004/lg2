// -----------------------------------------------------------------------------
// 📄 Archivo: lib/l10n/app_localizations.dart
// 📝 Descripción: Clase base abstracta para las traducciones de Lector Global.
// 📅 Última actualización: 06/05/2025 - 19:55 (hora Colombia)
// -----------------------------------------------------------------------------

abstract class AppLocalizations {
  String get welcome;
  String get startButton;
  String get description;

  String translate(String key) {
    switch (key) {
      case 'welcome':
        return welcome;
      case 'start_button':
        return startButton;
      case 'description':
        return description;
      default:
        return '';
    }
  }
}
