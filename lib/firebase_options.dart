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
    apiKey: 'AIzaSyCpCnDIsiIsMiV49JneTalmevH0Y056hJg',
    appId: '1:645150436359:web:716a2e74c9b400c61d4ea2',
    messagingSenderId: '645150436359',
    projectId: 'nscet-iot-transport',
    authDomain: 'nscet-iot-transport.firebaseapp.com',
    databaseURL: 'https://nscet-iot-transport-default-rtdb.firebaseio.com',
    storageBucket: 'nscet-iot-transport.appspot.com',
    measurementId: 'G-GZFSR3RHKZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDzRFveQcU1vg-3FkLLbdAxDmrzSzE1zSI',
    appId: '1:645150436359:android:3931ede22975dacf1d4ea2',
    messagingSenderId: '645150436359',
    projectId: 'nscet-iot-transport',
    databaseURL: 'https://nscet-iot-transport-default-rtdb.firebaseio.com',
    storageBucket: 'nscet-iot-transport.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAalhWHY7O_fhbQmBbPrBzJLbfzwLA70eU',
    appId: '1:645150436359:ios:321b888f9bfc19cc1d4ea2',
    messagingSenderId: '645150436359',
    projectId: 'nscet-iot-transport',
    databaseURL: 'https://nscet-iot-transport-default-rtdb.firebaseio.com',
    storageBucket: 'nscet-iot-transport.appspot.com',
    iosClientId: '645150436359-qb9b1ln218j8aasm4ao4ffha1p3q62g2.apps.googleusercontent.com',
    iosBundleId: 'com.example.etransportNscet',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAalhWHY7O_fhbQmBbPrBzJLbfzwLA70eU',
    appId: '1:645150436359:ios:321b888f9bfc19cc1d4ea2',
    messagingSenderId: '645150436359',
    projectId: 'nscet-iot-transport',
    databaseURL: 'https://nscet-iot-transport-default-rtdb.firebaseio.com',
    storageBucket: 'nscet-iot-transport.appspot.com',
    iosClientId: '645150436359-qb9b1ln218j8aasm4ao4ffha1p3q62g2.apps.googleusercontent.com',
    iosBundleId: 'com.example.etransportNscet',
  );
}