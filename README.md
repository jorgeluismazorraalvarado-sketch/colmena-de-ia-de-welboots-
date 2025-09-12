# colmena-de-ia-de-welboots-

Aplicación de ejemplo para entrega de paquetes. La versión inicial permite iniciar
sesión únicamente mediante Google Sign-In usando Firebase Authentication. Para
utilizar Firebase es necesario inicializarlo al arrancar la app.

Además, se otorgará una tarjeta electrónica de descuento: el envío número 11 será gratis.

## Estructura

- `app/pubspec.yaml` – dependencias de Flutter y configuración del proyecto.
- `app/lib/main.dart` – coordina la navegación según el estado de autenticación.
- `app/lib/login_page.dart` – pantalla de inicio de sesión con Google.
- `app/lib/home_page.dart` – pantalla mostrada tras autenticarse.
- `web/index.html` – prototipo web con autenticación Google.
- `web/main.js` – lógica de inicio/cierre de sesión para la versión web.

Para ejecutar el proyecto se requiere tener instalado [Flutter](https://flutter.dev)
y configurar un proyecto de Firebase con autenticación de Google habilitada.
Las dependencias principales incluyen `google_sign_in`, `firebase_auth` y
`firebase_core`.

```
flutter pub get
flutter run
```

## Versión web

Dentro de `web/` se incluye una adaptación mínima para navegadores.

1. Reemplaza los valores de configuración en `web/main.js` con los de tu
   proyecto de Firebase.
2. Sirve la carpeta `web` con un servidor estático, por ejemplo:

   ```bash
   cd web
   python -m http.server 8080
   ```

3. Abre `http://localhost:8080` en el navegador y autentícate con Google.

## Vista rápida del código

El archivo `app/lib/main.dart` coordina el flujo de autenticación mostrando
`LoginPage` o `HomePage` según el estado de `FirebaseAuth`. La `LoginPage` contiene
el botón para acceder con Google y la `HomePage` despliega el nombre del usuario
cuando la sesión se inicia correctamente:

```dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

// ... resto del código de la interfaz y autenticación
```

## Publicación en tiendas

### Android (Google Play)
1. Genera un keystore de subida:
   ```bash
   keytool -genkey -v -keystore android/app/upload-keystore.jks \
     -keyalg RSA -keysize 2048 -validity 10000 -alias upload
   ```
2. Configura las credenciales en `android/key.properties`.
3. Compila el paquete de lanzamiento:
   ```bash
   flutter build appbundle --release
   ```
4. Sube el archivo `.aab` generado a [Google Play Console](https://play.google.com/console).

### iOS (App Store)
1. Inscríbete en el [Apple Developer Program](https://developer.apple.com/programs/) y
   crea certificados, perfiles de distribución y un *bundle identifier*.
2. En macOS con Xcode instalado, compila el binario:
   ```bash
   flutter build ipa --release
   ```
3. Sube el `.ipa` mediante la app **Transporter** o `xcrun altool` a
   [App Store Connect](https://appstoreconnect.apple.com).
4. Completa los metadatos y envía la versión a revisión.
