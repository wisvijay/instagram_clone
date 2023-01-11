import 'package:flutter/material.dart';

import '../model/user.dart';
import '../resources/auth_methods.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getCurrentUserDetails();
    _user = user;
    notifyListeners();
  }
}
