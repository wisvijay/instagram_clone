import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String username;
  final String postId;
  final String postUrl;
  final String profImg;
  final likes;
  final DateTime datePublished;

  const Post({
    required this.description,
    required this.uid,
    required this.username,
    required this.postId,
    required this.postUrl,
    required this.profImg,
    required this.likes,
    required this.datePublished,
  });

  Map<String, dynamic> toJson() => {
        "description": description,
        "uid": uid,
        "username": username,
        "postId": postId,
        "postUrl": postUrl,
        "profImg": profImg,
        "likes": likes,
        "datePublished": datePublished
      };

  static Post fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post(
      description: snapshot["description"],
      uid: snapshot["uid"],
      username: snapshot["username"],
      postId: snapshot["postId"],
      postUrl: snapshot["postUrl"],
      profImg: snapshot["profImg"],
      likes: snapshot["likes"],
      datePublished: snapshot["datePublished"],
    );
  }
}
