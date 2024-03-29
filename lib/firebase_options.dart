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
    apiKey: 'AIzaSyBWY2NW9jzGhgsOTu96nZQ03CVdJwNgszY',
    appId: '1:189846088666:web:64141fd90c95cadff8eee3',
    messagingSenderId: '189846088666',
    projectId: 'onliceryshop-474e8',
    authDomain: 'onliceryshop-474e8.firebaseapp.com',
    storageBucket: 'onliceryshop-474e8.appspot.com',
    measurementId: 'G-JVKZRT37HQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD7KHpBLKbUqn9m8H2Jx96e5yacmymhe4k',
    appId: '1:189846088666:android:8fd3bb67ff2d31b5f8eee3',
    messagingSenderId: '189846088666',
    projectId: 'onliceryshop-474e8',
    storageBucket: 'onliceryshop-474e8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBuIFrSHDXH-KlX7QWKbvDWTkR3WVgaMgA',
    appId: '1:189846088666:ios:94cb2b800758cb08f8eee3',
    messagingSenderId: '189846088666',
    projectId: 'onliceryshop-474e8',
    storageBucket: 'onliceryshop-474e8.appspot.com',
    iosBundleId: 'com.example.project',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBuIFrSHDXH-KlX7QWKbvDWTkR3WVgaMgA',
    appId: '1:189846088666:ios:eeaeb080d5dc87e8f8eee3',
    messagingSenderId: '189846088666',
    projectId: 'onliceryshop-474e8',
    storageBucket: 'onliceryshop-474e8.appspot.com',
    iosBundleId: 'com.example.project.RunnerTests',
  );
}
