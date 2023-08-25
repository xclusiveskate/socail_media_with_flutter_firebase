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
    apiKey: 'AIzaSyDQarkl2wJMi7oOfJH8xhFzMoJ8zwsSBmA',
    appId: '1:725456257727:web:d01592916df52138c23c0a',
    messagingSenderId: '725456257727',
    projectId: 'tete-a-tete-3741a',
    authDomain: 'tete-a-tete-3741a.firebaseapp.com',
    storageBucket: 'tete-a-tete-3741a.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC_ZmD81XNCwPmi6Ug9a9KTWabPR8w3l7o',
    appId: '1:725456257727:android:8674c30cc76a30d3c23c0a',
    messagingSenderId: '725456257727',
    projectId: 'tete-a-tete-3741a',
    storageBucket: 'tete-a-tete-3741a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAzMqVOMqXRgV8BnQy0W-RiDjHZex73OiI',
    appId: '1:725456257727:ios:fe0637858e637f93c23c0a',
    messagingSenderId: '725456257727',
    projectId: 'tete-a-tete-3741a',
    storageBucket: 'tete-a-tete-3741a.appspot.com',
    androidClientId: '725456257727-cl36689n6mcuutj0r45feld1acngoj3g.apps.googleusercontent.com',
    iosClientId: '725456257727-uen5mvmfspqpaees4esl27qrmgqlv3rt.apps.googleusercontent.com',
    iosBundleId: 'com.example.newTete',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAzMqVOMqXRgV8BnQy0W-RiDjHZex73OiI',
    appId: '1:725456257727:ios:4829642d72c2ff64c23c0a',
    messagingSenderId: '725456257727',
    projectId: 'tete-a-tete-3741a',
    storageBucket: 'tete-a-tete-3741a.appspot.com',
    androidClientId: '725456257727-cl36689n6mcuutj0r45feld1acngoj3g.apps.googleusercontent.com',
    iosClientId: '725456257727-7s86sa8q4v77d6lu7qgpcakutinj0ihp.apps.googleusercontent.com',
    iosBundleId: 'com.example.newTete.RunnerTests',
  );
}