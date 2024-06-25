import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyDivider extends Divider implements PreferredSizeWidget {
  MyDivider({
    super.key,
    super.height = 16.0,
    super.indent = 0.0,
    super.color,
  });

  @override
  late Size preferredSize = Size(double.infinity, height ?? 0);
}
