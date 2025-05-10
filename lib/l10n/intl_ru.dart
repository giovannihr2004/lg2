// 📅 Última actualización: 04/05/2025 - 12:03 (hora Colombia)
// Traducción al ruso para Lector Global

import '../l10n/app_localizations.dart';

class AppLocalizationsRu implements AppLocalizations {
  @override
  String get welcome => 'Добро пожаловать в Lector Global';

  @override
  String get startButton => 'Начать';

  @override
  String get description => 'Путешествие начинается с одной страницы';

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
