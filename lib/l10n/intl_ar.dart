// 📅 Última actualización: 04/05/2025 - (hora Colombia)
// Traducción al árabe para Lector Global

import '../l10n/app_localizations.dart';

class AppLocalizationsAr implements AppLocalizations {
  @override
  String get welcome => 'مرحبًا بكم في Lector Global';

  @override
  String get startButton => 'ابدأ';

  @override
  String get description => 'تبدأ الرحلة من صفحة واحدة';

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
