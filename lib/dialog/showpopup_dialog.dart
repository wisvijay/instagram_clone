import 'package:flutter/material.dart';

class ShowPopupDialog extends StatelessWidget {
  final Function()? takePhotoOption;
  final Function()? fromGalleryOption;
  const ShowPopupDialog({
    super.key,
    required this.takePhotoOption,
    required this.fromGalleryOption,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Create a Post'),
      children: [
        SimpleDialogOption(
          padding: const EdgeInsets.all(20),
          onPressed: takePhotoOption,
          child: const Text('Take a Photo'),
        ),
        SimpleDialogOption(
          padding: const EdgeInsets.all(20),
          onPressed: fromGalleryOption,
          child: const Text('Choose from Gallery'),
        ),
        SimpleDialogOption(
          padding: const EdgeInsets.all(20),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        )
      ],
    );
  }
}
