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
    apiKey: 'AIzaSyAGe12W02oq-rmRYZ8YKMDnukAPsbm0GZw',
    appId: '1:493359198058:web:439239c6f2c646d067bf13',
    messagingSenderId: '493359198058',
    projectId: 'itaxi-772b7',
    authDomain: 'itaxi-772b7.firebaseapp.com',
    storageBucket: 'itaxi-772b7.appspot.com',
    measurementId: 'G-7HHEH4BXJB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBQFjlD0SDsifsul1aNFX0R4Yxwb7KmRDM',
    appId: '1:493359198058:android:92702dabedd2500d67bf13',
    messagingSenderId: '493359198058',
    projectId: 'itaxi-772b7',
    storageBucket: 'itaxi-772b7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAZm8SHRHJdULOyGsII6DOH9fXs47LiWiw',
    appId: '1:493359198058:ios:c42f4152340dfa1e67bf13',
    messagingSenderId: '493359198058',
    projectId: 'itaxi-772b7',
    storageBucket: 'itaxi-772b7.appspot.com',
    androidClientId: '493359198058-i50ruqh35aog70nuh1s4baa0mg7cc4ki.apps.googleusercontent.com',
    iosClientId: '493359198058-9pb8gk3k4mfpclk8qm14un6p50pbem3v.apps.googleusercontent.com',
    iosBundleId: 'com.example.itaxi',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAZm8SHRHJdULOyGsII6DOH9fXs47LiWiw',
    appId: '1:493359198058:ios:c42f4152340dfa1e67bf13',
    messagingSenderId: '493359198058',
    projectId: 'itaxi-772b7',
    storageBucket: 'itaxi-772b7.appspot.com',
    androidClientId: '493359198058-i50ruqh35aog70nuh1s4baa0mg7cc4ki.apps.googleusercontent.com',
    iosClientId: '493359198058-9pb8gk3k4mfpclk8qm14un6p50pbem3v.apps.googleusercontent.com',
    iosBundleId: 'com.example.itaxi',
  );
}
