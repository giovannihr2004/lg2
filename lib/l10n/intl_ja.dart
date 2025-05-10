// 📅 Última actualización: 04/05/2025 - 11:59 (hora Colombia)
// Traducción al japonés para Lector Global

import '../l10n/app_localizations.dart';

class AppLocalizationsJa implements AppLocalizations {
  @override
  String get welcome => 'Lector Globalへようこそ';

  @override
  String get startButton => '開始';

  @override
  String get description => '旅は一つのページから始まります';

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
