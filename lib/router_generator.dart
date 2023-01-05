import 'package:flutter/material.dart';

import '/responsive/mobile_screen_layout.dart';
import '/responsive/responsive_layout_screen.dart';
import '/responsive/web_screen_layout.dart';
import '/screens/addpost_screen.dart';
import '/screens/home_screen.dart';
import '/screens/login_screen.dart';
import '/screens/profile_screen.dart';
import '/screens/signup_screen.dart';
import 'utils/constants.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case InitialRouteName:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case LoginRouteName:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case SignupRouteName:
        return MaterialPageRoute(builder: (context) => const SignupScreen());
      case AppScreenRouteName:
        return MaterialPageRoute(
          builder: (context) => const ResponsiveLayoutScreen(
            weblayout: WebScreenLayout(),
            mobilelayout: MobileScreenLayout(),
          ),
        );
      case HomeRouteName:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case AddPostRouteName:
        return MaterialPageRoute(builder: (context) => const AddPost());
      case ProfileRouteName:
        return MaterialPageRoute(builder: (context) => const ProfileScreen());
      default:
        return MaterialPageRoute(
          builder: (context) => const ResponsiveLayoutScreen(
            weblayout: WebScreenLayout(),
            mobilelayout: MobileScreenLayout(),
          ),
        );
    }
  }
}
