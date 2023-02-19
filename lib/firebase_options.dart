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
    apiKey: 'AIzaSyD-4ISghw9sUUhqoJP1LDnF00s9Jcf8Tr4',
    appId: '1:792819827695:web:22f48c44f4891a4e302c1a',
    messagingSenderId: '792819827695',
    projectId: 'smart-refrigerator-app-db',
    authDomain: 'smart-refrigerator-app-db.firebaseapp.com',
    storageBucket: 'smart-refrigerator-app-db.appspot.com',
    measurementId: 'G-9LQPB5WYWF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAsOuujhc4nQOZakYXbTcRdQa1TD-TjEJM',
    appId: '1:792819827695:android:0c02349fee285fc9302c1a',
    messagingSenderId: '792819827695',
    projectId: 'smart-refrigerator-app-db',
    storageBucket: 'smart-refrigerator-app-db.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAtfFj-bYAyf85bAA7mqCnQHJnTyuyrju8',
    appId: '1:792819827695:ios:8fd32ec9d57c58a4302c1a',
    messagingSenderId: '792819827695',
    projectId: 'smart-refrigerator-app-db',
    storageBucket: 'smart-refrigerator-app-db.appspot.com',
    iosClientId: '792819827695-uacj0nt1aq78j2kiknp838bf7gj2g6pr.apps.googleusercontent.com',
    iosBundleId: 'com.example.smartRefrigeratorApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAtfFj-bYAyf85bAA7mqCnQHJnTyuyrju8',
    appId: '1:792819827695:ios:8fd32ec9d57c58a4302c1a',
    messagingSenderId: '792819827695',
    projectId: 'smart-refrigerator-app-db',
    storageBucket: 'smart-refrigerator-app-db.appspot.com',
    iosClientId: '792819827695-uacj0nt1aq78j2kiknp838bf7gj2g6pr.apps.googleusercontent.com',
    iosBundleId: 'com.example.smartRefrigeratorApp',
  );
}
