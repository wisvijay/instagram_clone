import 'package:flutter/material.dart';

import '../utils/color.dart';
import '../utils/constants.dart';
import '../utils/images.dart';
import '../utils/spaces.dart';

class StoryRow extends StatelessWidget {
  const StoryRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Stack(
              children: [
                const CircleAvatar(
                  foregroundImage: NetworkImage(AppImages.profileImg),
                  radius: 35,
                ),
                Positioned(
                  right: -15,
                  bottom: -5,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      minimumSize: const Size(20, 20),
                    ),
                    child: const Icon(Icons.add),
                  ),
                ),
              ],
            ),
            kVerticalSpaceTiny,
            const Text(
              yourStoryStr,
              style: TextStyle(
                fontSize: 16,
                color: primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        kHorizontalSpaceLarge,
        Column(
          children: const [
            CircleAvatar(
              foregroundImage: NetworkImage(AppImages.storyImg),
              radius: 35,
            ),
            kVerticalSpaceTiny,
            Text(
              storyUsernameStr,
              style: TextStyle(fontSize: 16, color: primaryColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    );
  }
}
