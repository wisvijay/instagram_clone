import 'package:flutter/material.dart';

import '../model/comment.dart';
import '../utils/utils.dart';
import '../utils/spaces.dart';
import '../widgets/like_animation.dart';

class CommentCard extends StatefulWidget {
  const CommentCard({super.key, required this.comment});
  final Comment comment;

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  bool _isLikeAnimating = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.comment.profImg),
            radius: 30,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(widget.comment.username),
                      kHorizontalSpaceMedium,
                      Text(
                        calculateTimeDifferenceBetween(
                            widget.comment.commentedOn),
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 14),
                      )
                    ],
                  ),
                  kVerticalSpaceSmall,
                  Text(widget.comment.comment),
                  kVerticalSpaceSmall,
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      'Reply',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ),
          LikeAnimation(
            isAnimating: _isLikeAnimating,
            smallLike: true,
            child: InkWell(
              onTap: () {
                setState(() {
                  _isLikeAnimating = !_isLikeAnimating;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.favorite_border,
                    size: 20,
                  ),
                  Text(widget.comment.likes.length.toString()),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
