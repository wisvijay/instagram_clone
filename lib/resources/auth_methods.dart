import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_clone/model/users.dart' as model;
import 'package:instagram_clone/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<void> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
        await _fireStore.collection('users').doc(currentUser.uid).get();

    print(documentSnapshot);
  }

  Future<String> signupUser({
    required String userName,
    required String email,
    required String password,
    required String bio,
    required Uint8List file,
  }) async {
    var res = 'Some error occured';
    try {
      if (userName.isNotEmpty ||
          email.isNotEmpty ||
          password.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);
        model.User _users = model.User(
          userName: userName,
          password: password,
          email: email,
          bio: bio,
          photoUrl: photoUrl,
          following: [],
          followers: [],
        );
        await _fireStore
            .collection('Users')
            .doc(cred.user!.uid)
            .set(_users.toJson());
        res = 'User creation success';
      } else {
        res = 'Please enter all the fields';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> loginUser(String email, String password) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        res = "Please enter a valid email";
      } else if (e.code == 'user-not-found') {
        res =
            "Email address or Password is Wrong! Please retry with valid credentials";
      }
    } catch (e) {
      res = e.toString();
    }

    return res;
  }
}
