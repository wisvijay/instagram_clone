import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/color.dart';
import '../utils/constants.dart';
import '../utils/spaces.dart';
import '../utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Uint8List? image;

  selectImage() async {
    Uint8List pim = await pickImage(ImageSource.gallery);
    setState(() {
      image = pim;
    });
  }

  addPost() {
    Navigator.of(context).pushNamed(AddPostRouteName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          'assets/instagram.svg',
          height: 40,
          color: primaryColor,
        ),
        actions: [
          IconButton(
            onPressed: addPost,
            icon: const Icon(Icons.add_box_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.whatsapp),
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
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      image != null
                          ? CircleAvatar(
                              backgroundImage: MemoryImage(image!),
                              radius: 35,
                            )
                          : const CircleAvatar(
                              foregroundImage: NetworkImage(
                                  'https://i.stack.imgur.com/l60Hf.png'),
                              radius: 35,
                            ),
                      Positioned(
                        right: -15,
                        bottom: -5,
                        child: ElevatedButton(
                          onPressed: selectImage,
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
          )
        ],
      ),
    );
  }
}
