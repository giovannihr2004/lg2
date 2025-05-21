# 📚 Lector Global

**Lector Global** es una aplicación educativa multiplataforma (Android, Web y Windows) desarrollada en Flutter. Está diseñada para fortalecer la comprensión lectora en todos los idiomas y niveles, con una interfaz accesible, validación por correo electrónico y flujos profesionales de usuario. Inspirada en los principios del Marco Común Europeo de Referencia para las Lenguas, esta app es ideal para usuarios, escuelas, y proyectos de aprendizaje autónomo.

---

## 🧭 Filosofía del proyecto

- 📖 **Lectura para transformar**: la comprensión lectora es la puerta de entrada al pensamiento crítico y a la transformación social.
- 🌎 **Global desde el inicio**: desde la primera pantalla, Lector Global es multilingüe, accesible e inclusivo.
- 🛡️ **Seguridad real**: autenticación sólida, validación de correo y protección contra cuentas falsas.
- 🧱 **Arquitectura profesional**: modular, escalable y mantenible por cualquier equipo de desarrollo.
- 🧩 **Interoperabilidad**: compatible con Android, Web y Windows desde una misma base de código.

---

## 🚀 Instrucciones de instalación

Clona el repositorio y ejecuta el proyecto en tu plataforma preferida:

```bash
git clone https://github.com/giovannihr2004/lg2.git
cd lg2
flutter pub get
flutter run -d chrome     # Para Web
flutter run -d windows    # Para Windows
flutter run -d <device_id>  # Para Android físico o emulador
## 🧱 Estructura del proyecto

El proyecto está organizado con una arquitectura limpia, escalable y mantenible, lo cual permite una colaboración efectiva y facilita la evolución del sistema a futuro.

```text
lib/
├── main.dart                         # Punto de entrada principal de la app
│
├── screens/                          # Pantallas agrupadas por flujo lógico
│   ├── auth/                         # Registro, login, recuperación, verificación
│   ├── splash/                       # Pantallas de presentación y transiciones
│   ├── intro/                        # Selector de idioma y bienvenida
│   └── dashboard/                    # Pantalla principal tras inicio de sesión
│
├── services/                         # Lógica desacoplada de autenticación y APIs
│   ├── firebase_auth_service.dart    # Autenticación por correo y recuperación
│   └── google_sign_in_service.dart   # Login con Google para web y Android
│
├── providers/                        # Control de estado global (Provider)
│   ├── language_provider.dart        # Cambios dinámicos de idioma
│   └── auth_provider.dart            # Manejo de sesión de usuario
│
├── widgets/                          # Componentes visuales reutilizables
│   ├── language_selector.dart
│   └── custom_button.dart
│
├── l10n/                             # Archivos `.arb` para internacionalización
│   ├── app_en.arb
│   ├── app_es.arb
│   └── (otros idiomas)
│
├── assets/                           # Recursos estáticos
│   ├── images/                       # Íconos, ilustraciones y logotipo
│   │   └── logo2.png                 # Ícono de aplicación personalizado
│   └── lang/                         # Recursos adicionales multilingües
│
└── generated/                        # Archivos generados automáticamente
## 🔐 Autenticación y seguridad

Lector Global implementa un sistema de autenticación robusto y seguro basado en Firebase Authentication, con soporte completo para correo electrónico, contraseñas seguras y login con Google.

### ✉️ Registro con verificación de correo

- El usuario debe ingresar un correo válido y una contraseña que cumpla con los requisitos mínimos (8 caracteres, mayúscula, minúscula, número y símbolo).
- Una vez registrado, se envía automáticamente un **correo de verificación**.
- El acceso a la aplicación queda bloqueado hasta que el correo sea confirmado.
- Este flujo garantiza que no existan cuentas falsas ni inactivas.

### 🔑 Inicio de sesión

- Se permite login mediante:
  - Correo y contraseña
  - Cuenta de Google (Web y Android)
- El sistema valida si el correo fue verificado antes de permitir el acceso al dashboard.

### 🔄 Recuperación de contraseña

- El formulario de inicio de sesión incluye un enlace **¿Olvidaste tu contraseña?**.
- Al hacer clic, el usuario es redirigido a una pantalla donde introduce su correo.
- Firebase envía automáticamente un correo con el enlace para restablecer su contraseña.

### 🔒 Seguridad de contraseñas

- La contraseña se valida en tiempo real durante el registro, mostrando un checklist visual con:
  - ✔️ Longitud mínima
  - ✔️ Letra mayúscula
  - ✔️ Letra minúscula
  - ✔️ Número
  - ✔️ Símbolo
- El botón de registro solo se habilita cuando todos los criterios están cumplidos.

### 👁️‍🗨️ Protección de datos

