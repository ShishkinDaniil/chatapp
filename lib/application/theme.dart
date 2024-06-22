import 'package:flutter/material.dart';

class ChatTheme {
  static TextStyle selfMessageTextStyle = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: _Colors.darkGreen,
  );
  static TextStyle recvMessageTextStyle = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: _Colors.black,
  );
  static TextStyle homePageTitleTextSyle = const TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: _Colors.black,
  );
  static ThemeData get chatThemeData => ThemeData(
        brightness: Brightness.light,
        useMaterial3: false,
        fontFamily: 'Gilroy',
      );
}

class _Colors {
  static const white = Color(0xffEDF2F6);
  static const stroke = Color(0xffFFFFFF);
  static const green = Color(0xff3CED78);
  static const darkGreen = Color(0xff00521C);
  static const gray = Color(0xff9DB7CB);
  static const darkGrey = Color(0xff5E7A90);
  static const black = Color(0xff2B333E);
}
