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
  DateTime endDate = DateTime.now();
  int seconds = endDate.difference(startDate).inSeconds;
  if (seconds < 60) {
    return '$seconds second ago';
  } else if (seconds >= 60 && seconds < 3600) {
    return '${endDate.difference(startDate).inMinutes.abs()} minutes ago';
  } else if (seconds >= 3600 && seconds < 86400) {
    return '${endDate.difference(startDate).inHours} hours ago';
  } else {
    return '${endDate.difference(startDate).inDays} days ago';
  }
}
