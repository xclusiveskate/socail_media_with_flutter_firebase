import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_tete/Modell/post_model.dart';
import 'package:new_tete/Modell/user_model.dart';
import 'package:new_tete/UI/bottom/home/add_comment.dart';
import 'package:new_tete/UI/bottom/home/profile.dart';
import 'package:new_tete/UI/util/utils.dart';
import 'package:new_tete/controllers/service.dart';
import 'package:readmore/readmore.dart';

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
  String formatDate(DateTime date) {
    var now = DateTime.now();
    final today = DateTime(
      now.year,
      now.month,
      now.day,
    );
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    if (date.isAfter(today)) {
      return DateFormat.jm().format(date);
    } else if (date.isAfter(yesterday)) {
      return ' yesterday';
    } else {
      return DateFormat.yMMMMd().format(date);
    }
  }

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
        physics: BouncingScrollPhysics(),
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
                  child: Text(formatDate(widget.post.datePublished))),
              const SizedBox(
                height: 3,
              ),
              divider(),
              StreamBuilder<DocumentSnapshot>(
                  stream: commentStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
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
                                      content: Container(
                                        child: Column(
                                          children: data.likes!
                                              .map((e) => ListTile(
                                                    title: Text(e),
                                                  ))
                                              .toList(),
                                        ),
                                      ),
                                      header: "People that liked",
                                      complete: () => null,
                                      context: context);
                                },
                                child: Text('${data.likes!.length} Likes')),
                          ],
                        ),
                        // divider(),
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
                              final commentor = users.firstWhere(
                                  (element) => element.id == comment.userId);
                              return Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                          color: Color.fromARGB(
                                              255, 201, 201, 201),
                                          width: 0.5,
                                        ),
                                        bottom: BorderSide(
                                          color: Color.fromARGB(
                                              255, 193, 193, 193),
                                          width: 0.5,
                                        ))),
                                child: ListTile(
                                  leading: InkWell(
                                    onTap: () {
                                      push(context, MyProfile(user: commentor));
                                    },
                                    child: widget.user.profileImageUrl == null
                                        ? CircleAvatar(
                                            backgroundColor: Colors.greenAccent,
                                            child: Image.asset(
                                              'asset/images/avatar.jpg',
                                              fit: BoxFit.cover,
                                            ))
                                        : CircleAvatar(
                                            backgroundColor: Colors.greenAccent,
                                            backgroundImage: NetworkImage(
                                                commentor.profileImageUrl!),
                                          ),
                                  ),
                                  title: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text('${commentor.firstName}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                            '@${commentor.userName!}',
                                            style: const TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey),
                                          ),
                                          const Text(
                                            "11 Oct",
                                            style: TextStyle(fontSize: 13),
                                          ),
                                          // IconButton(
                                          //     onPressed: () async {},
                                          //     icon: const Icon(Icons.more_vert))
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          comment.comment,
                                          // textAlign: TextAlign.left,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Container(
                                          //   child: Row(
                                          //     mainAxisAlignment:
                                          //         MainAxisAlignment.start,
                                          //     children: [
                                          //       IconButton(
                                          //           onPressed: () {},
                                          //           icon: const Icon(
                                          //               Icons.comment)),
                                          //       Text(
                                          //           '${data.comments.length.toString()} ')
                                          //     ],
                                          //   ),
                                          // ),
                                          // Container(
                                          //   child: Row(
                                          //     children: [
                                          //       IconButton(
                                          //           onPressed: () {
                                          //             ServiceCall.likePost(
                                          //                 userId:
                                          //                     widget.user.id!,
                                          //                 postId:
                                          //                     widget.post.uid!,
                                          //                 currentUserLike:
                                          //                     hasTheCurrentUserLiked);
                                          //           },
                                          //           icon: hasTheCurrentUserLiked
                                          //               ? const Icon(Icons
                                          //                   .favorite_rounded)
                                          //               : const Icon(Icons
                                          //                   .favorite_outline)),
                                          //       Text(data.likes!.length
                                          //           .toString())
                                          //     ],
                                          //   ),
                                          // ),
                                        ],
                                      )
                                    ],
                                  ),
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
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Row(
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
                        ServiceCall.addComment(
                            widget.post, commentController, widget.currentUser);
                        setState(() {
                          commentController.clear();
                        });
                      },
                      child: const Text("Reply"))),
            ],
          ),
        )
      ],
    );
  }
}
