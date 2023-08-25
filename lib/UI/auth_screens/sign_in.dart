// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_tete/UI/auth_screens/reset_password.dart';
import 'package:new_tete/UI/auth_screens/sign_up.dart';
import 'package:new_tete/UI/util/utils.dart';
import 'package:new_tete/controllers/auth.dart';
import 'package:overlay_support/overlay_support.dart';


class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailControl = TextEditingController();
  TextEditingController passControl = TextEditingController();

  signIn() async {
    if (emailControl.text.isNotEmpty && passControl.text.isNotEmpty) {
      await AuthMethods().signInWithEmail(
          context: context,
          email: emailControl.text,
          password: passControl.text);
      setState(() {});
    } else {
      if (emailControl.text.isEmpty && passControl.text.isEmpty) {
        toast("Fields are empty");
      } else if (emailControl.text.isEmpty) {
        toast(" Email field is empty");
      } else {
        toast(" password field is empty");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Gap(70),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      push(context, const SignUp());
                    },
                    child: const Text("Don't have an account yet? Sign Up>")),
              ),
              const Gap(5),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Sign In",
                  style: GoogleFonts.abel(
                      color: Colors.green,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Gap(20),
              signInFields(
                  context: context,
                  controller: emailControl,
                  hintText: "Enter email",
                  action: TextInputAction.next,
                  obscureText: false,
                  validator: (value) {
                    return null;
                  },
                  suffixIcon: const Text("")),
              const Gap(20),
              signInFields(
                  context: context,
                  controller: passControl,
                  hintText: "Enter password",
                  action: TextInputAction.go,
                  obscureText: obscure,
                  validator: (value) {
                    return null;
                  },
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscure = !obscure;
                        });
                      },
                      icon: obscure
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off))),
              // const Gap(10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    push(context, const ResetPassword());
                  },
                  child: const Text("Forgot Password??"),
                ),
              ),
              const Gap(10),
              myButton(
                  context: context,
                  color: Colors.greenAccent,
                  text: "Sign In",
                  textColor: Colors.white,
                  onPressed: () {
                    signIn();
                    print("I am signing in");
                  }),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 150,
                      child: Divider(
                        thickness: 1,
                        color: Colors.green,
                        endIndent: 2.0,
                      ),
                    ),
                    Text("OR"),
                    SizedBox(
                        width: 150,
                        child: Divider(
                          thickness: 1,
                          color: Colors.green,
                          endIndent: 2.0,
                        ))
                  ],
                ),
              ),
              const Gap(30),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    mySignOptions(
                        context: context,
                        image: 'asset/images/apple.png',
                        onTap: () {}),
                    mySignOptions(
                        context: context,
                        image: 'asset/images/Facebook.png',
                        onTap: () {}),
                    mySignOptions(
                        context: context,
                        image: 'asset/images/google.png',
                        onTap: () {}),
                    mySignOptions(
                        context: context,
                        image: 'asset/images/phone.png',
                        onTap: () {})
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
