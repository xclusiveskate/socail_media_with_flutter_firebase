import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_tete/Modell/post_model.dart';
import 'package:new_tete/Modell/user_model.dart';
import 'package:new_tete/UI/bottom/home/add_comment.dart';
import 'package:new_tete/UI/util/utils.dart';
import 'package:new_tete/controllers/service.dart';
import 'package:readmore/readmore.dart';

import 'package:uuid/uuid.dart';

class PostView extends StatefulWidget {
  final PostModel post;
  final UserModel user;
  final bool isLiked;
  final String docRef;
  final String currentUser;
  const PostView(
      {super.key,
      required this.post,
      required this.user,
      required this.isLiked,
      required this.docRef,
      required this.currentUser});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Stream<DocumentSnapshot> commentStream = FirebaseFirestore.instance
        .collection('posts')
        .doc(widget.post.uid)
        .snapshots();
    return Scaffold(
      appBar: AppBar(
          // title: Text(widget.user.userName.toString()),
          ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.blue,
                      backgroundImage:
                          NetworkImage(widget.user.profileImageUrl!),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          textAlign: TextAlign.left,
                          '${widget.user.lastName!} ${widget.user.firstName!}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                            textAlign: TextAlign.left,
                            '@${widget.user.userName}')
                      ],
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: ReadMoreText(
                  widget.post.content,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontSize: 16),
                  callback: (val) {
                    print(val);
                  },
                  trimLines: 6,
                  colorClickableText: Colors.pink,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Read more',
                  trimExpandedText: '   Show less',
                  moreStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.blue),
                  lessStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.blue),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Date: ${widget.post.datePublished.toString()}')),
              const SizedBox(
                height: 3,
              ),
              divider(),
              StreamBuilder<DocumentSnapshot>(
                  stream: commentStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("");
                    } else if (snapshot.hasError) {
                      return const Center(child: Text("Error Loading comment"));
                    }
                    final data = PostModel.fromFirestore(snapshot.data!);
                    final hasTheCurrentUserLiked =
                        (data.likes as List).contains(widget.currentUser);
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                                onPressed: () {},
                                child:
                                    Text('${data.comments.length} Comments')),
                            TextButton(
                                onPressed: () {
                                  sideSheet(
                                      content: Container(),
                                      header: "People that liked",
                                      complete: () => null,
                                      context: context);
                                },
                                child: Text('${data.likes!.length} Likes')),
                          ],
                        ),
                        divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                                onPressed: () {
                                  push(context, AddComment());
                                },
                                icon: const Icon(
                                  Icons.comment,
                                  color: Colors.lightGreenAccent,
                                )),
                            IconButton(
                                onPressed: () {
                                  ServiceCall.likePost(
                                      userId: widget.currentUser,
                                      postId: data.uid!,
                                      currentUserLike: hasTheCurrentUserLiked);
                                  setState(() {});
                                },
                                icon: hasTheCurrentUserLiked == true
                                    ? const Icon(
                                        Icons.favorite,
                                        color: Colors.lightGreenAccent,
                                      )
                                    : const Icon(
                                        Icons.favorite_border_outlined)),
                            IconButton(
                                onPressed: () async {
                                  await showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Container();
                                      });
                                },
                                icon: const Icon(
                                  Icons.share,
                                  color: Colors.lightGreenAccent,
                                )),
                          ],
                        ),
                        divider(),
                        ListView.builder(
                            itemCount: data.comments.length,
                            primary: false,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final comment = data.comments[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Text(comment.comment),
                                ),
                              );
                            }),
                      ],
                    );
                  })
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
                flex: 3,
                child: TextField(
                  decoration: const InputDecoration(
                      hintText: "Comment on the above post"),
                  controller: commentController,
                )),
            Expanded(
                flex: 1,
                child: OutlinedButton(
                    onPressed: () {
                      if (commentController.text.isNotEmpty) {
                        try {
                          final uid = const Uuid().v1();
                          FirebaseFirestore.instance
                              .collection('posts')
                              .doc(widget.post.uid)
                              .update({
                            "comments": FieldValue.arrayUnion([
                              {
                                "commentId": uid,
                                "comment": commentController.text,
                                "userId": widget.currentUser,
                                // "likes": null
                              }
                            ])
                          });
                          setState(() {
                            commentController.clear();
                          });
                        } catch (e) {
                          print(e);
                        }
                      }
                    },
                    child: const Text("Reply"))),
          ],
        )
      ],
    );
  }
}
