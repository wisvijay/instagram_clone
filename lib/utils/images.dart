import 'package:flutter_svg/svg.dart';

import 'color.dart';

class AppImages {
  static const profileImg = 'https://i.stack.imgur.com/l60Hf.png';

  static const storyImg =
      'https://cdn.pixabay.com/photo/2016/07/05/16/53/leaves-1498985__340.jpg';

  static SvgPicture getLogo(double height) {
    return SvgPicture.asset(
      'assets/instagram.svg',
      height: height,
      color: primaryColor,
    );
  }
}
