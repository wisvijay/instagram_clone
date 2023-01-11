import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/user.dart' as model_user;
import '../resources/auth_methods.dart';
import '../resources/firestore_methods.dart';
import '../utils/color.dart';
import '../utils/constants.dart';
import '../utils/spaces.dart';
import '../widgets/profile_follow_button.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({super.key, required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthMethods _authMethods = AuthMethods();
  final FireStoreMethods _fireStoreMethods = FireStoreMethods();
  String currentUserId = FirebaseAuth.instance.currentUser!.uid;
  int postCount = 0;
  bool isLoading = true;
  late model_user.User user;

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  void getUserDetails() async {
    user = await _authMethods.getUserDetails(widget.uid);
    postCount = await _fireStoreMethods.getPostsCount(widget.uid);
    setState(() {
      isLoading = false;
    });
  }

  void editProfile() {}

  void followUsers() async {
    await _fireStoreMethods.followUser(
      currentUserId,
      widget.uid,
      user.following,
    );
  }

  void showPopMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: ((context) {
        return Wrap(
          children: [
            kVerticalSpaceLarge,
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text(
                'Sign out',
                style: TextStyle(fontSize: 18),
              ),
              onTap: signOut,
            ),
            const SizedBox(
              height: 150,
            ),
          ],
        );
      }),
    );
  }

  void signOut() {
    _authMethods.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(user.username),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add_box_outlined),
                ),
                IconButton(
                  onPressed: () {
                    showPopMenu(context);
                  },
                  icon: const Icon(Icons.menu),
                )
              ],
              backgroundColor: mobileBackgroundColor,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                kVerticalSpaceLarge,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //profile image
                    Column(
                      children: [
                        CircleAvatar(
                          foregroundImage: NetworkImage(user.photoUrl),
                          radius: 35,
                        ),
                        kVerticalSpaceTiny,
                        Text(
                          user.fullname,
                          style: const TextStyle(
                              fontSize: 16, color: primaryColor),
                        ),
                      ],
                    ),
                    //posts
                    activityCount('Posts', postCount.toString()),
                    //followers
                    activityCount(
                        'Followers', user.followers.length.toString()),
                    //following
                    activityCount(
                        'Following', user.following.length.toString()),
                  ],
                ),
                kVerticalSpaceMedium,
                ProfileFollowButton(
                  isMyProfile: currentUserId == user.uid,
                  profileAction: editProfile,
                  followAction: followUsers,
                ),
                const Divider(),
                kVerticalSpaceSmall,
                FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection(POSTS)
                        .where(uidFV, isEqualTo: user.uid)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return GridView.builder(
                        shrinkWrap: true,
                        itemCount: (snapshot.data! as dynamic).docs.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 1.5,
                          childAspectRatio: 1,
                        ),
                        itemBuilder: (context, index) {
                          DocumentSnapshot snap =
                              (snapshot.data! as dynamic).docs[index];

                          return Image(
                            image: NetworkImage(snap['postUrl']),
                            fit: BoxFit.cover,
                          );
                        },
                      );
                    }),
              ],
            ),
          );
  }

  Column activityCount(String label, String count) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        kVerticalSpaceTiny,
        Text(
          label,
          style: const TextStyle(fontSize: 16),
        )
      ],
    );
  }
}
