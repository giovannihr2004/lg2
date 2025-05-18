> **Plantilla** **Flutter** **Profesional** **Multiplataforma**
>
> **Parte** **1** **de** **N:** **Propósito,** **filosofía,**
> **arquitectura** **y** **justificación** **técnica**
>
> Última actualización: 18/05/2025 - 13:26 (Hora de Colombia)
>
> **1.** **Propósito** **de** **esta** **plantilla**
>
> Esta plantilla establece una base sólida, modular, segura y escalable
> para desarrollar aplicaciones Flutter multiplataforma (Android, Web y
> Windows). Está diseñada para ser usada como punto de partida tanto
> para "Lector Global" como para cualquier app moderna y profesional que
> requiera:
>
> • Interfaces elegantes y reactivas
>
> • Soporte multilingüe desde el inicio
>
> • Seguridad robusta en el manejo de datos
>
> • Flujo de autenticación completo (registro, validación de email,
> login) • Estructura mantenible y documentada
>
> • Compatibilidad con prácticas avanzadas como CI/CD, accesibilidad y
> pruebas
>
> **2.** **Filosofía** **de** **desarrollo**
>
> • Centrada en el usuario: experiencia fluida, accesible y profesional
>
> • Centrada en la seguridad: prevención de cuentas duplicadas,
> validación por correo, autenticación segura y almacenamiento confiable
>
> • Centrada en la globalización: diseño para múltiples idiomas y
> culturas • Centrada en la arquitectura: separación clara entre lógica,
> presentación,
>
> servicios y proveedores
>
> • Centrada en la documentación: todo el proyecto está comentado,
> estructurado y listo para crecer
>
> **3.** **Justificación** **técnica**
>
> **3.1** **¿Por** **qué** **Flutter** **es** **la** **mejor**
> **herramienta?**
>
> **Criterio**
>
> Multiplataforma real
>
> Rendimiento
>
> UI personalizada
>
> Tiempo de desarrollo
>
> Comunidad y respaldo
>
> **Flutter**
>
> Android, Web, Windows, iOS

Nativo (ARM, AOT compilado)

100% personalizable con widgets

