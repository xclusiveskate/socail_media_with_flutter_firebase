import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_tete/Modell/post_model.dart';
import 'package:new_tete/Modell/user_model.dart';
import 'package:new_tete/UI/bottom/connection/user_profile.dart';
import 'package:new_tete/UI/bottom/home/post_view.dart';
import 'package:new_tete/UI/util/utils.dart';
import 'package:new_tete/controllers/service.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({
    super.key,
    required this.posts,
    required this.gottenPosts,
    required this.currentUserId,
  });

  final List<PostModel> posts;
  final List<QueryDocumentSnapshot<Object?>> gottenPosts;
  final String? currentUserId;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        primary: false,
        shrinkWrap: true,
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final docRef = gottenPosts[index].reference.id;
          final post = posts[index];
          final posterDetails =
              users.firstWhere((element) => element.id == post.userId);

          final hasTheCurrentUserLiked =
              (post.likes as List).contains(currentUserId);

          return InkWell(
            onTap: () {
              push(
                  context,
                  PostView(
                    docRef: docRef,
                    currentUser: currentUserId!,
                    post: post,
                    user: posterDetails,
                    isLiked: hasTheCurrentUserLiked,
                  ));
              print(docRef);
            },
            child: Container(
              decoration: const BoxDecoration(
                  border: Border(
                      top: BorderSide(
                        color: Color.fromARGB(255, 201, 201, 201),
                        width: 0.5,
                      ),
                      bottom: BorderSide(
                        color: Color.fromARGB(255, 193, 193, 193),
                        width: 0.5,
                      ))),
              child: ListTile(
                leading: InkWell(
                  onTap: () {
                    push(context, const UserProfile());
                  },
                  child: posterDetails.profileImageUrl == null
                      ? CircleAvatar(
                          backgroundColor: Colors.greenAccent,
                          child: Image.asset(
                            'asset/images/avatar.jpg',
                            fit: BoxFit.cover,
                          ))
                      : CircleAvatar(
                          backgroundColor: Colors.greenAccent,
                          backgroundImage:
                              NetworkImage(posterDetails.profileImageUrl!),
                        ),
                ),
                title: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            '${posterDetails.firstName!} ${posterDetails.lastName!}',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        Text(
                          '@${posterDetails.userName!}',
                          style:
                              const TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                        const Text(
                          "11 Oct",
                          style: TextStyle(fontSize: 13),
                        ),
                        IconButton(
                            onPressed: () async {},
                            icon: const Icon(Icons.more_vert))
                      ],
                    ),
                    Text(post.content),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.comment)),
                              Text('${post.comments.length.toString()} ')
                            ],
                          ),
                        ),
                        // Container(
                        //   child: Row(
                        //     children: [
                        //       IconButton(
                        //           onPressed: () {},
                        //           icon: const Icon(
                        //               Icons.roller_shades)),
                        //       Text(post['comments']
                        //           .length
                        //           .toString())
                        //     ],
                        //   ),
                        // ),
                        Container(
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    ServiceCall.likePost(
                                        userId: currentUserId!,
                                        postId: docRef,
                                        currentUserLike:
                                            hasTheCurrentUserLiked);
                                  },
                                  icon: hasTheCurrentUserLiked
                                      ? const Icon(Icons.favorite_rounded)
                                      : const Icon(Icons.favorite_outline)),
                              Text(post.likes!.length.toString())
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.share)),
                              const Text('')
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
