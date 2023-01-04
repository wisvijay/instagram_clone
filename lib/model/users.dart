import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String userName;
  final String password;
  final String email;
  final String bio;
  final String photoUrl;
  final List following;
  final List followers;

  User({
    required this.userName,
    required this.password,
    required this.email,
    required this.bio,
    required this.photoUrl,
    required this.following,
    required this.followers,
  });

  Map<String, dynamic> toJson() => {
        "username": userName,
        "password": password,
        "email": email,
        "bio": bio,
        "photoUrl": photoUrl,
        "following": following,
        "followers": followers
      };

  static User fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
        userName: snapshot["username"],
        password: snapshot["password"],
        email: snapshot["email"],
        bio: snapshot["bio"],
        photoUrl: snapshot["photoUrl"],
        following: snapshot["following"],
        followers: snapshot["followers"]);
  }
}
