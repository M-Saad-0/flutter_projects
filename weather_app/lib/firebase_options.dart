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
      return web;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDdb5Ur5-7SLY-Php-f0zUW9RbeX-yPpnE',
    appId: '1:964965781993:web:2aff8056de13ad92c1fb78',
    messagingSenderId: '964965781993',
    projectId: 'eyecaredb-10bd4',
    authDomain: 'eyecaredb-10bd4.firebaseapp.com',
    storageBucket: 'eyecaredb-10bd4.appspot.com',
    measurementId: 'G-558583TQWV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC9qnp7mkNQjqpcQyw9Hda6Q72ac5qf1dg',
    appId: '1:964965781993:android:63d478e0d5d99b49c1fb78',
    messagingSenderId: '964965781993',
    projectId: 'eyecaredb-10bd4',
    storageBucket: 'eyecaredb-10bd4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBf4ZDaZV4s-ogCvRMxTIjw6UbL7VACMOw',
    appId: '1:964965781993:ios:809ab50455eee5c9c1fb78',
    messagingSenderId: '964965781993',
    projectId: 'eyecaredb-10bd4',
    storageBucket: 'eyecaredb-10bd4.appspot.com',
    iosBundleId: 'com.example.weatherApp',
  );
}
