import 'package:flutter/widgets.dart';

class ColorGen {
  static const linearRed = [
    0xffF66700,
    0xffED3900,
  ];
  static const linearBlue = [
    0xff00ACF6,
    0xff006DED,
  ];
  static const linearGreen = [
    0xff1FDB5F,
    0xff31C764,
  ];
  static const listLinears = [linearBlue, linearGreen, linearRed];

  List<Color> getColorsFromNum(List<int> nums) {
    return nums.map((e) => Color(e)).toList();
  }
}
