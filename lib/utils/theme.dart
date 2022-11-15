import 'package:flutter/material.dart';

const white = Colors.white;
const black = Colors.black;
const kMalachite = Color(0xff1bd760);
const kGhostWhite = Color(0xffd26042);
const kBrightGray = Color(0xffe9e9f2);
const kLavenderGray = Color(0xffbfbfce);

ThemeData get appTheme {
  return ThemeData(
    fontFamily: 'Gilroy',
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: kMalachite,
    cardColor: Colors.transparent,
    scaffoldBackgroundColor: white,
    appBarTheme: const AppBarTheme(
      backgroundColor: white,
      elevation: 0,
    ),
    bottomSheetTheme:
        BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0)),
  );
}
