import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/color.dart';

import '../utils/spaces.dart';

class ProfileFollowButton extends StatelessWidget {
  final bool isMyProfile;
  final bool isFollowing;
  final VoidCallback? profileAction;
  final VoidCallback? followAction;
  const ProfileFollowButton({
    super.key,
    this.isMyProfile = false,
    this.profileAction,
    this.followAction,
    this.isFollowing = false,
  });

  @override
  Widget build(BuildContext context) {
    return isMyProfile
        ? Row(
            children: [
              ElevatedButton(
                onPressed: profileAction,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[900],
                    minimumSize: Size(kScreenWidth(context) * 0.86, 40)),
                child: const Text('Edit profile'),
              ),
              kHorizontalSpaceTiny,
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  color: Colors.grey[900],
                  height: 40,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.person_add),
                  ),
                ),
              ),
            ],
          )
        : Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: followAction,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: primaryColor),
                    child: isFollowing
                        ? const Text('Unfollow')
                        : const Text('Follow'),
                  ),
                ),
                if (isFollowing) kHorizontalSpaceSmall,
                if (isFollowing)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[900],
                      ),
                      child: const Text('Message'),
                    ),
                  ),
              ],
            ),
          );
  }
}