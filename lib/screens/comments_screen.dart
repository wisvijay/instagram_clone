import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/comment.dart';
import '../model/user.dart' as modelUser;
import '../provider/user_provider.dart';
import '../resources/firestore_methods.dart';
import '../utils/color.dart';
import '../utils/constants.dart';
import '../utils/spaces.dart';
import '../utils/utils.dart';
import '../widgets/comment_card.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({super.key, required this.postId});
  final String postId;

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController _commentsController = TextEditingController();
  final FireStoreMethods _fireStoreMethods = FireStoreMethods();

  @override
  void dispose() {
    super.dispose();
    _commentsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    modelUser.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user.photoUrl),
                radius: 25,
              ),
              kHorizontalSpaceSmall,
              Expanded(
                child: TextField(
                  controller: _commentsController,
                  decoration: const InputDecoration(
                    hintText: 'Add your comments...',
                    border: InputBorder.none,
                  ),
                ),
              ),
              kHorizontalSpaceSmall,
              TextButton(
                onPressed: () async {
                  String res = await _fireStoreMethods.commentPost(
                      widget.postId,
                      user.uid,
                      user.username,
                      user.photoUrl,
                      _commentsController.text);
                  _commentsController.clear();
                  showSnackBar(context, res);
                },
                child: const Text(
                  'Post',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(POSTS)
            .doc(widget.postId)
            .collection(COMMENTS)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData && snapshot.data!.docs.length.toInt() > 0) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return CommentCard(
                  comment:
                      Comment.fromSnapshot(snapshot.data!.docs[index].data()),
                );
              },
            );
          }
          return const Center(
            child: Text(
              'No comments yet!',
              style: TextStyle(fontSize: 24),
            ),
          );
        },
      ),
    );
  }
}
