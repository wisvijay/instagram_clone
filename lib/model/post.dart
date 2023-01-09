import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String username;
  final String postId;
  final String postUrl;
  final String profImg;
  final List likes;
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

  static Post fromSnapshot(Map<String, dynamic> snap) {
    return Post(
      description: snap["description"],
      uid: snap["uid"],
      username: snap["username"],
      postId: snap["postId"],
      postUrl: snap["postUrl"],
      profImg: snap["profImg"],
      likes: snap["likes"],
      datePublished: (snap["datePublished"] as Timestamp).toDate(),
    );
  }
}
