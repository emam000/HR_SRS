import 'package:flutter/material.dart';
import 'package:hr_srs/core/sizeconfig/size_config.dart';

class NoEmployeeOrUserDataWidget extends StatelessWidget {
  const NoEmployeeOrUserDataWidget(
      {super.key, required this.textOne, required this.textTwo});
  final String textOne;
  final String textTwo;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(ScreenSize.width / 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.people_outline,
              size: ScreenSize.width / 5,
              color: Colors.blue,
            ),
            SizedBox(height: ScreenSize.height / 50),
            Text(textOne),
            SizedBox(height: ScreenSize.height / 80),
            Text(textTwo),
          ],
        ),
      ),
    );
  }
}
