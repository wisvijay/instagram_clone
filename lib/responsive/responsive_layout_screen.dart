import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';
import '../utils/spaces.dart';

class ResponsiveLayoutScreen extends StatefulWidget {
  final Widget weblayout;
  final Widget mobilelayout;
  const ResponsiveLayoutScreen({
    super.key,
    required this.weblayout,
    required this.mobilelayout,
  });

  @override
  State<ResponsiveLayoutScreen> createState() => _ResponsiveLayoutScreenState();
}

class _ResponsiveLayoutScreenState extends State<ResponsiveLayoutScreen> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, contraints) {
      if (contraints.maxWidth > appLayoutMobileWidth) {
        return widget.weblayout;
      }
      return widget.mobilelayout;
    });
  }
}
