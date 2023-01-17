import 'package:flutter/material.dart';

import '../utils/constants.dart';

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
      title: const Text(createPostStr),
      children: [
        SimpleDialogOption(
          padding: const EdgeInsets.all(20),
          onPressed: takePhotoOption,
          child: const Text(takeaPostStr),
        ),
        SimpleDialogOption(
          padding: const EdgeInsets.all(20),
          onPressed: fromGalleryOption,
          child: const Text(choosegalleryStr),
        ),
        SimpleDialogOption(
          padding: const EdgeInsets.all(20),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(cancelStr),
        )
      ],
    );
  }
}
