import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_tete/Modell/user_model.dart';
import 'package:new_tete/UI/util/utils.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  saveUserImageToCloud({required String img}) async {
    final cloud = CloudinaryPublic('dsxaqfgrc', 'jxe7hcul');
    CloudinaryResponse cloudStorage =
        await cloud.uploadFile(CloudinaryFile.fromFile(img));
    print(cloudStorage.url);
    return cloudStorage.url;
  }

  signUpWithEmail(
      {required BuildContext context,
      required String userEmail,
      required String password,
      required String lastName,
      required String firstName,
      String? username,
      String? profileImageUrl,
      String? phoneNumber,
      String? bio}) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: userEmail, password: password);
      final String uid = result.user!.uid;

      final userRef = _db.collection('users');
      UserModel user = UserModel(
          id: uid,
          lastName: lastName,
          firstName: firstName,
          userName: username ?? userName,
          userEmail: userEmail,
          phoneNumber: phoneNumber ?? userNumber,
          profileImageUrl: profileImageUrl ?? profilePicUrl,
          bio: bio ?? userBio,
          followers: [],
          following: []);

      await userRef.doc(uid).set(user.toJson());
    } on FirebaseAuthException catch (e) {
      String message = e.message!;
      switch (e.code) {
        case 'email-already-in-use':
          message = "Email already in use,  pick another email";
          break;
        case 'invalid-email':
          message = "Enter valid e-mail";
          break;
        case 'weak-password':
          message = "Password must be more than 6 characters";
          break;
        case 'too-many-requests':
          message = "Too many requests, Please try again later.";
          break;
        default:
      }
      showSnackBar(context: context, message: message);
    } catch (e) {
      showSnackBar(context: context, message: "Couldn't sign up");
    }
  }

  signInWithEmail(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      UserCredential res = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      showSnackBar(
          context: context, message: "You have successfully logged in");
      print(res.user!.displayName);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, message: e.message!);
      print(e.message);
    } catch (e) {
      showSnackBar(context: context, message: e.toString());
      print(e.toString());
    }
  }

  resetPassword({required String email}) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  signOut() async {
    await _auth.signOut();
  }
}
