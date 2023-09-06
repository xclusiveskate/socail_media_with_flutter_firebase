import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController bio = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextField(
            controller: fName,
            decoration: InputDecoration(
              hintText: "First Name",
            ),
          ),
          TextField(
            controller: lName,
            decoration: InputDecoration(
              hintText: "Last Name",
            ),
          ),
          TextField(
            controller: phone,
            decoration: InputDecoration(
              hintText: "phone number",
            ),
          ),
          TextField(
            controller: bio,
            decoration: InputDecoration(
              hintText: "bio",
            ),
          ),
        ],
      ),
    );
  }
}
