import 'package:flutter/material.dart';
import 'package:instagram_clone/provider/user_provider.dart';
import 'package:instagram_clone/resources/auth_methods.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final UserProvider _userProvider = UserProvider();
  final AuthMethods _authMethods = AuthMethods();

  @override
  Widget build(BuildContext context) {
    print(_userProvider.getUser);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: const Center(
        child: Text('Home'),
      ),
    );
  }
}
