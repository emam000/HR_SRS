import 'package:flutter/material.dart';
import 'package:hr_srs/core/widgets/headline_text_widget.dart';

class TitleCardInHRHomeWidget extends StatelessWidget {
  const TitleCardInHRHomeWidget({
    super.key,
    required this.title,
    required this.leading,
    required this.onTap,
    required this.fontSize,
  });
  final String title;
  final Widget? leading;
  final void Function()? onTap;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue,
      child: ListTile(
        leading: leading, // Icon(Icons.people),
        title: HeadlineTextWidget(
          title: title,
          fontSize: fontSize,
          textColor: Colors.white,
        ),
        onTap: onTap,
      ),
    );
  }
}