- Firebase Auth maneja los datos de forma cifrada.
- No se almacenan contraseñas en texto plano.
- La validación de tokens y sesiones es gestionada por Firebase directamente.

---

## 🧠 Lógica de verificación condicional

El archivo `SplashWrapperScreen.dart` se encarga de:

- Detectar si hay un usuario autenticado (`FirebaseAuth.instance.currentUser`)
- Validar si su correo ha sido verificado (`user.emailVerified`)
- Redirigir:
  - Al dashboard si el usuario está verificado
  - A la pantalla de verificación si no lo está
  - Al selector de idioma si no hay sesión activa

Esto garantiza una **navegación automática y segura** basada en el estado real del usuario.

---
- El plugin `com.google.gms.google-services` se encuentra registrado en `android/app/build.gradle`.

### ✅ Web
- Se genera y configura el bloque de Firebase Web desde:
```bash
flutterfire configure
# Actualizar dependencias
flutter pub get

# Verificar que todo esté en orden
flutter doctor

# Ejecutar en Chrome (Web)
flutter run -d chrome

# Ejecutar en Android
flutter run -d <device_id>

# Ejecutar en Windows
flutter run -d windows

# Generar íconos a partir de logo2.png
flutter pub run flutter_launcher_icons:main

# Limpiar caché y reconstruir
flutter clean && flutter pub get
## 🧪 Pruebas y control de calidad

Lector Global está siendo construido bajo buenas prácticas de desarrollo, incluyendo verificación visual, validaciones en tiempo real y soporte básico para pruebas unitarias.

### ✅ Validaciones automáticas implementadas

- Validación visual de campos con íconos y bordes en tiempo real.
- Checklist de requisitos de contraseña.
- Botones desactivados hasta que el formulario esté correcto.
- Mensajes personalizados de error contextual.
- Enfoque (`Focus`) automático entre campos.

### 🔍 Pruebas funcionales (manuales)

| Prueba                                    | Estado   |
|------------------------------------------|----------|
| Registro con correo válido               | ✅        |
| Verificación de correo                   | ✅        |
| Login con correo no verificado           | ✅ bloqueado |
| Recuperación de contraseña               | ✅        |
| Login con Google                         | ✅        |
| Cambio dinámico de idioma                | ✅        |
| Navegación condicional según estado      | ✅        |

---

## ♿ Accesibilidad integrada

Lector Global está comprometido con la inclusión digital. Las siguientes medidas han sido implementadas:

- Soporte completo para navegación por teclado (`Focus`, `FocusNode`)
- Iconos e indicadores visibles cuando el elemento está seleccionado
- Uso de `Semantics` para compatibilidad con lectores de pantalla
- Colores con suficiente contraste y tipografía legible
- Mensajes visuales y de texto para validación accesible

---

## 📚 Documentación integrada

El proyecto incluye documentación tanto interna como externa:

- `README.md`: guía detallada del proyecto
- Comentarios en español en todos los archivos `.dart`
- Estructura clara y nombres descriptivos en clases, variables y rutas
- Archivos `.arb` sincronizados para traducción en tiempo real
- Carpetas organizadas para facilitar la comprensión por nuevos desarrolladores

---

## 🚀 Despliegue

### 🧱 Android

```bash
flutter build apk
## 📝 Licencia

Este proyecto ha sido desarrollado con fines educativos, sociales y culturales.  
**Lector Global** se distribuye bajo los principios de acceso libre, mejora continua y colaboración abierta.


**Permisos:**

- ✅ Se permite usar y modificar el código con fines educativos o no comerciales.
- ✅ Se permite compartir públicamente el proyecto siempre que se dé el debido crédito.
- ❌ No se permite su comercialización sin autorización explícita del autor.

> Una futura versión puede adoptar una licencia abierta como MIT o GPL si se consolida una comunidad activa.

---

## 👤 Autor principal

**Giovanni Holguín Rojas**  
📍 Medellín, Colombia  
🎓 Docente, investigador y desarrollador de software educativo.  
📬 Contacto: [giovannihr2004@gmail.com](mailto:giovannihr2004@gmail.com)  
🔗 [GitHub](https://github.com/giovannihr2004) – [Repositorio oficial](https://github.com/giovannihr2004/lg2)

---

## 🤝 Comunidad y contribuciones

Lector Global está abierto a la colaboración de:

- Desarrolladores Flutter
- Docentes y pedagogos
- Traductores y correctores
- Diseñadores de experiencia de usuario (UX)
- Estudiantes apasionados por la lectura y la tecnología

Si deseas contribuir:

```bash
# 1. Haz un fork del proyecto
# 2. Crea una rama con tu mejora: git checkout -b feature/tu-aporte
# 3. Sube tus cambios: git push origin feature/tu-aporte
# 4. Abre un Pull Request desde GitHub
