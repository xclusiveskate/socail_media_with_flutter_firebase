import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_tete/Modell/comment_model.dart';

//collection
class PostModel {
  final String? uid;
  final DateTime datePublished;
  final String userId;
  // final String postImage;
  final String imageUrl;
  final String content;
  final List? likes;
  final List<Comment> comments;
  PostModel({
    required this.uid,
    required this.datePublished,
    required this.userId,
    // required this.postImage,
    required this.imageUrl,
    required this.content,
    required this.likes,
    required this.comments,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'datePublished': datePublished.toIso8601String(),
      'userId': userId,
      // 'postImage': postImage,
      'imageUrl': imageUrl,
      'content': content,
      'likes': likes,
      'comments': comments.map((x) => x.toJson()).toList()
    };
  }

  factory PostModel.fromFirestore(
    DocumentSnapshot documents,
  ) {
    final data = documents.data() as Map;
    return PostModel(
      uid: data['uid'] as String,
      datePublished: DateTime.parse(data['datePublished']),
      userId: data['userId'] as String,
      // postImage: json['postImage'] ?? '',
      imageUrl: data['imageUrl'] as String,
      content: data['content'] as String,
      likes: List.from(data['likes']),
      comments:
          List<Comment>.from(data['comments']?.map((x) => Comment.fromJson(x))),
    );
  }
}

List<PostModel> postss = [];
