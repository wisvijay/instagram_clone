import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source);
  if (file != null) {
    return await file.readAsBytes();
  }
  print('No Image Selected');
}

showSnackBar(BuildContext context, String content) {
  return ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(content)));
}

String calculateTimeDifferenceBetween(DateTime startDate) {
  int seconds = DateTime.now().difference(startDate).inSeconds;
  if (seconds < 60) {
    return '$seconds second ago';
  } else if (seconds >= 60 && seconds < 3600) {
    return '${startDate.difference(DateTime.now()).inMinutes.abs()} minutes ago';
  } else if (seconds >= 3600 && seconds < 86400) {
    return '${startDate.difference(DateTime.now()).inHours} hours ago';
  } else {
    return '${startDate.difference(DateTime.now()).inDays} days ago';
  }
}
