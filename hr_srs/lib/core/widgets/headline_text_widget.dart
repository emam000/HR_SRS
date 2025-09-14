import 'package:flutter/material.dart';

class HeadlineTextWidget extends StatelessWidget {
  const HeadlineTextWidget({
    super.key,
    required this.title,
    required this.textColor,
    required this.fontSize,
  });
  final String title;
  final Color textColor;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
