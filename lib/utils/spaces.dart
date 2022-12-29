import 'package:flutter/material.dart';

const appLayoutMobileWidth = 600;

const kHorizontalSpaceTiny = SizedBox(width: 5);
const kHorizontalSpaceSmall = SizedBox(width: 10);
const kHorizontalSpaceMedium = SizedBox(width: 15);
const kHorizontalSpaceRegular = SizedBox(width: 20);
const kHorizontalSpaceLarge = SizedBox(width: 30);

const kVerticalSpaceTiny = SizedBox(height: 5);
const kVerticalSpaceSmall = SizedBox(height: 10);
const kVerticalSpaceMedium = SizedBox(height: 15);
const kVerticalSpaceRegular = SizedBox(height: 20);
const kVerticalSpaceLarge = SizedBox(height: 30);

double kScreenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double kScreenHeight(BuildContext context) =>
    MediaQuery.of(context).size.height;
