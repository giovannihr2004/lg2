// 📅 Última actualización: 04/05/2025 - 12:01 (hora Colombia)
// Traducción al portugués para Lector Global

import '../l10n/app_localizations.dart';

class AppLocalizationsPt implements AppLocalizations {
  @override
  String get welcome => 'Bem-vindo ao Lector Global';

  @override
  String get startButton => 'Começar';

  @override
  String get description => 'A jornada começa com uma página';

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
