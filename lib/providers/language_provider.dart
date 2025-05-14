// -----------------------------------------------------------------------------
// 📄 Archivo: language_provider.dart
// 📍 Ubicación: lib/providers/language_provider.dart
// 📝 Descripción: Proveedor para gestionar el idioma y el modo de tema (claro, oscuro, automático)
// 📅 Última actualización: 13/05/2025 - 21:17 (Hora de Colombia)
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  // ---------------------------------------------------------------------------
  // 🔤 Idioma predeterminado: español
  // ---------------------------------------------------------------------------
  Locale _locale = const Locale('es', '');
  Locale get locale => _locale;
  String get currentLanguage => _locale.languageCode;

  void changeLanguage(String languageCode) {
    _locale = Locale(languageCode);
    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  // 🌓 Modo de tema: claro, oscuro o sistema
  // ---------------------------------------------------------------------------
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  void toggleThemeMode() {
    // Rota entre system → light → dark → system
    switch (_themeMode) {
      case ThemeMode.system:
        _themeMode = ThemeMode.light;
        break;
      case ThemeMode.light:
        _themeMode = ThemeMode.dark;
        break;
      case ThemeMode.dark:
        _themeMode = ThemeMode.system;
        break;
    }
    notifyListeners();
  }
}
