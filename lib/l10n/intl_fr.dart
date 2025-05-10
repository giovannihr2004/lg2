// 📅 Última actualización: 04/05/2025 - 11:53 (hora Colombia)
// Traducción al francés para Lector Global

import '../l10n/app_localizations.dart';

class AppLocalizationsFr implements AppLocalizations {
  @override
  String get welcome => 'Bienvenue sur Lector Global';

  @override
  String get startButton => 'Commencer';

  @override
  String get description => 'Le voyage commence par une page';

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
