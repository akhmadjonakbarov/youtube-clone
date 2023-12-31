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
    apiKey: 'AIzaSyBN5DEiwU8NF7YsaKI-TG5dIVkbp8Rhm9A',
    appId: '1:1032893027793:web:ba7fa6f82b41402d393cf0',
    messagingSenderId: '1032893027793',
    projectId: 'clone-25d77',
    authDomain: 'clone-25d77.firebaseapp.com',
    storageBucket: 'clone-25d77.appspot.com',
    measurementId: 'G-4WM7YCE3CP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA7bhqgO0E7b6-ZPibeH-V-6zXWNXm52r8',
    appId: '1:1032893027793:android:c3c6f06400c4754c393cf0',
    messagingSenderId: '1032893027793',
    projectId: 'clone-25d77',
    storageBucket: 'clone-25d77.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD2M2pQKOYbBeso_6uHirJOpF0TJFpzYCE',
    appId: '1:1032893027793:ios:a8eea5b3137e276e393cf0',
    messagingSenderId: '1032893027793',
    projectId: 'clone-25d77',
    storageBucket: 'clone-25d77.appspot.com',
    iosClientId: '1032893027793-6b5s4k6gvj6pdesrrqlph009q34lmje9.apps.googleusercontent.com',
    iosBundleId: 'com.example.youtubeClone',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD2M2pQKOYbBeso_6uHirJOpF0TJFpzYCE',
    appId: '1:1032893027793:ios:a51e314a453ad914393cf0',
    messagingSenderId: '1032893027793',
    projectId: 'clone-25d77',
    storageBucket: 'clone-25d77.appspot.com',
    iosClientId: '1032893027793-5t1cm05mua1vrrprbk7qhdsq2auavtn7.apps.googleusercontent.com',
    iosBundleId: 'com.example.youtubeClone.RunnerTests',
  );
}
