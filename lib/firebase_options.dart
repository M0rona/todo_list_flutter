// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBJLMft-te4XGGD2wpMom-LWISdg3rpgrA',
    appId: '1:1093463261080:android:1ff833a40191a8cdf535ed',
    messagingSenderId: '1093463261080',
    projectId: 'todo-list-provider-4011a',
    storageBucket: 'todo-list-provider-4011a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDeFec6ljU4QmNjaeVyE-2DK0DrqIthGwc',
    appId: '1:1093463261080:ios:1232c642f65b9a45f535ed',
    messagingSenderId: '1093463261080',
    projectId: 'todo-list-provider-4011a',
    storageBucket: 'todo-list-provider-4011a.appspot.com',
    androidClientId: '1093463261080-6isufefhpe5qkuesnsq36k3dh1b0onrp.apps.googleusercontent.com',
    iosClientId: '1093463261080-ic8aqnbjc4c803f1glccrj1u5prfei1a.apps.googleusercontent.com',
    iosBundleId: 'com.example.todoListProvider',
  );

}