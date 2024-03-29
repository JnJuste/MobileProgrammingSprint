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
    apiKey: 'AIzaSyBRR8whUESccEULFJN4S0Navs3JkAfXMCc',
    appId: '1:876369163352:web:43ee475e1695ef1c12462d',
    messagingSenderId: '876369163352',
    projectId: 'navigationbar-1f81e',
    authDomain: 'navigationbar-1f81e.firebaseapp.com',
    storageBucket: 'navigationbar-1f81e.appspot.com',
    measurementId: 'G-4E4GY3C5J3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAF8BJV8N8ppFyyXoiGz6VLnmec1h_jb1I',
    appId: '1:876369163352:android:f5f4563f6ba7ac2212462d',
    messagingSenderId: '876369163352',
    projectId: 'navigationbar-1f81e',
    storageBucket: 'navigationbar-1f81e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDYcXg0zfUy2Nr3WWsUYj8ihd5zjL_gU_Q',
    appId: '1:876369163352:ios:9ca2c0f178ceabcf12462d',
    messagingSenderId: '876369163352',
    projectId: 'navigationbar-1f81e',
    storageBucket: 'navigationbar-1f81e.appspot.com',
    iosBundleId: 'com.example.navigationBar',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDYcXg0zfUy2Nr3WWsUYj8ihd5zjL_gU_Q',
    appId: '1:876369163352:ios:f7cf5762065f9a4012462d',
    messagingSenderId: '876369163352',
    projectId: 'navigationbar-1f81e',
    storageBucket: 'navigationbar-1f81e.appspot.com',
    iosBundleId: 'com.example.navigationBar.RunnerTests',
  );
}
