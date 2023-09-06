import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:new_tete/Modell/user_model.dart';
import 'package:new_tete/UI/bottom/home/edit_profile.dart';
import 'package:new_tete/UI/util/utils.dart';
import 'package:new_tete/controllers/service.dart';

class MyProfile extends StatefulWidget {
  final UserModel user;

  const MyProfile({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  String currentUser = FirebaseAuth.instance.currentUser!.uid;
  bool isCurrentUser = false;
  @override
  void initState() {
    super.initState();
    isCurrentUser = widget.user.id == currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade100,
        elevation: 0.0,
        leading: Container(
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(50)),
          width: 20,
          height: 20,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(100)),
            width: 40,
            height: 40,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
          ),
          Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(100)),
              width: 40,
              height: 40,
              child: PopupMenuButton(
                padding: const EdgeInsets.all(0),
                elevation: 10,
                splashRadius: 5.0,
                enableFeedback: true,
                position: PopupMenuPosition.over,
                shape: const Border(
                    left: BorderSide(
                        color: Colors.green, width: 1.0, strokeAlign: 0.5),
                    bottom: BorderSide(
                        color: Colors.green, width: 1.0, strokeAlign: 0.5)),
                onCanceled: () {},
                onSelected: (value) {
                  print(value);
                },
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem(value: 1, child: Text("Share")),
                    const PopupMenuItem(value: 2, child: Text("Drafts")),
                    const PopupMenuItem(
                        value: 3, child: Text("Lists you're on")),
                    const PopupMenuItem(value: 4, child: Text("View Moments")),
                    const PopupMenuItem(value: 5, child: Text("QR code")),
                  ];
                },
                icon: const Icon(Icons.more_vert),
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.teal.shade100,
                      ),
                      height: 100,
                      width: double.infinity,
                      child: const Text(""),
                    ),
                    Positioned(
                      left: 20,
                      top: 60,
                      child: GestureDetector(
                        onTap: () {
                          print("This is profile image");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      widget.user.profileImageUrl!)),
                              color: Colors.teal.shade200,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                  style: BorderStyle.solid,
                                  color:
                                      const Color.fromARGB(255, 241, 237, 237),
                                  width: 3.0)),
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(6.0),
                  alignment: Alignment.centerRight,
                  child: OutlinedButton(
                      onPressed: isCurrentUser == true
                          ? push(context, EditProfilePage())
                          : ServiceCall.followUser(widget.user, currentUser),
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)))),
                      child: Text(
                        isCurrentUser == true ? "Edit profile" : "Follow",
                        style: TextStyle(color: Colors.black),
                      )),
                ),
                Container(
                  child: ListTile(
                    title: Text(
                      "${widget.user.firstName! + " " + widget.user.lastName!}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("@${widget.user.userName!}"),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_month,
                              size: 15.0,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text("Joined June 2019")
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              Text(
                                "${widget.user.followers!.length.toString()}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text("Following"),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                  "${widget.user.followers!.length.toString()}",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text("Followers"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // const BodyTabPage(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
