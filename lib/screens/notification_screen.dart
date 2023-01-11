import 'package:flutter/material.dart';

import '../utils/color.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Notifications'),
        backgroundColor: mobileBackgroundColor,
      ),
    );
  }
}
