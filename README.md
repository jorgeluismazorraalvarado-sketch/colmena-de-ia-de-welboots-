# colmena-de-ia-de-welboots-

Aplicación de ejemplo para entrega de paquetes. La versión inicial permite iniciar
sesión únicamente mediante Google Sign-In usando Firebase Authentication.

Además, se otorgará una tarjeta electrónica de descuento: el envío número 11 será gratis.

## Estructura

- `app/pubspec.yaml` – dependencias de Flutter y configuración del proyecto.
- `app/lib/main.dart` – interfaz y lógica de autenticación con Google.

Para ejecutar el proyecto se requiere tener instalado [Flutter](https://flutter.dev)
y configurar un proyecto de Firebase con autenticación de Google habilitada.

```
flutter pub get
flutter run
```

## Vista rápida del código

El archivo `app/lib/main.dart` maneja el flujo de autenticación con Google y
muestra el nombre del usuario cuando la sesión se inicia correctamente:

```dart
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ...

ElevatedButton(
  onPressed: _signIn,
  child: const Text('Continuar con Google'),
);
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
