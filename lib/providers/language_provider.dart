// -----------------------------------------------------------------------------
// 📄 Archivo: lib/providers/language_provider.dart
// 📝 Descripción: Proveedor para gestionar el idioma de la aplicación usando AppLocalizations.
// 📅 Última actualización: 13/05/2025 - 17:25 (Hora de Colombia)
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  Locale _locale = const Locale('es', ''); // Idioma predeterminado: español

  Locale get locale => _locale;

  // Getter adicional para comparar en lógica de navegación
  String get currentLanguage => _locale.languageCode;

  void changeLanguage(String languageCode) {
    _locale = Locale(languageCode);
    notifyListeners();
  }
}
