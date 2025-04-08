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
    apiKey: 'AIzaSyDHHjezlAA_WIf7DNPrYZU5Uq19HDm2ywA',
    appId: '1:511305469466:web:f18f8ef42fd127b6d08ba3',
    messagingSenderId: '511305469466',
    projectId: 'crud-9906a',
    authDomain: 'crud-9906a.firebaseapp.com',
    storageBucket: 'crud-9906a.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAVGIe4Z5H55OXeRPPoKONU5_PIQZF3mhU',
    appId: '1:511305469466:android:db540333e5d27c59d08ba3',
    messagingSenderId: '511305469466',
    projectId: 'crud-9906a',
    storageBucket: 'crud-9906a.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB2wGagY81f-55mkm9FOcWUwSkQLuKG97A',
    appId: '1:511305469466:ios:94f970abe3837734d08ba3',
    messagingSenderId: '511305469466',
    projectId: 'crud-9906a',
    storageBucket: 'crud-9906a.firebasestorage.app',
    iosBundleId: 'com.example.crud',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB2wGagY81f-55mkm9FOcWUwSkQLuKG97A',
    appId: '1:511305469466:ios:94f970abe3837734d08ba3',
    messagingSenderId: '511305469466',
    projectId: 'crud-9906a',
    storageBucket: 'crud-9906a.firebasestorage.app',
    iosBundleId: 'com.example.crud',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDHHjezlAA_WIf7DNPrYZU5Uq19HDm2ywA',
    appId: '1:511305469466:web:bd7659f402322876d08ba3',
    messagingSenderId: '511305469466',
    projectId: 'crud-9906a',
    authDomain: 'crud-9906a.firebaseapp.com',
    storageBucket: 'crud-9906a.firebasestorage.app',
  );
}
