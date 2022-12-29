import 'package:flutter/material.dart';

import '../utils/spaces.dart';

class LayoutSelector extends StatelessWidget {
  final Widget weblayout;
  final Widget mobilelayout;
  const LayoutSelector({
    super.key,
    required this.weblayout,
    required this.mobilelayout,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, contraints) {
      if (contraints.maxWidth > appLayoutMobileWidth) {
        return weblayout;
      }
      return mobilelayout;
    });
  }
}
