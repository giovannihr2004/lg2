// -----------------------------------------------------------------------------
// 📄 Archivo: main.dart
// 📝 Descripción: Configura el idioma dinámicamente desde el provider
// 📅 Última actualización: 13/05/2025 - 18:30 (Hora de Colombia)
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:lector_global/providers/language_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'screens/language_selector_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => LanguageProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lector Global',
      locale: languageProvider.locale, // ✅ Aplica el idioma directamente
      supportedLocales: const [
        Locale('es'), // Español
        Locale('en'), // Inglés
        Locale('fr'), // Francés
        Locale('it'), // Italiano
        Locale('pt'), // Portugués
        Locale('de'), // Alemán
        Locale('ru'), // Ruso
        Locale('ja'), // Japonés
        Locale('zh'), // Chino
        Locale('ar'), // Árabe
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const LanguageSelectorScreen(),
    );
  }
}
