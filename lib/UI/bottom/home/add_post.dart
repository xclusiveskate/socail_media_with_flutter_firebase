import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_tete/controllers/service.dart';


class AddPosts extends StatefulWidget {
  const AddPosts({super.key});

  @override
  State<AddPosts> createState() => _AddPostsState();
}

class _AddPostsState extends State<AddPosts> {
  TextEditingController content = TextEditingController();

  User? user = FirebaseAuth.instance.currentUser;
  String userId = '';
  createPost() async {
    if (content.text.isNotEmpty) {
      await ServiceCall.createPost(
          content: content.text, datePublished: DateTime.now(), userId: userId);
      content.clear();
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    userId = user!.uid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.cancel_outlined)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  createPost();
                },
                child: const Text("Tweet")),
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            TextField(
              controller: content,
              maxLength: null,
              maxLines: null,
              minLines: null,
              decoration: const InputDecoration(
                  hintText: 'Text',
                  border: OutlineInputBorder(borderSide: BorderSide.none)),
            ),
          ],
        ),
      ),
    );
  }
}
