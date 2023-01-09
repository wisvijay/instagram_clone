import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/user.dart' as model;
import '../provider/user_provider.dart';
import '../resources/auth_methods.dart';
import '../utils/color.dart';
import '../utils/spaces.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthMethods _authMethods = AuthMethods();

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
    model.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
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
                    style: const TextStyle(fontSize: 16, color: primaryColor),
                  ),
                ],
              ),
              //posts
              Column(
                children: [
                  Text(
                    user.followers.length.toString(),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  kVerticalSpaceTiny,
                  const Text(
                    'Posts',
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
              //followers
              Column(
                children: [
                  Text(
                    user.followers.length.toString(),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  kVerticalSpaceTiny,
                  const Text(
                    'Followers',
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
              //following
              Column(
                children: [
                  Text(
                    user.following.length.toString(),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  kVerticalSpaceTiny,
                  const Text(
                    'Following',
                    style: TextStyle(fontSize: 16),
                  )
                ],
              )
            ],
          ),
          kVerticalSpaceMedium,
          Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[900],
                    minimumSize: Size(kScreenWidth(context) * 0.86, 40)),
                child: const Text('Edit profile'),
              ),
              kHorizontalSpaceTiny,
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  color: Colors.grey[900],
                  height: 40,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.person_add),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
