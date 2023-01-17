import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../model/user.dart' as model;
import '../resources/storage_methods.dart';
import '../utils/constants.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<model.User> getCurrentUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
        await _fireStore.collection(USERS).doc(currentUser.uid).get();

    return model.User.fromSnapshot(documentSnapshot);
  }

  Future<model.User> getUserDetails(String uid) async {
    DocumentSnapshot documentSnapshot =
        await _fireStore.collection(USERS).doc(uid).get();

    return model.User.fromSnapshot(documentSnapshot);
  }

  Future<String> signupUser({
    required String userName,
    required String fullName,
    required String email,
    required String password,
    required String bio,
    required Uint8List file,
  }) async {
    var res = ErrorOccured;
    try {
      if (userName.isNotEmpty ||
          fullName.isNotEmpty ||
          email.isNotEmpty ||
          password.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String photoUrl = await StorageMethods()
            .uploadImageToStorage(PROFILE_PICS, file, false);

        model.User _users = model.User(
          username: userName,
          fullname: fullName,
          uid: cred.user!.uid,
          email: email,
          bio: bio,
          photoUrl: photoUrl,
          following: [],
          followers: [],
        );

        await _fireStore
            .collection(USERS)
            .doc(cred.user!.uid)
            .set(_users.toJson());
        res = Success;
      } else {
        res = fillAllDetailsStr;
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> loginUser(String email, String password) async {
    String res = ErrorOccured;
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = Success;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == invalidEmail) {
        res = enterValidEmailStr;
      } else if (e.code == userNotFound) {
        res = emailPasswordWrongStr;
      }
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
