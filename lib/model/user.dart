import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String username;
  final String fullname;
  final String uid;
  final String email;
  final String bio;
  final String photoUrl;
  final List following;
  final List followers;

  const User({
    required this.username,
    required this.fullname,
    required this.uid,
    required this.email,
    required this.bio,
    required this.photoUrl,
    required this.following,
    required this.followers,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "fullname": fullname,
        "uid": uid,
        "email": email,
        "bio": bio,
        "photoUrl": photoUrl,
        "following": following,
        "followers": followers
      };

  static User fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
        username: snapshot["username"],
        fullname: snapshot["fullname"],
        uid: snapshot["uid"],
        email: snapshot["email"],
        bio: snapshot["bio"],
        photoUrl: snapshot["photoUrl"],
        following: snapshot["following"],
        followers: snapshot["followers"]);
  }
}
