import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../dialog/showpopup_dialog.dart';
import '../provider/user_provider.dart';
import '../resources/firestore_methods.dart';
import '../utils/utils.dart';
import '../utils/color.dart';
import '../utils/spaces.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  Uint8List? file;
  bool isLoading = false;
  bool isShowAction = false;
  final TextEditingController _descriptionController = TextEditingController();

  selectFromGallery() async {
    setState(() {
      isLoading = true;
    });
    Navigator.of(context).pop();
    Uint8List pim = await pickImage(ImageSource.gallery);
    setState(() {
      file = pim;
      isLoading = false;
      isShowAction = true;
    });
  }

  takeFromPhoto() async {
    setState(() {
      isLoading = true;
    });
    Navigator.of(context).pop();
    Uint8List pim = await pickImage(ImageSource.camera);
    setState(() {
      file = pim;
      isLoading = false;
      isShowAction = true;
    });
  }

  onFileUpload() async {
    showDialog(
      context: context,
      builder: ((context) => ShowPopupDialog(
          takePhotoOption: takeFromPhoto,
          fromGalleryOption: selectFromGallery)),
    );
  }

  void postImage(String uid, String username, String profImage) async {
    setState(() {
      isLoading = true;
    });
    try {
      String res = await FireStoreMethods().uploadPost(
        _descriptionController.text,
        file!,
        uid,
        username,
        profImage,
      );
      setState(() {
        isLoading = false;
      });
      if (res == "success") {
        showSnackBar(
          context,
          'Posted!',
        );
        Navigator.of(context).pop();
      } else {
        showSnackBar(
          context,
          res,
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(
        context,
        e.toString(),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    file = null;
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              title: const Text('New Post'),
              backgroundColor: mobileBackgroundColor,
              actions: isShowAction
                  ? [
                      IconButton(
                        onPressed: () => postImage(
                          userProvider.getUser.uid,
                          userProvider.getUser.username,
                          userProvider.getUser.photoUrl,
                        ),
                        icon: const Icon(Icons.check),
                      ),
                    ]
                  : [],
            ),
            body: isLoading
                ? const Center(child: CircularProgressIndicator())
                : file == null
                    ? Center(
                        child: IconButton(
                          onPressed: onFileUpload,
                          icon: const Icon(Icons.file_upload_outlined),
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          kVerticalSpaceRegular,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                foregroundImage: MemoryImage(file!),
                                radius: 55,
                                backgroundColor: Colors.grey[900],
                              ),
                              SizedBox(
                                width: kScreenWidth(context) * 0.65,
                                child: TextField(
                                  controller: _descriptionController,
                                  decoration: const InputDecoration(
                                    hintText: "Write a caption...",
                                    border: InputBorder.none,
                                  ),
                                  maxLines: 6,
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                        ],
                      ),
          );
  }
}
