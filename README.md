# 📚 Lector Global

![Flutter](https://img.shields.io/badge/Flutter-Framework-blue?logo=flutter)
![Firebase](https://img.shields.io/badge/Firebase-Auth-yellow?logo=firebase)
![Platform](https://img.shields.io/badge/Platform-Web--Android--Windows-brightgreen)
![License](https://img.shields.io/badge/License-Educational-lightgrey)

<p align="center">
  <img src="assets/images/logo_welcome.png" alt="Logo Lector Global" height="160">
</p>

<p align="center">
  <img src="https://via.placeholder.com/600x320?text=Captura+Dashboard" alt="Captura de Dashboard" width="600">
</p>

**Lector Global** es una aplicación educativa multiplataforma (Android, Web y Windows) desarrollada en Flutter. Está diseñada para fortalecer la comprensión lectora en todos los idiomas y niveles, con una interfaz accesible, validación por correo electrónico y flujos profesionales de usuario. Inspirada en los principios del Marco Común Europeo de Referencia para las Lenguas, esta app es ideal para usuarios, escuelas, y proyectos de aprendizaje autónomo.

---
## ✅ Funcionalidades implementadas

| Funcionalidad                             | Estado     |
| ----------------------------------------- | ---------- |
| Registro con correo y contraseña          | ✅ Completo |
| Verificación de correo electrónico        | ✅ Completo |
| Inicio de sesión con validación segura    | ✅ Completo |
| Inicio de sesión con Google               | ✅ Completo |
| Recuperación de contraseña                | ✅ Completo |
| Cambios de idioma en tiempo real          | ✅ Completo |
| Accesibilidad para lectores de pantalla   | ✅ Completo |
| Validación visual de formularios          | ✅ Completo |
| Control de sesión y redirección segura    | ✅ Completo |
| Compatibilidad con Android, Web y Windows | ✅ Completo |

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

## Estructura del proyecto
lib/
├── main.dart                         # Punto de entrada principal
│
├── screens/                          # Pantallas agrupadas por flujo
│   ├── auth/                         # Registro, login, recuperación
│   ├── splash/                       # Splash screens animadas
│   ├── intro/                        # Pantalla de bienvenida y lenguaje
│   └── dashboard/                    # Pantalla principal de usuario
│
├── services/                         # Lógica desacoplada
├── providers/                        # Estado global (idioma, sesión)
├── widgets/                          # Componentes reutilizables
├── l10n/                             # Archivos .arb de traducción
├── assets/                           # Imágenes, íconos, logos
└── generated/                        # Archivos autogenerados

## 🔐 Autenticación y seguridad

Lector Global utiliza Firebase Authentication con correo, contraseña y Google Sign-In.  
El acceso se bloquea hasta que el correo del usuario haya sido verificado.

- ✅ Validación visual de contraseñas (mínimo 8 caracteres, mayúscula, minúscula, número, símbolo)
- ✅ Recuperación de contraseña
- ✅ Login solo si el correo está verificado
- ✅ Inicio de sesión con Google (Web y Android)
- ✅ Protección de sesión con `user.reload()` y control condicional

---

## ♿ Accesibilidad integrada

- `Semantics` aplicado a todos los botones, formularios y textos visibles
- Navegación por teclado con `FocusNode`
- Colores con contraste alto y tipografía accesible
- Traducción activa en tiempo real para hasta 10 idiomas

---

## 📝 Licencia

**Lector Global** es un proyecto educativo y social, abierto a colaboración.  
Su código puede ser reutilizado libremente para fines **educativos y no comerciales**.  
No se permite su comercialización sin autorización explícita del autor.

---

## 👤 Autor

**Giovanni Holguín Rojas**  
📍 Medellín, Colombia  
👨‍🏫 Docente, investigador y desarrollador de software educativo  
📬 Contacto: [giovannihr2004@gmail.com](mailto:giovannihr2004@gmail.com)  
🔗 [Repositorio oficial](https://github.com/giovannihr2004/lg2)

---

## 🤝 Contribuciones

¿Te interesa aportar al proyecto?

```bash
# 1. Haz un fork del repositorio
# 2. Crea una rama con tu mejora: git checkout -b feature/mi-mejora
# 3. Haz tus cambios y sube: git push origin feature/mi-mejora
# 4. Abre un Pull Request desde GitHub
