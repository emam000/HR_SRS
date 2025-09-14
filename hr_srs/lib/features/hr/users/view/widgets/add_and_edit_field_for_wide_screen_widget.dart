import 'package:flutter/material.dart';
import 'package:hr_srs/core/sizeconfig/size_config.dart';

class AddAndEditFieldForWideScreenWidget extends StatelessWidget {
  const AddAndEditFieldForWideScreenWidget({
    super.key,
    required this.title,
    required this.controller,
    required this.validator,
  });
  final String title;
  final TextEditingController controller;
  final String? Function(String?) validator;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: ScreenSize.width / 5,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.blue,
              fontSize: ScreenSize.width / 50,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: ScreenSize.width / 8),
        SizedBox(
          width: ScreenSize.width / 2,
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
            validator: validator,
          ),
        ),
      ],
    );
  }
}
