// 📅 Última actualización: 04/05/2025 - 11:56 (hora Colombia)
// Traducción al italiano para Lector Global

import '../l10n/app_localizations.dart';

class AppLocalizationsIt implements AppLocalizations {
  @override
  String get welcome => 'Benvenuto su Lector Global';

  @override
  String get startButton => 'Iniziare';

  @override
  String get description => 'Il viaggio inizia con una pagina';

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
