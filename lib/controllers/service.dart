import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_tete/Modell/comment_model.dart';
import 'package:new_tete/Modell/post_model.dart';
import 'package:new_tete/Modell/user_model.dart';

import 'package:uuid/uuid.dart';

class ServiceCall {
  static createPost(
      {required String content,
      required DateTime datePublished,
      required String userId,
      String? imageUrl,
      List? likes,
      List<Comment>? comments}) async {
    try {
      final FirebaseFirestore db = FirebaseFirestore.instance;
      final postRef = db.collection('posts');
      final postId = const Uuid().v1();

      PostModel post = PostModel(
          uid: postId,
          datePublished: datePublished,
          userId: userId,
          imageUrl: imageUrl ?? '',
          content: content,
          likes: [],
          comments: []);

      await postRef.doc(postId).set(post.toJson());
    } catch (e) {
      print(e);
    }
  }

  static likePost(
      {required String userId,
      required String postId,
      required bool currentUserLike}) {
    print(postId);
    final db = FirebaseFirestore.instance;
    var postToLike = db.collection('posts').doc(postId);
    if (currentUserLike) {
      postToLike.update({
        'likes': FieldValue.arrayRemove([userId])
      });
    } else {
      postToLike.update({
        'likes': FieldValue.arrayUnion([userId])
      });
    }
  }

  static addComment(
      PostModel post, TextEditingController commentController, currentUser) {
    if (commentController.text.isNotEmpty) {
      try {
        final uid = const Uuid().v1();
        FirebaseFirestore.instance.collection('posts').doc(post.uid).update({
          "comments": FieldValue.arrayUnion([
            {
              "commentId": uid,
              "comment": commentController.text,
              "userId": currentUser,
              // "likes": null
            }
          ])
        });
      } catch (e) {
        print(e);
      }
    }
  }

  static followUser(UserModel user, String currentUser) {
    final followInstance = FirebaseFirestore.instance.collection('users');
    try {
      followInstance.doc(user.id).get().then((user) {
        final theUser = UserModel.fromFirestore(user);
        bool currentUserExist =
            (theUser.followers as List).contains(currentUser);
        print(currentUser);
        if (currentUserExist) {
          followInstance.doc(theUser.id).update({
            'followers': FieldValue.arrayRemove([currentUser])
          });
          followInstance.doc(currentUser).update({
            'following': FieldValue.arrayRemove([user])
          });
        } else {
          followInstance.doc(theUser.id).update({
            'followers': FieldValue.arrayUnion([currentUser])
          });
          followInstance.doc(currentUser).update({
            'following': FieldValue.arrayUnion([user])
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

  static editProfile(UserModel user) {
    try {
      FirebaseFirestore.instance.collection('users').doc(user.id).update({});
    } catch (e) {}
  }
}