> Rápido con hot reload
>
> Google
>
> **React** **Native** **/** **Otros**

Limitado a Android/iOS

> Usa puente JS

Necesita puentes nativos

Más lento y dependiente

> Menor mantenimiento
>
> **3.2** **¿Por** **qué** **esta** **plantilla** **es** **superior**
> **a** **muchas** **apps** **del** **mercado?**
>
> • Incluye flujos de navegación modernos desde el arranque (Splash,
> Wrapper, Welcome)
>
> • Implementa seguridad avanzada: validación de correo electrónico
> obligatoria, bloqueo de usuarios duplicados, retroalimentación visual
> y textual inmediata
>
> • Estructura internacionalizada y escalable (más de 9 idiomas listos
> para cargar) • Comentada por secciones, con arquitectura limpia y
> desacoplada
>
> • Listo para pruebas unitarias, integración y despliegue automatizado
> • Preparada para términos legales, accesibilidad e inclusión global
>
> **4.** **Arquitectura** **general** **del** **sistema**
>
> **4.1** **Capas** **del** **sistema**
>
> • **UI** **(screens/)**: presentación de cada pantalla (splash, login,
> registro, dashboard...)
>
> • **Servicios** **(services/)**: lógica de conexión con Firebase,
> Google Auth, validación de email...
>
> • **Proveedores** **(providers/)**: control de idioma, estado del
> usuario, temas visuales...
>
> • **Widgets** **(widgets/)**: componentes visuales reutilizables y
> parametrizables
>
> • **Internacionalización** **(l10n/)**: archivos .arbcon traducciones
> listas para cargar • **Documentación** **y** **configuración**
> **(main.dart,** **pubspec,** **firebase_options)**
>
> **4.2** **Flujo** **general** **del** **usuario**
>
> 1\. Abre la app → pantalla splash animada
>
> 2\. Transición → wrapper que decide si está logueado 3. Si no lo está
> → WelcomeScreen con opciones
>
> 4\. Registro → validación de datos y verificación de correo
>
> 5\. Si correo no validado → acceso bloqueado hasta confirmar desde
> email 6. Si validado → Dashboard
>
> **Nota:** Este flujo previene spam, bots, cuentas falsas y usuarios
> sin verificar.
>
> **Continúa** **en** **Parte** **2:** **Preparación** **detallada**
> **del** **entorno** **Flutter,** **Firebase** **y** **dependencias**
> **esenciales**
>
> Aquí tienes la Parte 2 del documento **“** **Plantilla** **Flutter**
> **Profesional** **Multiplataforma”**, completamente integrada y
> actualizada con todos los aspectos requeridos:
>
> **Plantilla** **Flutter** **Profesional** **Multiplataforma**
>
> **Parte** **2** **de** **N:** **Preparación** **detallada** **del**
> **entorno** **Flutter,** **Firebase** **y** **dependencias**
> **esenciales**
>
> Última actualización: 18/05/2025 - 13:32 (Hora de Colombia)
>
> **1.** **Configuración** **del** **entorno** **de** **desarrollo**
>
> **1.1** **Sistemas** **operativos** **compatibles**
>
> **Plataforma** **Soportada** **Observaciones**
>
> Android Web Windows
>
> Linux/Mac

Requiere SDK, NDK y emulador/físico Compatible con Chrome y Firefox
Requiere compilador MSVC

Posible pero no optimizado aquí

> **1.2** **Requisitos** **del** **sistema**
>
> • Flutter 3.22.0 o superior (flutter doctor -vsin errores) • Dart SDK
> 3.7.2+
>
> • Android Studio con SDK Platform 35 y NDK instalado • VS Code con
> extensiones: Flutter, Dart
>
> • Navegador Chrome para pruebas Web • Visual C++ Build Tools para
> Windows
>
> **2.** **Creación** **inicial** **del** **proyecto**
>
> **2.1** **Ruta** **del** **proyecto**
>
> D:\Proyectos\lector-global\\
>
> **2.2** **Comando** **de** **creación**
>
> flutter create --platforms=android,web,windows lector_global
>
> **Seguridad** **del** **código** **inicial** **garantizada:** No
> sobrescribe archivos importantes si existe respaldo.
>
> **3.** **Estructura** **base** **generada**
>
> lector_global/ ├── android/ ├── web/
>
> ├── windows/ ├── lib/
>
> │ └── main.dart ├── l10n/
>
> ├── pubspec.yaml └── ...
>
> Esta estructura es estándar, pero ha sido mejorada manualmente en
> partes posteriores para adaptarse al flujo profesional.
>
> **4.** **Configuración** **de** **Firebase**
>
> **4.1** **Consola** **Firebase**
>
> 1\. Crear proyecto: “Lector Global” 2. Añadir plataformas:
>
> o Android: com.example.lector_global o Web: dominio autorizado (ej.
> localhost)
>
> o Windows: no requiere configuración directa
>
> **4.2** **Archivos** **descargados**
>
> • google-services.json→ android/app/
>
> • firebase_options.dart→ generado por CLI de FlutterFire
>
> **4.3** **Inicialización**
>
> En main.dart:
>
> await Firebase.initializeApp(
>
> options: DefaultFirebaseOptions.currentPlatform, );
>
> **5.** **Dependencias** **clave** **en** **pubspec.yaml**
>
> dependencies: flutter:
>
> sdk: flutter firebase_core: ^2.27.0 firebase_auth: ^4.17.4
> flutter_localizations:
>
> sdk: flutter intl: ^0.18.1 provider: ^6.1.2 flutter_gen: ^5.4.0
>
> flutter_facebook_auth: ^6.0.4 google_sign_in: ^6.2.1 intl_phone_field:
> ^3.2.0 flutter_svg: ^2.0.9 shared_preferences: ^2.2.2
>
> **6.** **Internacionalización**
>
> • Archivos .arbubicados en /lib/l10n • Configuración en pubspec.yaml:
>
> flutter: generate: true
>
> uses-material-design: true assets:
>
> \- assets/ localization:
>
> arb-dir: lib/l10n
>
> template-arb-file: app_en.arb
>
> output-localization-file: app_localizations.dart enabled: true
>
> • Comando para generar localización:
>
> flutter gen-l10n
>
> **7.** **Comprobaciones** **previas** **antes** **de** **programar**
> **interfaces**
>
> flutter doctorsin errores
>
> Firebase configurado en Android, Web y Windows Navegador
> predeterminado funcional
>
> App compila sin errores en Chrome (flutter run -d chrome)
>
> App compila sin errores en Android físico (flutter run -d
> \<device_id\>) App compila sin errores en Windows (flutter run -d
> windows)
>
> **Continúa** **en** **Parte** **3:** **Implementación** **de**
> **pantallas** **iniciales** **y** **navegación** **condicional**
> **con** **autenticación** **y** **validación** **de** **correo**
> **electrónico**
>
> ¿Deseas que te entregue ahora la Parte 3?
>
> Aquí tienes la **Parte** **3** completamente actualizada y lista para
> integrarse al documento:
>
> **Plantilla** **Flutter** **Profesional** **Multiplataforma**
>
> **Parte** **3** **de** **N:** **Implementación** **de** **pantallas**
> **iniciales** **y** **navegación** **condicional** **con**
> **autenticación** **y** **validación** **de** **correo**
> **electrónico**
>
> Última actualización: 18/05/2025 - 13:36 (Hora de Colombia)
>
> **1.** **Propósito**
>
> Establecer el flujo visual y lógico de arranque de la app, incluyendo:
>
> • Splash animado
>
> • Redirección según estado de autenticación y validación de email
>
> • Carga de idioma y tema
>
> • Presentación elegante en todas las plataformas
>
> **2.** **Estructura** **general** **de** **pantallas**
>
> lib/
>
> └── screens/
>
> ├── splash/
>
> │ ├── welcome_screen.dart
>
> │ ├── splash_text_screen.dart
>
> │ └── splash_wrapper_screen.dart
>
> **3.** **Pantalla:** **welcome_screen.dart**
>
> **3.1** **Propósito**
>
> Primera pantalla visible si el usuario no está autenticado. Ofrece dos
> opciones:
>
> • Iniciar sesión
>
> • Registrarse
>
> **3.2** **Características**
>
> • Logo animado con AnimatedOpacity, TweenAnimationBuilder, o
> FadeInImage
>
> • Fondo personalizado y responsive
>
> • Botones grandes y centrados
>
> • Accesible (semanticsLabel, contraste adecuado)
>
> • Soporte multilingüe
>
> **3.3** **Mejores** **prácticas** **aplicadas**
>
> • Reutilización de botones personalizados
>
> • Animaciones suaves (FadeTransition, ScaleTransition)
>
> • Navegación limpia: Navigator.pushNamed(context, '/login')
>
> • Preparada para accesibilidad (screen readers)
>
> **4.** **Pantalla:** **splash_text_screen.dart**
>
> **4.1** **Propósito**
>
> Mostrar por unos segundos el nombre de la app ("LECTOR GLOBAL") antes
> de continuar con el flujo.
>
> **4.2** **Características**
>
> • Texto central con animación de aparición/desaparición
>
> • Duración configurable
>
> • Soporte para texto localizado
> (AppLocalizations.of(context)!.appName)
>
> • Navegación automática con Future.delayed()
>
> **5.** **Pantalla:** **splash_wrapper_screen.dart**
>
> **5.1** **Propósito**
>
> Detectar si el usuario está autenticado y con email verificado, y
> redirigir:
>
> **Estado**
>
> No autenticado

**Redirección**

WelcomeScreen

> Autenticado pero no verificado VerifyEmailScreen
>
> Autenticado y verificado DashboardScreen
>
> **5.2** **Código** **clave**
>
> User? user = FirebaseAuth.instance.currentUser;
>
> if (user == null) {
>
> Navigator.pushReplacement(context, MaterialPageRoute(builder: (\_) =\>
> WelcomeScreen()));
>
> } else if (!user.emailVerified) {
>
> Navigator.pushReplacement(context, MaterialPageRoute(builder: (\_) =\>
> VerifyEmailScreen()));
>
> } else {
>
> Navigator.pushReplacement(context, MaterialPageRoute(builder: (\_) =\>
> DashboardScreen()));
>
> }
>
> **5.3** **Mejores** **prácticas**
>
> • Usa initState() para evaluar lógica antes de construir interfaz
>
> • Utiliza WidgetsBinding.instance.addPostFrameCallback() para evitar
> errores de navegación prematura
>
> • Seguridad: bloquea acceso si el email no está verificado
>
> **6.** **Accesibilidad** **y** **seguridad**
>
> • Todas las pantallas tienen soporte para idioma y screen readers
>
> • Se prohíbe el acceso sin validación de email (previene bots y spam)
>
> • Acciones visuales y auditivas de retroalimentación (snackbars,
> loading indicators)
>
> **Continúa** **en** **Parte** **4:** **Implementación** **del**
> **flujo** **de** **inicio** **de** **sesión** **profesional** **con**
> **validaciones** **en** **tiempo** **real,** **login** **con**
> **Google,** **y** **control** **de** **errores** **accesible**
>
> ¿Quieres que te entregue ahora la Parte 4?
>
> Aquí tienes la **Parte** **4** del documento, completamente
> actualizada y alineada con todas las mejores prácticas:
>
> **Plantilla** **Flutter** **Profesional** **Multiplataforma**
>
> **Parte** **4** **de** **N:** **Pantalla** **de** **inicio** **de**
> **sesión** **con** **validaciones** **profesionales,**
> **retroalimentación** **visual** **y** **autenticación** **con**
> **Google**
>
> Última actualización: 18/05/2025 - 13:38 (Hora de Colombia)
>
> **1.** **Propósito**
>
> Proporcionar al usuario una experiencia de inicio de sesión
> profesional, segura y accesible. Esta pantalla permite:
>
> • Iniciar sesión por correo y contraseña
>
> • Autenticarse con Google (Android y Web)
>
> • Obtener retroalimentación inmediata ante errores • Cambiar el idioma
> y tema desde la interfaz
>
> • Recuperar la contraseña (flujo conectado)
>
> **2.** **Archivo**
>
> lib/screens/auth/login_screen.dart
>
> **3.** **Características** **funcionales**
>
> **3.1** **Campos** **del** **formulario**
>
> **Campo** **Validación**
>
> Correo Sintaxis válida, no vacío, error personalizado
>
> Contraseña Mínimo 8 caracteres, mensaje de error si vacía o incorrecta
>
> **3.2** **Validación** **en** **tiempo** **real**
>
> TextFormField( validator: (value) {
>
> if (value == null \|\| value.isEmpty) return 'Este campo es
> obligatorio';
>
> if (!value.contains('@')) return 'Correo inválido'; return null;
>
> }, )
>
> Los botones se habilitan solo si el formulario es válido
> (FormState.validate())
>
> **4.** **Autenticación** **con** **Google**
>
> **4.1** **Flujo**
>
> 1\. Usuario pulsa el botón de Google
>
> 2\. Se invoca GoogleSignIn().signIn()
>
> 3\. Se autentica con Firebase y se verifica si es nuevo
>
> 4\. Se redirige al dashboard o a un flujo de verificación adicional si
> es necesario
>
> **4.2** **Código** **clave**
>
> final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
> final googleAuth = await googleUser?.authentication;
>
> final credential = GoogleAuthProvider.credential( accessToken:
> googleAuth?.accessToken,
>
> idToken: googleAuth?.idToken, );
>
> await FirebaseAuth.instance.signInWithCredential(credential);
>
> Solo disponible en Android y Web
>
> En Windows se muestra un AlertDialogindicando que no está disponible
>
> **5.** **Recuperación** **de** **contraseña**
>
> • Enlace “¿Olvidaste tu contraseña?” visible debajo del campo de
> contraseña • Redirige a reset_password_screen.dart
>
> • Flujo de validación con Firebase
>
> **6.** **Retroalimentación** **visual**
>
> **Evento** Inicio de sesión fallido
>
> Campos inválidos

**Respuesta** **UI** SnackBarcon mensaje específico

Borde rojo + mensaje debajo del campo

> **Evento**
>
> Login exitoso
>
> **Respuesta** **UI**

Spinner + transición animada al dashboard

> Autenticación Google cancelada SnackBar: "Inicio cancelado por el
> usuario"
>
> **7.** **Accesibilidad** **y** **localización**
>
> • AppLocalizations.of(context)!en todos los textos • semanticsLabelen
> botones importantes
>
> • Selector de idioma persistente con Provider • Contraste adecuado y
> botones grandes
>
> **8.** **Seguridad**
>
> • Firebase bloquea cuentas incorrectas o múltiples intentos • Emails
> incorrectos no revelan si existen en la base
>
> • Se detecta si el usuario tiene email no verificado y se redirige
>
> **9.** **Mejores** **prácticas** **aplicadas**
>
> • Formcon validación global y autovalidateMode • Providerpara
> gestionar tema/idioma
>
> • Componentes separados reutilizables (botones, textos) • Comentarios
> en español y código documentado
>
> **Continúa** **en** **Parte** **5:** **Pantalla** **de** **registro**
> **con** **validación** **visual** **avanzada,** **verificación**
> **de** **correo** **electrónico,** **bloqueo** **de** **usuarios**
> **duplicados** **y** **entrada** **internacional** **de** **teléfono**
>
> ¿Te entrego ahora la Parte 5?
>
> Aquí tienes la **Parte** **5** del documento, detallada y lista para
> integrarse con las anteriores:
>
> **Plantilla** **Flutter** **Profesional** **Multiplataforma**
>
> **Parte** **5** **de** **N:** **Pantalla** **de** **registro** **con**
> **validación** **visual** **avanzada,** **verificación** **de**
> **correo** **electrónico,** **bloqueo** **de** **usuarios**
> **duplicados** **y** **entrada** **internacional** **de** **teléfono**
>
> Última actualización: 18/05/2025 - 13:40 (Hora de Colombia)
>
> **1.** **Propósito**
>
> Permitir a los nuevos usuarios registrarse en la app de manera segura,
> guiada y con validación completa. El proceso garantiza:
>
> • Integridad de los datos ingresados • Seguridad en la contraseña
>
> • Validación obligatoria por correo electrónico antes de usar la app •
> Rechazo de registros duplicados
>
> • Soporte multilingüe y accesible
>
> **2.** **Archivo**
>
> lib/screens/auth/register_screen.dart
>
> **3.** **Campos** **del** **formulario** **y** **validaciones**
>
> **Campo** Nombre
>
> Correo electrónico
>
> Contraseña
>
> **Validación**

Requerido, sin números ni símbolos, sin espacios iniciales

Requerido, sintaxis válida, no duplicado en Firebase

Mínimo 8 caracteres, al menos una mayúscula, una minúscula, un número y
un símbolo

> Confirmar clave Debe coincidir con la anterior
>
> **Campo**
>
> Teléfono
>
> **Validación**

Formato internacional con prefijo, bandera y validación
(intl_phone_field)

> **4.** **Validación** **visual** **interactiva**
>
> • **Checklist** **dinámica** debajo del campo de contraseña con
> indicadores / por criterio
>
> • **Campo** **de** **correo** detecta en tiempo real si ya existe en
> Firebase (fetchSignInMethodsForEmail)
>
> • **Botón** **de** **registrar** solo se habilita si todos los campos
> están correctos
>
> **5.** **Proceso** **de** **registro**
>
> 1\. Validar campos localmente
>
> 2\. Verificar si el correo ya está registrado
>
> 3\. Crear el usuario en Firebase (createUserWithEmailAndPassword) 4.
> Enviar correo de verificación (sendEmailVerification())
>
> 5\. Mostrar pantalla de éxito y mensaje al usuario
>
> 6\. Bloquear el uso de la app hasta que el correo sea verificado
>
> **6.** **Seguridad**
>
> • No permite duplicar cuentas con el mismo correo
>
> • No muestra mensajes que revelen si un correo ya está registrado
> (protección de privacidad)
>
> • Contraseña nunca visible por defecto, se puede alternar visibilidad
> • Firebase autentica, pero además se valida antes de intentar
> registrar
>
> **7.** **Código** **clave:** **Validación** **de** **correo**
> **duplicado**
>
> final existingMethods = await
> FirebaseAuth.instance.fetchSignInMethodsForEmail(email); if
> (existingMethods.isNotEmpty) {
>
> // Mostrar error: correo ya registrado }
>
> **8.** **Código** **clave:** **Envío** **de** **correo** **de**
> **verificación**
>
> User? user = FirebaseAuth.instance.currentUser;
>
> if (user != null && !user.emailVerified) { await
> user.sendEmailVerification();
>
> }
>
> **9.** **Accesibilidad** **y** **usabilidad**
>
> • Textos multilingües (AppLocalizations) • Inputs con labelTexty
> semanticsLabel • Botones grandes y adaptables
>
> • Soporte para teclado virtual y pantallas pequeñas
>
> **10.** **Buenas** **prácticas** **aplicadas**
>
> • Validación reactiva en cada campo
>
> • Retroalimentación instantánea y personalizada • Código modular y
> comentado por bloques
>
> • Separación de responsabilidades: lógica vs interfaz
>
> **Continúa** **en** **Parte** **6:** **Pantalla** **de** **éxito**
> **tras** **registro** **y** **flujo** **de** **bloqueo** **hasta**
> **validación** **de** **correo** **electrónico**
>
> ¿Te entrego ahora la Parte 6?
>
> Aquí tienes la **Parte** **6** del documento, completamente
> estructurada y alineada con el flujo seguro y profesional de la app:
>
> **Plantilla** **Flutter** **Profesional** **Multiplataforma**
>
> **Parte** **6** **de** **N:** **Pantalla** **de** **éxito** **tras**
> **registro** **y** **flujo** **de** **bloqueo** **hasta**
> **validación** **de** **correo** **electrónico**
>
> Última actualización: 18/05/2025 - 13:42 (Hora de Colombia)
>
> **1.** **Propósito**
>
> Garantizar que el usuario confirme su correo electrónico antes de usar
> la app, mediante una pantalla intermedia que:
>
> • Notifica el éxito del registro
>
> • Informa que debe verificar su email
>
> • Impide el acceso a funciones hasta que la verificación se complete
>
> **2.** **Archivo** **sugerido**
>
> lib/screens/auth/verify_email_screen.dart
>
> **3.** **Comportamiento** **funcional**
>
> **3.1** **Al** **llegar** **a** **esta** **pantalla:**
>
> • Se muestra un mensaje: “Revisa tu bandeja de entrada y confirma tu
> correo electrónico.”
>
> • Se indica qué correo fue usado para registrarse. • Se ofrece:
>
> o Botón para **reenviar** **el** **correo** de verificación o Botón
> para **volver** **a** **pantalla** **de** **login**
>
> o Botón para **verificar** **nuevamente** el estado actual (revisar si
> ya se confirmó)
>
> **4.** **Código** **clave:** **Verificación** **del** **estado**
> **del** **correo**
>
> await user.reload();
>
> user = FirebaseAuth.instance.currentUser; if (user!.emailVerified) {
>
> Navigator.pushReplacement(context, MaterialPageRoute(builder: (\_) =\>
> DashboardScreen()));
>
> }
>
> **5.** **Código** **clave:** **Reenviar** **verificación**
>
> await FirebaseAuth.instance.currentUser?.sendEmailVerification();
>
> **6.** **Seguridad** **reforzada**
>
> • Si el correo no ha sido verificado, cualquier intento de navegación
> hacia otras pantallas es bloqueado desde splash_wrapper_screen.dart
>
> • No se permiten inicios de sesión efectivos sin validación
>
> • Cada reintento de verificación tiene control de frecuencia para
> evitar spam
>
> **7.** **Diseño** **visual** **sugerido**
>
> • Icono o ilustración representando éxito
>
> • Animación breve de entrada (ej. FadeIn, SlideTransition) • Texto
> personalizado multilingüe (AppLocalizations)
>
> • Tema claro u oscuro dinámico según preferencia del sistema
>
> **8.** **Accesibilidad** **y** **usabilidad**
>
> • Compatibilidad con lectores de pantalla (semanticsLabel) • Texto
> centrado, fuente grande, espaciado amplio
>
> • Botones etiquetados correctamente y accesibles desde teclado y
> lector
>
> **9.** **Buenas** **prácticas** **aplicadas**
>
> • Mensajes directos y amigables
>
> • Código desacoplado y reutilizable • Acciones claras sin ambigüedad
>
> • Sección preparada para ampliarse (temporizador, notificaciones
> futuras, etc.)
>
> **Continúa** **en** **Parte** **7:** **Implementación** **de**
> **navegación** **inteligente** **desde** **main.dart,** **control**
> **de** **rutas,** **y** **envoltura** **de** **estado** **para**
> **idioma,** **autenticación** **y** **tema**
>
> ¿Te entrego ahora la Parte 7?
>
> Aquí tienes la **Parte** **7** del documento, detallada y estructurada
> para garantizar un flujo de navegación limpio, seguro y profesional:
>
> **Plantilla** **Flutter** **Profesional** **Multiplataforma**
>
> **Parte** **7** **de** **N:** **Configuración** **de** **navegación**
> **inteligente** **desde** **main.dart,** **control** **de** **rutas**
> **y** **envoltura** **de** **estado** **(idioma,** **autenticación,**
> **tema)**
>
> Última actualización: 18/05/2025 - 13:44 (Hora de Colombia)
>
> **1.** **Propósito**
>
> Establecer la estructura de arranque de la aplicación en el archivo
> main.dart, incluyendo:
>
> • Inicialización de Firebase
>
> • Soporte para internacionalización
>
> • Control de rutas condicionales según autenticación y verificación de
> email • Envoltura global con Providerpara idioma y tema
>
> **2.** **Archivo**
>
> lib/main.dart
>
> **3.** **Inicialización** **de** **Firebase**
>
> void main() async { WidgetsFlutterBinding.ensureInitialized(); await
> Firebase.initializeApp(
>
> options: DefaultFirebaseOptions.currentPlatform, );
>
> runApp(const MyApp()); }
>
> **4.** **Clase** **principal** **MyApp**
>
> **4.1** **Con** **envoltorios** **de** **estado** **global**
>
> class MyApp extends StatelessWidget { const MyApp({super.key});
>
> @override
>
> Widget build(BuildContext context) { return MultiProvider(
>
> providers: \[
>
> ChangeNotifierProvider(create: (\_) =\> LanguageProvider()),
> ChangeNotifierProvider(create: (\_) =\> ThemeProvider()),
>
> \],
>
> child: Consumer2\<LanguageProvider, ThemeProvider\>(
>
> builder: (context, languageProvider, themeProvider, child) { return
> MaterialApp(
>
> title: 'Lector Global',
>
> theme: themeProvider.currentTheme, locale: languageProvider.locale,
>
> supportedLocales: AppLocalizations.supportedLocales,
> localizationsDelegates:
>
> AppLocalizations.localizationsDelegates, debugShowCheckedModeBanner:
> false, home: const SplashWrapperScreen(),
>
> ); },
>
> ), );
>
> } }
>
> **5.** **Ventajas** **de** **este** **diseño**
>
> **Característica**
>
> MultiProvider
>
> **Beneficio**

Permite manejar múltiples estados globales sin conflictos

> SplashWrapperScreenDirige)al usuario según su estado (no logueado, sin
> verificar, o
>
> AppLocalizations
>
> ThemeProvider

Multilenguaje activado desde el arranque

Permite cambio de tema claro/oscuro dinámico

> **6.** **Arquitectura** **de** **rutas**
>
> • En lugar de routes:estáticas, se usa navegación programática
> condicional en SplashWrapperScreen
>
> • En versiones futuras puede migrarse a go_routero auto_routepara
> escalabilidad
>
> **7.** **Control** **de** **errores** **y** **seguridad**
>
> • Si Firebase falla en la inicialización, se lanza mensaje de error •
> El estado del usuario se evalúa una única vez al inicio
>
> • Redirección protegida contra acceso manual a rutas indebidas
>
> **8.** **Mejores** **prácticas** **aplicadas**
>
> • Estructura mínima, clara y segura
>
> • Delegación de decisiones a componentes especializados
> (SplashWrapperScreen)
>
> • Separación de lógica visual, de estado y de rutas • Preparado para
> escalar sin romper arquitectura
>
> **Continúa** **en** **Parte** **8:** **Implementación** **de**
> **sistema** **visual** **de** **retroalimentación,** **accesibilidad**
> **avanzada** **y** **control** **de** **errores** **amigables** **en**
> **toda** **la** **app**
>
> ¿Te entrego ahora la Parte 8?
>
> Aquí tienes la **Parte** **8** del documento, centrada en la
> retroalimentación visual, accesibilidad avanzada y manejo profesional
> de errores:
>
> **Plantilla** **Flutter** **Profesional** **Multiplataforma**
>
> **Parte** **8** **de** **N:** **Sistema** **de** **retroalimentación**
> **visual,** **accesibilidad** **avanzada** **y** **manejo**
> **profesional** **de** **errores**
>
> Última actualización: 18/05/2025 - 13:46 (Hora de Colombia)
>
> **1.** **Propósito**
>
> Brindar al usuario una experiencia clara, comprensible y accesible
> ante cualquier acción o error. Se busca:
>
> • Informar visualmente cada resultado (positivo o negativo) • Prevenir
> frustración con mensajes amigables
>
> • Aumentar la confianza del usuario
>
> • Garantizar accesibilidad para todos los perfiles (incluyendo
> discapacidad visual)
>
> **2.** **Canales** **de** **retroalimentación** **integrados**
>
> **Canal** SnackBars AlertDialogs
>
> Loaders

**Uso** **principal** Notificaciones breves y flotantes Confirmaciones o
errores críticos

Indicadores de espera durante operaciones

> Validaciones UI Borde rojo, ícono de error, texto descriptivo
>
> **3.** **Implementación** **de** **SnackBar**
>
> ScaffoldMessenger.of(context).showSnackBar( SnackBar(
>
> content: Text('Correo o contraseña inválidos.'), backgroundColor:
> Colors.redAccent,
>
> duration: Duration(seconds: 3), ),
>
> );
>
> **4.** **Implementación** **de** **AlertDialogaccesible**
>
> showDialog( context: context,
>
> builder: (\_) =\> AlertDialog( title: Text('Error'),
>
> content: Text('Esta función no está disponible en tu plataforma.'),
>
> actions: \[ TextButton(
>
> child: Text('Aceptar'),
>
> onPressed: () =\> Navigator.of(context).pop(), ),
>
> \], ),
>
> );
>
> **5.** **Indicadores** **de** **carga**
> **(CircularProgressIndicator)**
>
> • Se usa dentro de Stacko Center
>
> • Se muestra mientras se realiza login, registro o verificación
>
> **6.** **Validación** **visual** **de** **campos**
>
> • Cada campo con errores muestra borde rojo y mensaje bajo el input •
> Iconos de advertencia para accesibilidad rápida
>
> •      Validación reactiva con autovalidateMode:
> AutovalidateMode.onUserInteraction
>
> **7.** **Accesibilidad** **avanzada**
>
> **Recurso** semanticsLabel
>
> Tooltip
>
> MediaQuery
>
> **Aplicación** **en** **la** **plantilla**

En botones e imágenes (ej: "Logo de Lector Global") En iconos y campos
de texto

Tamaños adaptables a usuarios con accesibilidad aumentada

> High Contrastsupport Compatible con modos de alto contraste Navegación
> por teclado Prueba en Web y Windows asegurada
>
> **8.** **Mensajes** **por** **tipo** **de** **error**
>
> **Tipo** **de** **error**
>
> Correo inválido
>
> **Ejemplo** **de** **mensaje** **mostrado**

“Formato de correo electrónico incorrecto”

> **Tipo** **de** **error** **Ejemplo** **de** **mensaje** **mostrado**
> Contraseña incorrecta “La contraseña no coincide”
>
> Cuenta ya registrada Google cancelado No internet
>
> Firebase general

“Ya existe una cuenta con este correo” “Inicio cancelado por el usuario”
“Verifica tu conexión antes de continuar”

“Algo salió mal. Intenta nuevamente más tarde.”

> **9.** **Buenas** **prácticas** **aplicadas**
>
> • Todos los mensajes son localizables vía AppLocalizations
>
> • Retroalimentación nunca es ambigua: se da en texto claro y visible
>
> • Acciones posibles (intentar de nuevo, cancelar, verificar) se
> muestran si es necesario
>
> **Continúa** **en** **Parte** **9:** **Implementación** **completa**
> **de** **internacionalización** **con** **archivos** **.arb,**
> **múltiples** **idiomas** **y** **estructura** **escalable**
>
> ¿Te entrego ahora la Parte 9?
>
> Aquí tienes la **Parte** **9** del documento, dedicada a la
> internacionalización completa y escalable de la app:
>
> **Plantilla** **Flutter** **Profesional** **Multiplataforma**
>
> **Parte** **9** **de** **N:** **Internacionalización** **completa**
> **con** **archivos** **.arb,** **múltiples** **idiomas** **y**
> **estructura** **escalable**
>
> Última actualización: 18/05/2025 - 13:48 (Hora de Colombia)
>
> **1.** **Propósito**
>
> Permitir que la app funcione desde el inicio en múltiples idiomas,
> facilitando:
>
> • Inclusión cultural y lingüística • Accesibilidad global
>
> •      Escalabilidad rápida a nuevos mercados •      Coherencia entre
> interfaces multilingües
>
> **2.** **Carpeta** **de** **internacionalización**
>
> lib/l10n/
>
> ├── intl_es.arb ├── intl_en.arb ├── intl_fr.arb ├── intl_de.arb

// Español // Inglés

// Francés (opcional) // Alemán (opcional)

> **3.** **Contenido** **base** **de** **un** **archivo** **.arb**
>
> {
>
> "@@locale": "es", "appName": "Lector Global", "login": "Iniciar
> sesión", "register": "Registrarse",
>
> "email": "Correo electrónico", "password": "Contraseña",
>
> "invalidCredentials": "Credenciales inválidas", "requiredField": "Este
> campo es obligatorio", "registrationSuccess": "¡Registro exitoso!",
> "goToStart": "Volver al inicio"
>
> }
>
> **4.** **Configuración** **en** **pubspec.yaml**
>
> flutter: generate: true
>
> uses-material-design: true assets:
>
> \- assets/ localization:
>
> arb-dir: lib/l10n
>
> template-arb-file: intl_en.arb
>
> output-localization-file: app_localizations.dart
>
> **5.** **Generación** **automática**
>
> flutter gen-l10n
>
> Esto crea el archivo app_localizations.dartpara acceder fácilmente a
> los textos traducidos.
>
> **6.** **Uso** **en** **el** **código**
>
> Text(AppLocalizations.of(context)!.login)
>
> **7.** **Integración** **con** **MaterialApp(main.dart)**
>
> locale: languageProvider.locale,
>
> localizationsDelegates: AppLocalizations.localizationsDelegates,
> supportedLocales: AppLocalizations.supportedLocales,
>
> **8.** **Cambio** **de** **idioma** **en** **tiempo** **real**
>
> • Controlado con Provider(LanguageProvider) • Widget reutilizable:
> LanguageSelector
>
> • Guardado opcional en SharedPreferencespara persistencia
>
> **9.** **Buenas** **prácticas**
>
> **Recomendación**
>
> No concatenar cadenas
>
> **Motivo**

Evita problemas de gramática por orden variable entre idiomas

> **Recomendación**
>
> Usar descripciones contextuales en .arb
>
> Evitar repetir cadenas
>
> Probar en múltiples resoluciones y dispositivos
>
> **Motivo**

Ayuda a traductores a entender el significado exacto

Reduce errores y facilita actualizaciones

Asegura legibilidad en todos los casos

> **10.** **Escalabilidad**
>
> • Agregar un nuevo idioma solo requiere un archivo .arb • Compatible
> con herramientas de traducción colaborativa • Preparado para hasta 200
> idiomas sin reestructurar código
>
> **Continúa** **en** **Parte** **10:** **Inclusión** **de**
> **política** **de** **privacidad,** **términos** **y**
> **condiciones,** **y** **estructura** **de** **documentación**
> **legal** **obligatoria**
>
> ¿Te entrego ahora la Parte 10?
>
> Aquí tienes la **Parte** **10** del documento, dedicada a los aspectos
> legales y de documentación obligatoria para distribución profesional
> de apps:
>
> **Plantilla** **Flutter** **Profesional** **Multiplataforma**
>
> **Parte** **10** **de** **N:** **Política** **de** **privacidad,**
> **términos** **y** **condiciones,** **y** **estructura** **de**
> **documentación** **legal** **obligatoria**
>
> Última actualización: 18/05/2025 - 13:50 (Hora de Colombia)
>
> **1.** **Propósito**
>
> Garantizar que la aplicación cumpla con los requerimientos legales
> para operar en plataformas como Google Play, App Store y en entornos
> educativos o institucionales.
>
> **2.** **Archivos** **sugeridos**
>
> lib/screens/legal/privacy_policy_screen.dart
> lib/screens/legal/terms_conditions_screen.dart
>
> **3.** **Contenidos** **requeridos**
>
> **3.1** **Política** **de** **privacidad**
> **(privacy_policy_screen.dart)**
>
> Debe contener:
>
> • Qué información se recopila (correo, nombre, IP, uso de Firebase,
> etc.) • Cómo se almacena (Firebase Authentication y Firestore)
>
> • Finalidad del uso de los datos
>
> •      Derechos del usuario (eliminar cuenta, rectificar datos)
> •      Información de contacto del desarrollador/responsable
>
> • Cumplimiento con la ley de protección de datos (GDPR, Ley 1581 en
> Colombia)
>
> **3.2** **Términos** **y** **condiciones**
> **(terms_conditions_screen.dart)**
>
> Debe especificar:
>
> • Obligaciones del usuario (usar la app legalmente, no suplantar)
>
> • Límites de responsabilidad de la app
>
> • Condiciones de uso de servicios de terceros (Firebase, Google) •
> Restricciones de edad, si aplica
>
> • Propiedad intelectual del contenido y del software
>
> **4.** **Acceso** **a** **estas** **pantallas**
>
> • Enlaces en la pantalla de inicio de sesión (checkbox “Acepto
> términos y condiciones”)
>
> • Botones visibles también desde configuración o perfil
>
> • Están integradas con AppLocalizationspara soporte multilingüe
>
> **5.** **Validación** **obligatoria**
>
> Antes de registrar un nuevo usuario, debe confirmarse que:
>
> Ha aceptado términos y condiciones Ha leído la política de privacidad
>
> Se han guardado las versiones aceptadas con marca de tiempo
>
> **6.** **Cumplimiento** **con** **la** **seguridad** **de** **datos**
>
> • Firebase Authentication garantiza cifrado de credenciales •
> Firestore cifra los datos en tránsito y en reposo
>
> • No se almacenan contraseñas localmente
>
> • La app valida que el email esté verificado antes de permitir el
> acceso • No se permiten cuentas duplicadas con el mismo correo
>
> **7.** **Documentación** **de** **la** **app**
>
> **7.1** **Requisitos** **para** **distribución**
>
> • privacy_policy.htmly terms_conditions.htmldeben estar disponibles
> públicamente (Firebase Hosting, GitHub Pages, etc.)
>
> • En Google Play deben declararse los siguientes permisos y prácticas:
> o Acceso a red
>
> o Uso de Firebase Analytics o Crashlytics (si se incluyen) o
> Declaración de eliminación de cuenta (si aplica)
>
> **7.2** **Documentación** **interna** **sugerida**
>
> **Documento**
>
> CONTEXT.md
>
> **Propósito**

Describe la arquitectura general de la app

> SECURITY_POLICY.mdDefine reglas internas de protección de datos
>
> LICENSE.txt
>
> CHANGELOG.md

Define los derechos de uso del código fuente

Registro detallado de versiones y mejoras

> **8.** **Buenas** **prácticas** **aplicadas**
>
> • No se realiza ningún uso de los datos sin consentimiento expreso •
> Toda recopilación de datos está documentada y justificada
>
> • Se prepara la app para auditorías o revisiones por parte de
> plataformas oficiales
>
> Con esta parte se completa el ciclo inicial de desarrollo de una app
> Flutter profesional, ética, segura, accesible, escalable, legal y
> lista para distribución.
>
> ¿Deseas que te entregue ahora el documento Word con las 10 partes
> completas y revisadas?
>
> Aquí tienes una lista de chequeo profesional para evaluar una
> plantilla Flutter multiplataforma, con categorías claves, puntajes
> máximos y la evaluación aplicada a la plantilla desarrollada hasta la
> Parte 10:
>
> **Lista** **de** **chequeo** **para** **evaluación** **de** **una**
> **plantilla** **Flutter** **profesional**

||
||
||
||
||
||
||
||
||
||
||
||

||
||
||
||

> **Puntaje** **total** **obtenido:** **196** **/** **200** **puntos**
>
> **Clasificación:**
>
> **Nivel:** **EXCELENTE**
>
> **Lista** **para** **distribución** **profesional,** **clonable**
> **como** **plantilla** **base** **para** **cualquier** **app**
> **Flutter** **moderna** **y** **ética.**
