import 'package:faker_dart/faker_dart.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/spaces.dart';

import '../utils/constants.dart';

class ReelsScreen extends StatelessWidget {
  ReelsScreen({super.key});
  final PageController pageController = PageController();
  final faker = Faker.instance;

  @override
  Widget build(BuildContext context) {
    addPost() {
      Navigator.of(context).pushNamed(AddPostRouteName);
    }

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            PageView.builder(
              padEnds: false,
              scrollDirection: Axis.vertical,
              controller: pageController,
              itemBuilder: (context, index) {
                var reelImg = faker.image.unsplash.nature();
                return Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff7c94b6),
                        image: DecorationImage(
                          image: NetworkImage(reelImg),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    reelOwner()
                  ],
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    reelsStr,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ),
                IconButton(
                  onPressed: addPost,
                  icon: const Icon(
                    Icons.photo_camera_outlined,
                    size: 28,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Align reelOwner() {
    var name = faker.fake('{{name.firstName}} {{name.lastName}}');
    var img = faker.image.loremPicsum.image();
    var desc = faker.lorem.paragraph(sentenceCount: 3);
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              flex: 8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(img),
                        radius: 20,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        name,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  kVerticalSpaceSmall,
                  Text(
                    desc,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 3,
                    style: const TextStyle(color: Colors.white),
                  ),
                  kVerticalSpaceLarge,
                ],
              ),
            ),
            Flexible(flex: 1, child: actionButtons()),
          ],
        ),
      ),
    );
  }
}

Column actionButtons() {
  String likes = Faker.instance.datatype.number(min: 0, max: 9999).toString();
  String comments =
      Faker.instance.datatype.number(min: 0, max: 9999).toString();
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      actionButtonItem(label: likes, icon: Icons.favorite_border),
      actionButtonItem(label: comments, icon: Icons.chat_bubble_outline),
      actionButtonItem(icon: Icons.send),
      actionButtonItem(icon: Icons.more_vert),
    ],
  );
}

Column actionButtonItem(
    {String? label, required IconData icon, Function()? action}) {
  return Column(
    children: [
      IconButton(
        onPressed: action,
        icon: Icon(
          icon,
          color: Colors.white,
          size: 30,
        ),
      ),
      if (label != null) Text(label),
    ],
  );
}
