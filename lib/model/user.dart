import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/utils/constants.dart';

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
        usernameFV: username,
        fullnameFV: fullname,
        uidFV: uid,
        emailFV: email,
        bioFV: bio,
        photoUrlFV: photoUrl,
        followingFV: following,
        followersFV: followers
      };

  static User fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
        username: snapshot[usernameFV],
        fullname: snapshot[fullnameFV],
        uid: snapshot[uidFV],
        email: snapshot[emailFV],
        bio: snapshot[bioFV],
        photoUrl: snapshot[photoUrlFV],
        following: snapshot[followingFV],
        followers: snapshot[followersFV]);
  }

  static User fromSingleSnapshot(Map<String, dynamic> snapshot) {
    return User(
        username: snapshot[usernameFV],
        fullname: snapshot[fullnameFV],
        uid: snapshot[uidFV],
        email: snapshot[emailFV],
        bio: snapshot[bioFV],
        photoUrl: snapshot[photoUrlFV],
        following: snapshot[followingFV],
        followers: snapshot[followersFV]);
  }
}
