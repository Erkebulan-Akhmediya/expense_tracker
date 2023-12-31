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
    apiKey: 'AIzaSyDeA5QNp2mKSH4V7NiMvAYVOuBSio-bR6w',
    appId: '1:910797157772:web:ddb782f29c922924e3d2a9',
    messagingSenderId: '910797157772',
    projectId: 'expense-tracker-a28da',
    authDomain: 'expense-tracker-a28da.firebaseapp.com',
    storageBucket: 'expense-tracker-a28da.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCRK3N5z0JoXg1AK9CnwUGB7XyZiVG0QhA',
    appId: '1:910797157772:android:9043ce116e5e9237e3d2a9',
    messagingSenderId: '910797157772',
    projectId: 'expense-tracker-a28da',
    storageBucket: 'expense-tracker-a28da.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDPp3Yq1QXbGypXyv27lZUNfDizb2rk1gk',
    appId: '1:910797157772:ios:a4c0efdd046765dde3d2a9',
    messagingSenderId: '910797157772',
    projectId: 'expense-tracker-a28da',
    storageBucket: 'expense-tracker-a28da.appspot.com',
    iosClientId: '910797157772-5isq3ns44ubnufgcu10jns6r026k6f3u.apps.googleusercontent.com',
    iosBundleId: 'com.example.expenseTracker',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDPp3Yq1QXbGypXyv27lZUNfDizb2rk1gk',
    appId: '1:910797157772:ios:2378ce0b4bc52d01e3d2a9',
    messagingSenderId: '910797157772',
    projectId: 'expense-tracker-a28da',
    storageBucket: 'expense-tracker-a28da.appspot.com',
    iosClientId: '910797157772-qbv8kl5r1kb5v83vj8surli5evmv29uo.apps.googleusercontent.com',
    iosBundleId: 'com.example.expenseTracker.RunnerTests',
  );
}
