import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/utils/constants.dart';

class Post {
  final String description;
  final String uid;
  final String username;
  final String bio;
  final String postId;
  final String postUrl;
  final String profImg;
  final List likes;
  final DateTime datePublished;

  const Post({
    required this.description,
    required this.uid,
    required this.username,
    required this.bio,
    required this.postId,
    required this.postUrl,
    required this.profImg,
    required this.likes,
    required this.datePublished,
  });

  Map<String, dynamic> toJson() => {
        descriptionFV: description,
        uidFV: uid,
        usernameFV: username,
        bioFV: bio,
        postIdFV: postId,
        postUrlFV: postUrl,
        profImgFV: profImg,
        likesFV: likes,
        datePublishedFV: datePublished
      };

  static Post fromSingleSnapshot(Map<String, dynamic> snap) {
    return Post(
      description: snap[descriptionFV],
      uid: snap[uidFV],
      username: snap[usernameFV],
      bio: snap[bioFV],
      postId: snap[postIdFV],
      postUrl: snap[postUrlFV],
      profImg: snap[profImgFV],
      likes: snap[likesFV],
      datePublished: (snap[datePublishedFV] as Timestamp).toDate(),
    );
  }
}
