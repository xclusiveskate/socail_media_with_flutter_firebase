import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_tete/Modell/comment_model.dart';
import 'package:new_tete/Modell/post_model.dart';

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

  static addComment() {}
}
