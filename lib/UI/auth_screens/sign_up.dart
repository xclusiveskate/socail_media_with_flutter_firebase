// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_tete/UI/auth_screens/sign_in.dart';
import 'package:new_tete/UI/util/helpers.dart';
import 'package:new_tete/UI/util/utils.dart';
import 'package:new_tete/controllers/auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController firstNameControl = TextEditingController();
  TextEditingController lastNameControl = TextEditingController();
  TextEditingController userNameControl = TextEditingController();
  TextEditingController phoneNumberControl = TextEditingController();
  TextEditingController emailControl = TextEditingController();
  TextEditingController passControl = TextEditingController();
  TextEditingController confirmPassControl = TextEditingController();
  var myImage = '';
  grabUserImage() async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      myImage = file.path;
      print(myImage);
      setState(() {});
    }
  }

  User? user = FirebaseAuth.instance.currentUser;

  signUp() async {
    // AuthMethods().SaveUserImage(file: myImage!, userId: userId);
    var imageUrl = await AuthMethods().saveUserImageToCloud(img: myImage);
    await AuthMethods().signUpWithEmail(
        context: context,
        userEmail: emailControl.text,
        password: passControl.text,
        lastName: lastNameControl.text,
        firstName: firstNameControl.text,
        username: userNameControl.text,
        profileImageUrl: imageUrl,
        phoneNumber: phoneNumberControl.text);
    // String userId = user!.uid;
  }

  final formState = GlobalKey<FormState>();

  @override
  void dispose() {
    firstNameControl.dispose();
    lastNameControl.dispose();
    userNameControl.dispose();
    phoneNumberControl.dispose();
    emailControl.dispose();
    passControl.dispose();
    confirmPassControl.dispose();
    super.dispose();
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
          child: Form(
            key: formState,
            child: Column(
              children: [
                const Gap(60),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Create new account",
                    style: GoogleFonts.abel(
                        color: Colors.green,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Gap(10),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    myImage.isEmpty
                        ? const CircleAvatar(
                            backgroundColor: Colors.greenAccent,
                            backgroundImage:
                                AssetImage('asset/images/avatar1.png'),
                            radius: 40,
                          )
                        : CircleAvatar(
                            backgroundColor: Colors.green,
                            backgroundImage: FileImage(File(myImage)),
                            radius: 40,
                          ),
                    Positioned(
                        left: 50,
                        top: 48,
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: FloatingActionButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              onPressed: () {
                                grabUserImage();
                              },
                              mini: true,
                              child: const Icon(
                                Icons.photo_camera,
                                size: 18,
                              )),
                        ))
                  ],
                ),
                const Gap(10),
                signInFields(
                    context: context,
                    controller: firstNameControl,
                    hintText: "First Name",
                    action: TextInputAction.next,
                    obscureText: false,
                    validator: validateFirstName,
                    suffixIcon: const Text("")),
                const Gap(10),
                signInFields(
                    context: context,
                    controller: lastNameControl,
                    hintText: "Last Name",
                    action: TextInputAction.next,
                    obscureText: false,
                    validator: validateLastName,
                    suffixIcon: const Text("")),
                const Gap(10),
                signInFields(
                    context: context,
                    controller: userNameControl,
                    hintText: "username",
                    action: TextInputAction.next,
                    obscureText: false,
                    validator: (value) {
                      return null;
                    },
                    suffixIcon: const Text("")),
                const Gap(10),
                signInFields(
                    context: context,
                    controller: phoneNumberControl,
                    hintText: "Mobile Number",
                    action: TextInputAction.next,
                    obscureText: false,
                    validator: validateMobile,
                    suffixIcon: const Text("")),
                const Gap(10),
                signInFields(
                    context: context,
                    controller: emailControl,
                    hintText: "Email",
                    action: TextInputAction.next,
                    obscureText: false,
                    validator: (value) {
                      return null;
                    },
                    suffixIcon: const Text("")),
                const Gap(10),
                signInFields(
                    context: context,
                    controller: passControl,
                    hintText: "Password",
                    action: TextInputAction.next,
                    obscureText: obscure,
                    validator: validatePasword,
                    suffixIcon: const Text("")),
                const Gap(10),

                signInFields(
                    context: context,
                    controller: confirmPassControl,
                    hintText: "Confirm password",
                    action: TextInputAction.done,
                    obscureText: obscure,
                    validator: (value) =>
                        validateConfirmPassword(value, passControl.text),
                    suffixIcon: const Text("")),
                // const Gap(10),

                const Gap(10),

                myButton(
                    context: context,
                    color: Colors.greenAccent,
                    text: "Sign Up",
                    textColor: Colors.white,
                    onPressed: () {
                      if (formState.currentState?.validate() == true) {
                        signUp();
                      }
                    }),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {
                        push(context, const SignIn());
                      },
                      child: const Text("Already have an account?? Log in")),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
