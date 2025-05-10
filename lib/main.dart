// -----------------------------------------------------------------------------
// 📄 Archivo: main.dart (estructura final con LanguageProvider y Selector)
// 📅 Última actualización: 10/05/2025 - 01:30 (Hora de Colombia)
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'providers/language_provider.dart';
import 'widgets/language_selector.dart';

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
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, _) {
        return MaterialApp(
          key: ValueKey(languageProvider.locale.languageCode),
          debugShowCheckedModeBanner: false,
          locale: languageProvider.locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: const LanguageTestScreen(),
        );
      },
    );
  }
}

class LanguageTestScreen extends StatelessWidget {
  const LanguageTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final langCode = context.watch<LanguageProvider>().locale.languageCode;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LanguageSelector(),
            const SizedBox(height: 20),
            Text(
              loc?.welcome_title ?? 'Texto sin traducción',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 10),
            Text(
              'Idioma actual: $langCode',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
