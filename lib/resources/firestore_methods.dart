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
      String username, String bio, String profImage) async {
    String res = ErrorOccured;
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage(POSTS, file, true);
      String postId = const Uuid().v1();
      Post post = Post(
        description: description,
        uid: uid,
        username: username,
        bio: bio,
        postId: postId,
        postUrl: photoUrl,
        profImg: profImage,
        likes: [],
        datePublished: DateTime.now(),
      );
      await _firestore.collection(POSTS).doc(postId).set(post.toJson());
      res = Success;
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection(POSTS).doc(postId).update({
          likesFV: FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection(POSTS).doc(postId).update({
          likesFV: FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> commentPost(String postId, String uid, String username,
      String profImg, String commentText) async {
    String res = ErrorOccured;
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
        res = Success;
      } else {
        res = "comment is empty";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<int> getCommentsCount(String postId) async {
    int commentCount = 0;
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection(POSTS)
          .doc(postId)
          .collection(COMMENTS)
          .get();
      commentCount = querySnapshot.docs.length;
    } catch (e) {
      print(e.toString());
    }

    return commentCount;
  }

  Future<int> getPostsCount(String uid) async {
    int postsCount = 0;
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection(POSTS).where(uidFV, isEqualTo: uid).get();
      postsCount = querySnapshot.docs.length;
    } catch (e) {
      print(e.toString());
    }

    return postsCount;
  }

  Future<void> followUser(
      String uid, String followerUid, List followers) async {
    try {
      if (followers.contains(uid)) {
        // Unfollow the user by reducing follower count from logged user and following count from current user
        await _firestore.collection(USERS).doc(uid).update({
          followingFV: FieldValue.arrayRemove([followerUid])
        });

        await _firestore.collection(USERS).doc(followerUid).update({
          followersFV: FieldValue.arrayRemove([uid])
        });
      } else {
        // Follow the user by adding follower count from logged user and following count from current user
        await _firestore.collection(USERS).doc(uid).update({
          followingFV: FieldValue.arrayUnion([followerUid])
        });

        await _firestore.collection(USERS).doc(followerUid).update({
          followersFV: FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {}
  }

  Future<String> deletePost(String postId) async {
    String res = ErrorOccured;
    try {
      await _firestore.collection(POSTS).doc(postId).delete();
      res = Success;
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
