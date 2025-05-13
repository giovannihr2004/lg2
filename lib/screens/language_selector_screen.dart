// -----------------------------------------------------------------------------
// 📄 Archivo: language_selector_screen.dart
// 📍 Ubicación: lib/screens/language_selector_screen.dart
// 📝 Descripción: Pantalla inicial para seleccionar el idioma con navegación ligera y efectiva.
// 📅 Última actualización: 13/05/2025 - 18:38 (Hora de Colombia)
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lector_global/providers/language_provider.dart';
import 'splash/splash_wrapper_screen.dart'; // Pantalla de transición hacia el logo

class LanguageSelectorScreen extends StatelessWidget {
  const LanguageSelectorScreen({super.key});

  static final Map<String, String> languageNames = {
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

  void _onLanguageSelected(BuildContext context, String langCode) {
    context.read<LanguageProvider>().changeLanguage(langCode);

    // ✅ Navega sin forzar eliminación de rutas, permitiendo reconstrucción natural
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const SplashWrapperScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.language, size: 64, color: Colors.deepPurple),
              const SizedBox(height: 16),
              const Text(
                'Selecciona tu idioma',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: languageNames.entries.map((entry) {
                  return ElevatedButton(
                    onPressed: () => _onLanguageSelected(context, entry.key),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      entry.value,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 40),
              const Text(
                'Tu idioma determinará la experiencia completa en la app.',
                style: TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
