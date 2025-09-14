import 'package:flutter/material.dart';
import 'package:hr_srs/core/sizeconfig/size_config.dart';
import 'package:hr_srs/features/employee/personal_info/view/widgets/card_employee_info_widget.dart';

class CardEmployeeInfoForWideScreenWidget extends StatelessWidget {
  const CardEmployeeInfoForWideScreenWidget({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: CardEmployeeInfoWidget(
            title: title,
          ),
        ),
        SizedBox(width: ScreenSize.width / 6),
        Expanded(
          child: CardEmployeeInfoWidget(
            title: value,
          ),
        ),
      ],
    );
  }
}
