// -----------------------------------------------------------------------------
// 📄 Archivo: language_selector_screen.dart
// 📍 Ubicación: lib/screens/language_selector_screen.dart
// 📝 Descripción: Pantalla inicial para seleccionar el idioma con navegación directa.
// 📅 Última actualización: 20/05/2025 - 23:35 (Hora de Colombia)
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lector_global/providers/language_provider.dart';
import 'splash/splash_logo_screen.dart'; // ✅ Navegación directa al logo

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
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const SplashLogoScreen()));
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
              // 🟣 Nuevo ícono con logo
              Image.asset(
                'assets/images/logo_titulo.webp',
                height: 80,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 12),
              const Text(
                'Lector Global',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                  color: Colors.deepPurple,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              const Text(
                'Selecciona tu idioma',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children:
                    languageNames.entries.map((entry) {
                      return Focus(
                        child: Builder(
                          builder: (context) {
                            final isFocused = Focus.of(context).hasFocus;
                            return InkWell(
                              onTap:
                                  () => _onLanguageSelected(context, entry.key),
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.circular(12),
                                  border:
                                      isFocused
                                          ? Border.all(
                                            color: Colors.amberAccent,
                                            width: 2,
                                          )
                                          : null,
                                  boxShadow:
                                      isFocused
                                          ? [
                                            BoxShadow(
                                              color: Colors.amberAccent
                                                  .withOpacity(0.6),
                                              blurRadius: 8,
                                              spreadRadius: 1,
                                            ),
                                          ]
                                          : [],
                                ),
                                child: Text(
                                  entry.value,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            );
                          },
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
