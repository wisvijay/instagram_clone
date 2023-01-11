import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/utils/constants.dart';

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
        usernameFV: username,
        uidFV: uid,
        commentFV: comment,
        commentIdFV: commentId,
        commentedOnFV: commentedOn,
        profImgFV: profImg,
        commentLikesFV: likes,
      };

  static Comment fromSnapshot(Map<String, dynamic> snapshot) {
    return Comment(
      username: snapshot[usernameFV],
      uid: snapshot[uidFV],
      comment: snapshot[commentFV],
      commentId: snapshot[commentIdFV],
      commentedOn: (snapshot[commentedOnFV] as Timestamp).toDate(),
      profImg: snapshot[profImgFV],
      likes: snapshot[commentLikesFV],
    );
  }
}
