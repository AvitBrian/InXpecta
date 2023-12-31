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
    apiKey: 'AIzaSyAGkdm360eJWyEUTpsqK44Es-m63gAa61s',
    appId: '1:443516795908:web:56eb5acd3ec918b0934951',
    messagingSenderId: '443516795908',
    projectId: 'inxpecta-93c53',
    authDomain: 'inxpecta-93c53.firebaseapp.com',
    storageBucket: 'inxpecta-93c53.appspot.com',
    measurementId: 'G-LMX0S0XRNV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBzmpamnLge18I6Sz5wg0nzPVuXV6XwOBI',
    appId: '1:443516795908:android:518898812480faf2934951',
    messagingSenderId: '443516795908',
    projectId: 'inxpecta-93c53',
    storageBucket: 'inxpecta-93c53.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC3I6C-rgWua3jb15xVavuYf9kCMPV5zAU',
    appId: '1:443516795908:ios:48384673ccbc0d9a934951',
    messagingSenderId: '443516795908',
    projectId: 'inxpecta-93c53',
    storageBucket: 'inxpecta-93c53.appspot.com',
    iosBundleId: 'com.example.inxpecta',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC3I6C-rgWua3jb15xVavuYf9kCMPV5zAU',
    appId: '1:443516795908:ios:a81247c39ffa738a934951',
    messagingSenderId: '443516795908',
    projectId: 'inxpecta-93c53',
    storageBucket: 'inxpecta-93c53.appspot.com',
    iosBundleId: 'com.example.inxpecta.RunnerTests',
  );
}
