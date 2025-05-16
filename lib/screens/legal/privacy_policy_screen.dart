// -----------------------------------------------------------------------------
// 📄 Archivo: privacy_policy_screen.dart
// 📍 Ubicación: lib/screens/legal/privacy_policy_screen.dart
// 📝 Descripción: Pantalla de política de privacidad con contenido legal realista
// 📅 Última actualización: 14/05/2025 - 15:02 (Hora de Colombia)
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final styleTitle = theme.textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.bold,
    );
    final styleBody = theme.textTheme.bodyMedium;

    return Scaffold(
      appBar: AppBar(title: const Text('Política de Privacidad')),
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

              Text('1. ¿Qué datos recopilamos?', style: styleTitle),
              const SizedBox(height: 8),
              Text(
                'Recopilamos datos que tú nos proporcionas directamente, como:\n- Nombre y apellidos\n- Correo electrónico\n- Idioma preferido\n- Progreso y estadísticas educativas\n- Datos de autenticación (Firebase)',
                style: styleBody,
              ),

              const SizedBox(height: 24),
              Text(
                '2. ¿Con qué propósito usamos tus datos?',
                style: styleTitle,
              ),
              const SizedBox(height: 8),
              Text(
                'Usamos tu información para:\n- Permitirte acceder a la plataforma\n- Adaptar la app a tu idioma\n- Mostrarte tu avance lector\n- Enviarte notificaciones importantes\n- Mejorar la experiencia del usuario',
                style: styleBody,
              ),

              const SizedBox(height: 24),
              Text('3. ¿Compartimos tu información?', style: styleTitle),
              const SizedBox(height: 8),
              Text(
                'No vendemos, alquilamos ni compartimos tu información con terceros sin tu consentimiento. '
                'Podemos compartir datos con servicios como Firebase o Google Analytics solo con fines técnicos.',
                style: styleBody,
              ),

              const SizedBox(height: 24),
              Text('4. Almacenamiento y seguridad', style: styleTitle),
              const SizedBox(height: 8),
              Text(
                'Tus datos están protegidos en servidores seguros provistos por Firebase. '
                'Aplicamos buenas prácticas de encriptación, autenticación y acceso restringido.',
                style: styleBody,
              ),

              const SizedBox(height: 24),
              Text('5. Derechos del usuario', style: styleTitle),
              const SizedBox(height: 8),
              Text(
                'Dependiendo de tu país, puedes:\n- Acceder a tus datos\n- Corregirlos o actualizarlos\n- Solicitar su eliminación\n- Retirar tu consentimiento\n\n'
                'Para ejercer estos derechos, contáctanos en: legal@lectorglobal.app',
                style: styleBody,
              ),

              const SizedBox(height: 24),
              Text('6. Política infantil', style: styleTitle),
              const SizedBox(height: 8),
              Text(
                'Lector Global puede ser usado por menores con autorización de padres o tutores. '
                'No recopilamos conscientemente datos de menores sin supervisión.',
                style: styleBody,
              ),

              const SizedBox(height: 24),
              Text('7. Cookies y tecnologías similares', style: styleTitle),
              const SizedBox(height: 8),
              Text(
                'Podemos usar cookies para mejorar la funcionalidad, guardar preferencias y analizar el uso. '
                'Puedes desactivarlas desde la configuración de tu navegador.',
                style: styleBody,
              ),

              const SizedBox(height: 24),
              Text('8. Cambios en esta política', style: styleTitle),
              const SizedBox(height: 8),
              Text(
                'Podemos modificar esta política en cualquier momento. Notificaremos dentro de la app en caso de cambios importantes.',
                style: styleBody,
              ),

              const SizedBox(height: 24),
              Text('9. Contacto', style: styleTitle),
              const SizedBox(height: 8),
              Text(
                'Si tienes preguntas sobre esta política, contáctanos:\n\n'
                '📧 legal@lectorglobal.app\n🌐 www.lectorglobal.app/privacidad',
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
