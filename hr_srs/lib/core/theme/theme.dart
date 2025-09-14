import 'package:flutter/material.dart';
import 'package:hr_srs/core/sizeconfig/size_config.dart';

ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: Color(0xFFFFFFFF),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.blue,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    shadowColor: Colors.blue,
    elevation: ScreenSize.width / 70,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  ),
);
