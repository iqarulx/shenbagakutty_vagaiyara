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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyAkyYOKnBnwmrL-VTPgsa_Tr3Kcs_KWiD0',
    appId: '1:122159476644:web:e072d2eb22087f9180db31',
    messagingSenderId: '122159476644',
    projectId: 'shenbaga-temple',
    authDomain: 'shenbaga-temple.firebaseapp.com',
    databaseURL: 'https://shenbaga-temple-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'shenbaga-temple.firebasestorage.app',
    measurementId: 'G-74J3BK7LCX',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC8CZCqk7Q9B9vSTur-rTMiN6gRxnE0FbU',
    appId: '1:122159476644:ios:82a10e597bf0151780db31',
    messagingSenderId: '122159476644',
    projectId: 'shenbaga-temple',
    storageBucket: 'shenbaga-temple.appspot.com',
    iosBundleId: 'com.srisoftwarez.shenbagakuttyVagaiyara',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAyCwUIwvOZsX88RQIl6splz5slaB-T4l0',
    appId: '1:122159476644:web:15b7fdcbe2d29dd080db31',
    messagingSenderId: '122159476644',
    projectId: 'shenbaga-temple',
    authDomain: 'shenbaga-temple.firebaseapp.com',
    storageBucket: 'shenbaga-temple.appspot.com',
    measurementId: 'G-KW4BLBX7ED',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC8CZCqk7Q9B9vSTur-rTMiN6gRxnE0FbU',
    appId: '1:122159476644:ios:f7d457a725604f4d80db31',
    messagingSenderId: '122159476644',
    projectId: 'shenbaga-temple',
    databaseURL: 'https://shenbaga-temple-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'shenbaga-temple.firebasestorage.app',
    iosBundleId: 'com.srisoftwarez.shenbagakuttyVagaiyara',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAYs6S7wuBrg6_lvzZrkoG_jHhtcGA3_9w',
    appId: '1:122159476644:android:1d82cb478fc6924c80db31',
    messagingSenderId: '122159476644',
    projectId: 'shenbaga-temple',
    databaseURL: 'https://shenbaga-temple-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'shenbaga-temple.firebasestorage.app',
  );

}