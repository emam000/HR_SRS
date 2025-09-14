import 'package:flutter/material.dart';
import 'package:hr_srs/core/sizeconfig/size_config.dart';

class SubHeadlineTextWidget extends StatelessWidget {
  const SubHeadlineTextWidget({
    super.key,
    required this.title,
    required this.color,
  });
  final String title;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: ScreenSize.width / 25,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
