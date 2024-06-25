import 'package:flutter/material.dart';

class ChatTheme {
  static const TextStyle lastMessageDateTextStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: _Colors.darkGray,
  );
  static const TextStyle selfMessageTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: _Colors.darkGreen,
  );
  static const Color selfMessageColor = _Colors.green;
  static const TextStyle recvMessageTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: _Colors.black,
  );
  static const Color recvMessageColor = _Colors.stroke;

  static const TextStyle homePageTitleTextSyle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: _Colors.black,
  );
  static const Color dividerColor = _Colors.stroke;
  static const TextStyle dividerMessagesTextStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: _Colors.gray,
  );
  static const TextStyle homeIconProfileTextStyle = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 20,
    color: _Colors.white,
  );
  static const TextStyle nameSurnameTextStyle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 15,
    color: _Colors.black,
  );
  static const TextStyle timeSelfMessageTextStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 12,
    color: _Colors.darkGreen,
  );
  static const attachIconsColor = _Colors.black;
  static const Color attachColor = _Colors.stroke;
  static const TextStyle timeRecvMessageTextStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 12,
    color: _Colors.black,
  );
  static const TextStyle onlineIndicatorTextStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 12,
    color: _Colors.darkGray,
  );
  static const TextStyle selfLastMessageTextStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 12,
    color: _Colors.black,
  );
  static const TextStyle lastMessageTextStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 12,
    color: _Colors.darkGray,
  );
  static ThemeData get chatThemeData => ThemeData(
        scaffoldBackgroundColor: _Colors.white,
        appBarTheme: const AppBarTheme(
          shadowColor: Colors.transparent,
          backgroundColor: _Colors.white,
          actionsIconTheme: IconThemeData(
            color: _Colors.black,
          ),
          iconTheme: IconThemeData(
            color: _Colors.black,
          ),
        ),
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
  static const darkGray = Color(0xff5E7A90);
  static const black = Color(0xff2B333E);
}
