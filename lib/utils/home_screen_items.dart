import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/notification_screen.dart';
import '../screens/reels_screen.dart';
import '../screens/search_screen.dart';
import '../screens/home_screen.dart';
import '../screens/profile_screen.dart';

List<Widget> homeScreenItems = [
  const HomeScreen(),
  const SearchScreen(),
  ReelsScreen(),
  const NotificationScreen(),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
