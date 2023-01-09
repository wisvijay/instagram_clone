import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/model/post.dart';
import 'package:instagram_clone/utils/constants.dart';
import 'package:provider/provider.dart';

import '../model/user.dart' as modeluser;
import '../provider/user_provider.dart';
import '../resources/firestore_methods.dart';
import '../utils/color.dart';
import '../utils/spaces.dart';
import '../utils/utils.dart';
import '../widgets/like_animation.dart';

class PostCard extends StatefulWidget {
  const PostCard({super.key, required this.post});
  final Post post;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool _isAnimating = false;

  navigateToComments() {
    Navigator.of(context).pushNamed(
      CommentsRouteName,
      arguments: {
        PostId: widget.post.postId.toString(),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    modeluser.User user = Provider.of<UserProvider>(context).getUser;
    FireStoreMethods fireStoreMethods = FireStoreMethods();
    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          //Title row
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(widget.post.profImg),
              ),
              kHorizontalSpaceMedium,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post.username,
                      style: const TextStyle(fontSize: 18),
                    ),
                    const Text(
                      'subtitle',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert),
              ),
            ],
          ),
          kVerticalSpaceSmall,
          //Image
          GestureDetector(
            onDoubleTap: () async {
              setState(() {
                _isAnimating = true;
              });
              await fireStoreMethods.likePost(
                  widget.post.postId, widget.post.uid, widget.post.likes);
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: kScreenWidth(context),
                  height: kScreenHeight(context) * 0.45,
                  child: Image.network(
                    widget.post.postUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                AnimatedOpacity(
                  opacity: _isAnimating ? 1 : 0,
                  duration: const Duration(milliseconds: 500),
                  child: LikeAnimation(
                    isAnimating: _isAnimating,
                    child: const Icon(
                      Icons.favorite,
                      color: primaryColor,
                      size: 150,
                    ),
                    onEnd: () {
                      setState(() {
                        _isAnimating = false;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          //action items row
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    LikeAnimation(
                      isAnimating: widget.post.likes.contains(user.uid),
                      smallLike: true,
                      child: IconButton(
                        onPressed: () async {
                          await fireStoreMethods.likePost(widget.post.postId,
                              widget.post.uid, widget.post.likes);
                        },
                        icon: widget.post.likes.contains(user.uid)
                            ? const Icon(
                                Icons.favorite_outlined,
                                color: Colors.red,
                              )
                            : const Icon(
                                Icons.favorite_border,
                              ),
                      ),
                    ),
                    IconButton(
                      onPressed: navigateToComments,
                      icon: const Icon(Icons.chat_bubble_outline),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.send),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.bookmark_border),
              ),
            ],
          ),
          Container(
            width: kScreenWidth(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //likes
                Text('${widget.post.likes.length} likes'),
                kVerticalSpaceTiny,
                //description
                RichText(
                  text: TextSpan(
                    text: widget.post.description,
                  ),
                ),
                kVerticalSpaceTiny,
                //comments
                InkWell(
                  onTap: navigateToComments,
                  child: const Text(
                    'View all 827 comments',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                kVerticalSpaceTiny,
                //time
                Text(
                  calculateTimeDifferenceBetween(widget.post.datePublished),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
