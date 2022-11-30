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
    apiKey: 'AIzaSyDBz2Yy-iwDhvX75CKV6viyYbjs8phZMZc',
    appId: '1:529937391499:web:6a5d6991fbb90fb9a0998e',
    messagingSenderId: '529937391499',
    projectId: 'siapprint',
    authDomain: 'siapprint.firebaseapp.com',
    storageBucket: 'siapprint.appspot.com',
    measurementId: 'G-SYQPCS2D1J',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAs-00fU1ONWtHVHOmt0DUKxzuLnaPNXms',
    appId: '1:529937391499:android:2153ea2e83e5ae5fa0998e',
    messagingSenderId: '529937391499',
    projectId: 'siapprint',
    storageBucket: 'siapprint.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCwSyLuyR8mznTQPbRSxI3e_jJaVBVqFhU',
    appId: '1:529937391499:ios:c7aa24272ec83424a0998e',
    messagingSenderId: '529937391499',
    projectId: 'siapprint',
    storageBucket: 'siapprint.appspot.com',
    iosClientId: '529937391499-nlqgfs14l2l3025r4vl59ebkbpg6dcbk.apps.googleusercontent.com',
    iosBundleId: 'com.siapprint.siapprint',
  );
}
