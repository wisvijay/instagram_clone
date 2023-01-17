import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/post.dart';
import '../utils/color.dart';
import '../utils/constants.dart';
import '../utils/images.dart';
import '../utils/spaces.dart';
import '../widgets/post_card.dart';
import '../widgets/story_row.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  addPost() {
    Navigator.of(context).pushNamed(AddPostRouteName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppImages.getLogo(40),
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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(POSTS)
            .orderBy(datePublishedFV, descending: true)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      kVerticalSpaceLarge,
                      const StoryRow(),
                      const Divider(),
                      PostCard(
                          post: Post.fromSingleSnapshot(
                              snapshot.data!.docs[index].data())),
                    ],
                  );
                } else {
                  return PostCard(
                      post: Post.fromSingleSnapshot(
                          snapshot.data!.docs[index].data()));
                }
              },
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              kVerticalSpaceLarge,
              StoryRow(),
              Divider(),
              Center(
                child: Text(noFeedsStr),
              ),
            ],
          );
        },
      ),
    );
  }
}
