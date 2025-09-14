import 'package:flutter/material.dart';
import 'package:hr_srs/core/sizeconfig/size_config.dart';

class LogoContainerWidget extends StatelessWidget {
  const LogoContainerWidget({
    super.key,
    required this.height,
    required this.width,
  });
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ScreenSize.width / 20),
        image: DecorationImage(
            image: AssetImage("assets/logo.png"), fit: BoxFit.fill),
      ),
    );
  }
}
