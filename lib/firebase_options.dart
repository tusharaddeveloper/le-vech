// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCFGld7ursgUNVjBft0pYiatck8GQFiPV4',
    appId: '1:456866816371:web:f4ff9c8e290186dce9a506',
    messagingSenderId: '456866816371',
    projectId: 'le---vech',
    authDomain: 'le---vech.firebaseapp.com',
    storageBucket: 'le---vech.appspot.com',
    measurementId: 'G-1SNR04ZB3P',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDQz8nHkq0fgVcql9Y8gCEJVTrafoOGSgQ',
    appId: '1:456866816371:android:6616598d87186363e9a506',
    messagingSenderId: '456866816371',
    projectId: 'le---vech',
    storageBucket: 'le---vech.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBvrhubgoAfp4pBbc8DYQvjFHwPturo57o',
    appId: '1:456866816371:ios:948e8a361811f2e1e9a506',
    messagingSenderId: '456866816371',
    projectId: 'le---vech',
    storageBucket: 'le---vech.appspot.com',
    iosBundleId: 'com.example.leVech',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBvrhubgoAfp4pBbc8DYQvjFHwPturo57o',
    appId: '1:456866816371:ios:2ad7d0b10712e115e9a506',
    messagingSenderId: '456866816371',
    projectId: 'le---vech',
    storageBucket: 'le---vech.appspot.com',
    iosBundleId: 'com.example.leVech.RunnerTests',
  );
}
