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
}
