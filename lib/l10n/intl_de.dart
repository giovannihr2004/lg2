// 📅 Última actualización: 04/05/2025 - 11:48 (hora Colombia)
// Traducción al alemán para Lector Global

import '../l10n/app_localizations.dart';

class AppLocalizationsDe implements AppLocalizations {
  @override
  String get welcome => 'Willkommen bei Lector Global';

  @override
  String get startButton => 'Starten';

  @override
  String get description => 'Die Reise beginnt mit einer Seite';

  @override
  String translate(String key) {
    switch (key) {
      case 'welcome':
        return welcome;
      case 'startButton':
        return startButton;
      case 'description':
        return description;
      default:
        return '';
    }
  }
}
