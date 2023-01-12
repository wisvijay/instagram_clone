import 'package:flutter/material.dart';
import 'package:faker_dart/faker_dart.dart';
import 'package:instagram_clone/utils/spaces.dart';

class FollowerSuggestionCard extends StatelessWidget {
  const FollowerSuggestionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final faker = Faker.instance;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Discover people',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            TextButton(
                onPressed: () {},
                child: const Text(
                  'See all',
                  style: TextStyle(color: Colors.blue),
                ))
          ],
        ),
        Container(
          width: double.infinity,
          height: 225,
          child: ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                var img = faker.image.unsplash.image();
                var name = faker.fake('{{name.firstName}} {{name.lastName}}');
                var followedBy = faker.fake('{{name.firstName}}');
                return Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade700,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        // color: Colors.grey[50],
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 10.0),
                      margin: const EdgeInsets.only(right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(img),
                            radius: 40,
                          ),
                          kVerticalSpaceSmall,
                          Text(name),
                          kVerticalSpaceTiny,
                          Text(
                            'followed by $followedBy',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          kVerticalSpaceTiny,
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue),
                            child: const Text('Follow'),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      right: 5,
                      top: 0,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.close),
                      ),
                    )
                  ],
                );
              }),
        ),
        kVerticalSpaceMedium,
      ],
    );
  }
}
