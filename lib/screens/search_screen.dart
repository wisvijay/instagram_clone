import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../model/user.dart';
import '../utils/color.dart';
import '../utils/constants.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool isShowUser = false;

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: TextFormField(
          controller: _searchController,
          decoration: const InputDecoration(
            labelText: 'Search for a user',
          ),
          onFieldSubmitted: (value) {
            setState(() {
              isShowUser = true;
            });
          },
        ),
      ),
      body: isShowUser
          ? Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
              child: FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection(USERS)
                    .where(usernameFV,
                        isGreaterThanOrEqualTo: _searchController.text)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text('No User Found!'),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final User _user = User.fromSingleSnapshot(
                          snapshot.data!.docs[index].data());
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(_user.photoUrl),
                        ),
                        title: Text(_user.username),
                        onTap: () {
                          Navigator.of(context).pushNamed(ProfileRouteName,
                              arguments: {'uid': _user.uid});
                        },
                      );
                    },
                  );
                },
              ),
            )
          : FutureBuilder(
              future: FirebaseFirestore.instance.collection(POSTS).get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return MasonryGridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Image.network(
                          snapshot.data!.docs[index]['postUrl']);
                    },
                  );
                }
                return const Center(
                  child: Text('Search users'),
                );
              },
            ),
    );
  }
}
