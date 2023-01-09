import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String username;
  final String uid;
  final String comment;
  final String commentId;
  final DateTime commentedOn;
  final String profImg;
  final List likes;

  const Comment({
    required this.username,
    required this.uid,
    required this.comment,
    required this.commentId,
    required this.commentedOn,
    required this.profImg,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "comment": comment,
        "commentId": commentId,
        "commentedOn": commentedOn,
        "profImg": profImg,
        "likes": likes,
      };

  static Comment fromSnapshot(Map<String, dynamic> snapshot) {
    return Comment(
      username: snapshot["username"],
      uid: snapshot["uid"],
      comment: snapshot["comment"],
      commentId: snapshot["commentId"],
      commentedOn: (snapshot["commentedOn"] as Timestamp).toDate(),
      profImg: snapshot["profImg"],
      likes: snapshot["likes"],
    );
  }
}
