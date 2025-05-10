// -----------------------------------------------------------------------------
// 📄 Archivo: language_selector.dart (corregido completamente)
// 📅 Última corrección: 10/05/2025 - 01:38 (Hora de Colombia)
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart'; // ✅ Corrección de ruta de importación

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, _) {
        final Map<String, String> languageNames = {
          'es': 'Español',
          'en': 'English',
          'fr': 'Français',
          'it': 'Italiano',
          'pt': 'Português',
          'de': 'Deutsch',
          'ru': 'Русский',
          'ja': '日本語',
          'zh': '中文',
          'ar': 'العربية',
        };

        final String currentLang = languageProvider.locale.languageCode;

        return DropdownButton<String>(
          value: languageNames.containsKey(currentLang) ? currentLang : 'es',
          icon: const Icon(Icons.language, color: Colors.deepPurple),
          underline: Container(),
          onChanged: (String? newLanguageCode) {
            if (newLanguageCode != null) {
              languageProvider.changeLanguage(newLanguageCode);
            }
          },
          items:
              languageNames.entries.map((entry) {
                return DropdownMenuItem<String>(
                  value: entry.key,
                  child: Text(entry.value),
                );
              }).toList(),
        );
      },
    );
  }
}
