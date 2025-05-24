// -----------------------------------------------------------------------------
// 📄 Archivo: terms_conditions_screen.dart
// 📍 Ubicación: lib/screens/legal/terms_conditions_screen.dart
// 📝 Descripción: Pantalla de términos y condiciones completa con scroll
// 📅 Última actualización: 14/05/2025 - 14:45 (Hora de Colombia)
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final styleTitle = theme.textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.bold,
    );
    final styleBody = theme.textTheme.bodyMedium;

    return Scaffold(
      appBar: AppBar(title: const Text('Términos y Condiciones')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Última actualización: 14 de mayo de 2025',
                style: styleBody,
              ),
              const SizedBox(height: 24),

              Text('1. Aceptación de los términos', style: styleTitle),
              const SizedBox(height: 8),
              Text(
                'Al crear una cuenta o usar Lector Global, aceptas estos Términos y Condiciones, nuestra Política de Privacidad y cualquier reglamento adicional que se publique dentro de la app. Estos términos se aplican a todos los usuarios, sin importar su país de residencia.',
                style: styleBody,
              ),

              const SizedBox(height: 24),
              Text(
                '2. Requisitos de edad y responsabilidad parental',
                style: styleTitle,
              ),
              const SizedBox(height: 8),
              Text(
                'Lector Global está disponible para personas de todas las edades. Si eres menor de edad según la legislación de tu país, necesitas el consentimiento de tus padres o tutores legales para utilizar la aplicación.',
                style: styleBody,
              ),

              const SizedBox(height: 24),
              Text('3. Licencia de uso', style: styleTitle),
              const SizedBox(height: 8),
              Text(
                'Se te concede una licencia limitada, no exclusiva, no transferible y revocable para usar Lector Global únicamente con fines personales, educativos y no comerciales.',
                style: styleBody,
              ),

              const SizedBox(height: 24),
              Text('4. Cuenta y seguridad', style: styleTitle),
              const SizedBox(height: 8),
              Text(
                'Eres responsable de mantener la confidencialidad de tu cuenta y contraseña. Te comprometes a proporcionar información precisa y actualizada.',
                style: styleBody,
              ),

              const SizedBox(height: 24),
              Text('5. Privacidad y protección de datos', style: styleTitle),
              const SizedBox(height: 8),
              Text(
                'Lector Global respeta tu privacidad y trata tus datos personales de acuerdo con el GDPR, CCPA, Ley 1581 de Colombia, LGPD de Brasil y demás normativas aplicables. '
                'Puedes solicitar la eliminación de tus datos escribiendo a: legal@lectorglobal.app',
                style: styleBody,
              ),

              const SizedBox(height: 24),
              Text('6. Contenido generado por IA', style: styleTitle),
              const SizedBox(height: 8),
              Text(
                'Algunos textos, preguntas o explicaciones son generados automáticamente mediante inteligencia artificial. Aunque se hace todo lo posible por ofrecer contenido preciso, '
                'Lector Global no garantiza que dicho contenido esté libre de errores.',
                style: styleBody,
              ),

              const SizedBox(height: 24),
              Text('7. Limitación de responsabilidad', style: styleTitle),
              const SizedBox(height: 8),
              Text(
                'La aplicación se ofrece "tal cual", sin garantías de funcionamiento ininterrumpido. Lector Global no será responsable de daños directos, indirectos o incidentales.',
                style: styleBody,
              ),

              const SizedBox(height: 24),
              Text('8. Modificaciones', style: styleTitle),
              const SizedBox(height: 8),
              Text(
                'Podemos actualizar estos Términos y Condiciones en cualquier momento. El uso continuado de la app después de dichos cambios implica tu aceptación.',
                style: styleBody,
              ),

              const SizedBox(height: 24),
              Text('9. Jurisdicción', style: styleTitle),
              const SizedBox(height: 8),
              Text(
                'Este acuerdo se rige por la legislación del país donde está registrado el titular de la app. También se respetarán los derechos del usuario según la ley local.',
                style: styleBody,
              ),

              const SizedBox(height: 24),
              Text('10. Contacto', style: styleTitle),
              const SizedBox(height: 8),
              Text(
                'Para dudas legales o solicitudes de privacidad, contáctanos:\nlegal@lectorglobal.app\nwww.lectorglobal.app/terminos',
                style: styleBody,
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
