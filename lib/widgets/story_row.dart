import 'package:flutter/material.dart';

import '../utils/color.dart';
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
                  foregroundImage:
                      NetworkImage('https://i.stack.imgur.com/l60Hf.png'),
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
              'Your story',
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
              foregroundImage: NetworkImage(
                  'https://cdn.pixabay.com/photo/2016/07/05/16/53/leaves-1498985__340.jpg'),
              radius: 35,
            ),
            kVerticalSpaceTiny,
            Text(
              'Vijay',
              style: TextStyle(fontSize: 16, color: primaryColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    );
  }
}
