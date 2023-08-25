import 'package:flutter/material.dart';
import 'package:side_sheet_material3/side_sheet_material3.dart';

// Uint8List? myImage;
OutlinedButton myButton(
    {required BuildContext context,
    required Color color,
    required String text,
    required Color textColor,
    required VoidCallback onPressed}) {
  return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: color,
        minimumSize: Size(MediaQuery.of(context).size.width / 1.4, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: 20),
      ));
}

Widget mySignOptions(
    {required BuildContext context,
    required String image,
    required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    child: SizedBox(
      width: 50,
      height: 50,
      child: Image.asset(image),
    ),
  );
}

signInFields(
    {required BuildContext context,
    required TextEditingController controller,
    required String hintText,
    required TextInputAction action,
    required bool obscureText,
    required Widget suffixIcon,
    required String? Function(String?)? validator}) {
  return SizedBox(
    height: 60,
    child: TextFormField(
      textInputAction: action,
      validator: validator,
      textAlignVertical: TextAlignVertical.center,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          hintText: hintText,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: const BorderSide(color: Colors.green, width: 2.0)),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.greenAccent),
            borderRadius: BorderRadius.circular(25.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.lightGreen),
            borderRadius: BorderRadius.circular(25.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(25.0),
          ),
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(40))),
    ),
  );
}

pushReplacement(BuildContext context, Widget destination) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => destination));
}

push(BuildContext context, Widget destination) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => destination));
}

pushAndRemoveUntil(BuildContext context, Widget destination, bool predict) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => destination),
      (Route<dynamic> route) => predict);
}

showSnackBar({required BuildContext context, required String message}) {
  return ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(message)));
}

bool obscure = true;
bool isSearching = false;

Divider divider() {
  return Divider(
    height: 1,
    color: Colors.green.withOpacity(0.5),
    endIndent: 0,
    indent: 0,
  );
}

sideSheet(
    {required BuildContext context,
    required Widget content,
    required String header,
    required VoidCallback complete}) async {
  await showModalSideSheet(
    context,
    header: header,
    body: content, // Put your content widget here
    addBackIconButton: true,
    addActions: true,
    addDivider: true,
    confirmActionTitle: 'Save',
    cancelActionTitle: 'Cancel',
    confirmActionOnPressed: complete,

    // If null, Navigator.pop(context) will used
    cancelActionOnPressed: () {
      Navigator.pop(context);
    },
  );
}
