// -----------------------------------------------------------------------------
// 📄 Archivo: lib/providers/language_provider.dart
// 📝 Descripción: Proveedor para gestionar el idioma de la aplicación usando AppLocalizations.
// 📅 Última actualización: 06/05/2025 - 21:20 (Hora de Colombia)
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  Locale _locale = const Locale('es', ''); // Idioma predeterminado: español

  Locale get locale => _locale;

  void changeLanguage(String languageCode) {
    _locale = Locale(languageCode);
    notifyListeners();
  }
}
