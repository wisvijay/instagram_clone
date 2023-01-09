import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../model/comment.dart';
import '../model/post.dart';
import '../resources/storage_methods.dart';
import '../utils/constants.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(String description, Uint8List file, String uid,
      String username, String profImage) async {
    String res = "Some error occured!";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage(POSTS, file, true);
      String postId = const Uuid().v1();
      Post post = Post(
        description: description,
        uid: uid,
        username: username,
        postId: postId,
        postUrl: photoUrl,
        profImg: profImage,
        likes: [],
        datePublished: DateTime.now(),
      );
      await _firestore.collection(POSTS).doc(postId).set(post.toJson());
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection(POSTS).doc(postId).update({
          "likes": FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection(POSTS).doc(postId).update({
          "likes": FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> commentPost(String postId, String uid, String username,
      String profImg, String commentText) async {
    String res = "Some error Occured!";
    try {
      if (commentText.isNotEmpty) {
        String commentId = const Uuid().v1();
        Comment comment = Comment(
            username: username,
            uid: uid,
            comment: commentText,
            commentId: commentId,
            commentedOn: DateTime.now(),
            profImg: profImg,
            likes: []);
        await _firestore
            .collection(POSTS)
            .doc(postId)
            .collection(COMMENTS)
            .doc(commentId)
            .set(comment.toJson());
        res = "success";
      } else {
        res = "comment is empty";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
