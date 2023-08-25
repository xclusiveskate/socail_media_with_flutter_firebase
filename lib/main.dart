import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_tete/UI/auth_screens/check_verify.dart';
import 'package:new_tete/UI/auth_screens/sign_in.dart';
import 'package:new_tete/firebase_options.dart';

import 'package:overlay_support/overlay_support.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());

  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      toastTheme: ToastThemeData(
          alignment: Alignment.center,
          background: Colors.greenAccent,
          textColor: Colors.black),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  print('now user available');
                  return const VerifyEmail();
                }
              }

              return const SignIn();
            }),
      ),
    );
  }
}
