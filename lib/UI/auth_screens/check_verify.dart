import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_tete/UI/bottom/bottom.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool isVerified = false;
  bool canSend = false;
  Timer? time;

  @override
  void initState() {
    // print('ssssss');
    final verifyState = FirebaseAuth.instance.currentUser!.emailVerified;
    setState(() {
      isVerified = verifyState;
    });
    if (!verifyState) {
      sendEmail();
      time = Timer.periodic(const Duration(seconds: 10), (timer) {
        // print('timer');
        checkIfUserIsVerified(timer);
      });
    }

    super.initState();
  }

  // final currentUser = FirebaseAuth.instance.currentUser!;

  checkIfUserIsVerified(Timer t) async {
    await FirebaseAuth.instance.currentUser!.reload();
    final verifyState = FirebaseAuth.instance.currentUser!.emailVerified;

    if (verifyState) {
      t.cancel();
      setState(() {
        isVerified = verifyState;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    // time!.cancel();
  }

  sendEmail() async {
    setState(() {
      canSend = false;
    });
    await FirebaseAuth.instance.currentUser!.sendEmailVerification();
    await Future.delayed(const Duration(minutes: 1));
    setState(() {
      canSend = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('verify page');
    print(isVerified);
    return isVerified
        ? const BottomNav()
        : Scaffold(
            appBar: AppBar(
              title: const Text(
                  "An email verification link has been sent to your email, Kindly verify to continue enjoying the features"),
              actions: [
                TextButton(onPressed: () {}, child: const Text("Go back")),
                TextButton(onPressed: () {}, child: const Text("Log out")),
              ],
            ),
            body: Column(
              children: [
                Center(
                  child: ElevatedButton(
                      onPressed: canSend ? sendEmail : null,
                      child: const Text("Resend Email")),
                )
              ],
            ),
          );
  }
}
