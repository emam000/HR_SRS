import 'package:flutter/material.dart';
import 'package:hr_srs/core/sizeconfig/size_config.dart';

class CardEmployeeInfoWidget extends StatelessWidget {
  const CardEmployeeInfoWidget({super.key, required this.title, this.subtitle});
  final String title;
  final Widget? subtitle;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.shade100,
      margin: EdgeInsets.symmetric(vertical: ScreenSize.height / 120),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: subtitle,
      ),
    );
  }
}
