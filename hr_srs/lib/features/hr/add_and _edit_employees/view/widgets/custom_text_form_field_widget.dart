import 'package:flutter/material.dart';

class CustomTextFormFieldWidget extends StatelessWidget {
  const CustomTextFormFieldWidget({
    super.key,
    required this.labelText,
    this.controller,
    this.keyboardType,
  });

  final String labelText;
  final TextEditingController? controller;

  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
      ),
      validator: (value) =>
          value == null || value.isEmpty ? "هذا الحقل مطلوب" : null,
    );
  }
}
