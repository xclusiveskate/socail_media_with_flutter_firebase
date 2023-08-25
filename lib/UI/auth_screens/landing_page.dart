import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_tete/UI/auth_screens/sign_in.dart';
import 'package:new_tete/UI/auth_screens/sign_up.dart';
import 'package:new_tete/UI/util/utils.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width / 3,
              child: Image.asset("asset/images/tete.png"),
            ),
          ),
          const Gap(10),
          Text(
            "Welcome to the Social world",
            style: GoogleFonts.lato(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const Gap(10),
          Text(
            textAlign: TextAlign.center,
            "Connect with people around the world tète-a-tète",
            style: GoogleFonts.abel(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Gap(10),
          myButton(
              context: context,
              color: Colors.greenAccent,
              text: 'Log in',
              textColor: Colors.white,
              onPressed: () {
                push(context, const SignIn());
              }),
          const Gap(10),
          myButton(
              context: context,
              color: Colors.transparent,
              text: 'Sign up',
              textColor: Colors.greenAccent,
              onPressed: () {
                push(context, const SignUp());
              }),
        ],
      ),
    );
  }
}
