import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_tete/Modell/post_model.dart';
import 'package:new_tete/Modell/user_model.dart';
import 'package:new_tete/UI/bottom/home/add_post.dart';
import 'package:new_tete/UI/bottom/home/drawer.dart';
import 'package:new_tete/UI/util/utils.dart';
import 'package:new_tete/widgets/post_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  getUsers() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference<Map<String, dynamic>> collectionReference =
        firestore.collection('users');
    await collectionReference.get().then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        final user = doc;
        setState(() {
          users.add(UserModel.fromFirestore(user));
        });
      }
    }).catchError((error) {
      print('Error getting documents: $error');
    });
  }

  @override
  void initState() {
    getUsers();
    currentUserId = user!.uid;
    super.initState();
  }

  Stream<QuerySnapshot> postStream =
      FirebaseFirestore.instance.collection('posts').snapshots();

  User? user = FirebaseAuth.instance.currentUser;
  String? currentUserId;

  int initialValue = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Icon(Icons.logo_dev),
        centerTitle: true,
        elevation: 0,
        actions: [
          // isSearching
          //     ? SizedBox(
          //         width: MediaQuery.of(context).size.width / 1.5,
          //         child: const TextField())
          //     : const SizedBox.shrink(),
          // IconButton(
          //     onPressed: () {
          //       setState(() {
          //         isSearching = !isSearching;
          //       });
          //     },
          // icon: const Icon(Icons.search)),
          // IconButton(onPressed: () {}, icon: const Icon(Icons.star_rate))

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: PopupMenuButton(
                initialValue: initialValue,
                onSelected: (value) {
                  print(value);
                  setState(() {
                    initialValue = value;
                  });
                },
                child: Row(
                  children: [
                    initialValue == 3
                        ? const Icon(Icons.star)
                        : const Icon(Icons.star_border_outlined),
                    const Text("mode")
                  ],
                ),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                        onTap: () {},
                        value: 1,
                        child: const Text("System Mode")),
                    PopupMenuItem(
                        onTap: () {},
                        value: 2,
                        child: const Text("Light Mode")),
                    PopupMenuItem(
                        onTap: () {}, value: 3, child: const Text("Dark Mode")),
                  ];
                }),
          )
        ],
      ),
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: postStream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text('Unable to load data'));
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                            heightFactor: 25,
                            child: Text(
                                '.....................................loading')),
                      ],
                    );
                  } else {
                    final List<QueryDocumentSnapshot> gottenPosts =
                        snapshot.data.docs;
                    List<PostModel> posts = gottenPosts
                        .map((document) => PostModel.fromFirestore(document))
                        .toList();
                    // List<PostModel> myModel = posts.map((e) => ).toList();
                    return PostWidget(
                        posts: posts,
                        gottenPosts: gottenPosts,
                        currentUserId: currentUserId);
                  }
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal.shade100,
        onPressed: () {
          push(context, const AddPosts());
        },
        child: const Icon(Icons.add),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // extendBody: true,
    );
  }
}
