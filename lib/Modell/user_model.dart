//collection
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? lastName;
  String? firstName;
  String? userName;
  String? userEmail;
  String? phoneNumber;
  String? profileImageUrl;
  String? bio;
  List? followers;
  List? following;
  UserModel({
    this.id,
    this.lastName,
    this.firstName,
    this.userName,
    this.userEmail,
    this.phoneNumber,
    this.profileImageUrl,
    this.bio,
    this.followers,
    this.following,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lastName': lastName,
      'firstName': firstName,
      'userName': userName,
      'userEmail': userEmail,
      'phoneNumber': phoneNumber,
      'profileImageUrl': profileImageUrl,
      'bio': bio,
      'followers': followers,
      'following': following,
    };
  }

  factory UserModel.fromFirestore(
    DocumentSnapshot document,
  ) {
    final data = document.data() as Map;
    return UserModel(
      id: data['id'] as String,
      lastName: data['lastName'] as String,
      firstName: data['firstName'] as String,
      userName: data['userName'] as String,
      userEmail: data['userEmail'] as String,
      phoneNumber: data['phoneNumber'] as String,
      profileImageUrl: data['profileImageUrl'] as String,
      bio: data['bio'] as String,
      followers: List.from(data['followers']),
      following: List.from(data['following']),
    );
  }
}

List<UserModel> users = [];

// String? userBio, userNumber, userName, profilePicUrl;
String userBio = '';
String userNumber = '';
String userName = '';
String profilePicUrl = '';
