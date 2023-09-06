import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_tete/Modell/user_model.dart';
import 'package:new_tete/UI/bottom/home/profile.dart';
import 'package:new_tete/UI/util/utils.dart';
import 'package:new_tete/controllers/auth.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  late final UserModel _user;
  String url = "";
  signOut() async {
    await AuthMethods().signOut();
  }

  @override
  void initState() {
    super.initState();
    getNow();
  }

  String currentUserId = FirebaseAuth.instance.currentUser!.uid;
  getUser() async {
    final inst = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .get();
    final result = UserModel.fromFirestore(inst);
    return result;
  }

  Future<void> getNow() async {
    final user = await getUser();
    setState(() {
      _user = user;
      url = _user.profileImageUrl!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
          width: MediaQuery.of(context).size.width / 1.3,
          child: ListView(
            children: [
              // UserAccountsDrawerHeader(
              //   onDetailsPressed: () {
              //     push(context, const MyProfile());
              //   },
              //   decoration: const BoxDecoration(
              //       // color: Color.fromARGB(255, 245, 246, 235),
              //       ),
              //   currentAccountPicture: const CircleAvatar(
              //     backgroundColor: Colors.greenAccent,
              //     child: Text("user img"),
              //   ),
              //   accountEmail: const Text("mikedasleek2022@gmail.com",
              //       style: TextStyle(color: Colors.black)),
              //   accountName: const Text(
              //     "Mike Francisco",
              //     style: TextStyle(color: Colors.black),
              //   ),
              // ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        push(context, MyProfile(user: _user));
                      },
                      child: SizedBox(
                          width: 100,
                          height: 100,
                          // ignore: unnecessary_null_comparison
                          child: url != null
                              ? CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(_user.profileImageUrl!),
                                )
                              : CircleAvatar(
                                  backgroundColor: Colors.greenAccent,
                                  backgroundImage:
                                      AssetImage('asset/images/avatar1.png'),
                                )),
                    ),
                    const Gap(10),
                    Text(
                      "${_user.firstName}",
                      style: GoogleFonts.abel(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Gap(10),
                    Text(
                      "@${_user.userName}",
                      style: GoogleFonts.abel(
                          fontSize: 18, fontStyle: FontStyle.italic),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 3.5,
                            alignment: Alignment.center,
                            height: 30,
                            decoration: BoxDecoration(
                                color: Colors.greenAccent,
                                borderRadius: BorderRadius.circular(20)),
                            child: RichText(
                                text: TextSpan(
                                    text: _user.following!.length.toString(),
                                    style: GoogleFonts.abel(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: <TextSpan>[
                                  TextSpan(
                                    text: " Following",
                                    style: GoogleFonts.abel(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ])),
                          ),
                          const Gap(10),
                          Container(
                            width: MediaQuery.of(context).size.width / 3.5,
                            alignment: Alignment.center,
                            height: 30,
                            decoration: BoxDecoration(
                                color: Colors.greenAccent,
                                borderRadius: BorderRadius.circular(20)),
                            child: RichText(
                                text: TextSpan(
                                    text: _user.followers!.length.toString(),
                                    style: GoogleFonts.abel(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: <TextSpan>[
                                  TextSpan(
                                    text: " Followers",
                                    style: GoogleFonts.abel(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ])),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                child: Divider(),
              ),
              const Gap(380),
              Center(
                child: ElevatedButton(
                    onPressed: signOut, child: const Text("Sign Out")),
              )
            ],
          )),
    );
  }
}
