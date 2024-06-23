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
  static Color dividerColor = _Colors.stroke;
  static TextStyle homeIconProfileTextStyle = const TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 20,
    color: _Colors.white,
  );
  static TextStyle nameSurnameTextStyle = const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 15,
    color: _Colors.black,
  );
  static ThemeData get chatThemeData => ThemeData(
        scaffoldBackgroundColor: _Colors.white,
        brightness: Brightness.light,
        useMaterial3: false,
        fontFamily: 'Gilroy',
        splashColor: Colors.transparent,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 9, horizontal: 8),
          suffixIconColor: _Colors.gray,
          prefixIconColor: _Colors.gray,
          fillColor: _Colors.stroke,
          focusColor: _Colors.stroke,
          hoverColor: _Colors.stroke,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          hintStyle: const TextStyle(
            color: _Colors.gray,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
}

class _Colors {
  static const stroke = Color(0xffEDF2F6);
  static const white = Color(0xffFFFFFF);
  static const green = Color(0xff3CED78);
  static const darkGreen = Color(0xff00521C);
  static const gray = Color(0xff9DB7CB);
  static const darkGrey = Color(0xff5E7A90);
  static const black = Color(0xff2B333E);
}
