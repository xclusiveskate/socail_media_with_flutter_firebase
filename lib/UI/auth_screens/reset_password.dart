import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:new_tete/UI/util/utils.dart';
import 'package:new_tete/controllers/auth.dart';


class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController resetPassControl = TextEditingController();

  resetPassword() async {
    if (resetPassControl.text.isNotEmpty) {
      await AuthMethods().resetPassword(email: resetPassControl.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_left,
              size: 50,
              color: Colors.greenAccent,
            )),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: resetPassControl,
            textInputAction: TextInputAction.done,
            textAlignVertical: TextAlignVertical.center,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Enter your account email',
            ),
          ),
          const Gap(20),
          myButton(
              context: context,
              color: Colors.greenAccent,
              text: "Reset Password",
              textColor: Colors.white,
              onPressed: resetPassword)
        ],
      ),
    );
  }
}
