import 'package:flutter/material.dart';
import 'package:hr_srs/core/sizeconfig/size_config.dart';

class SignInTextFromFieldWidget extends StatelessWidget {
  const SignInTextFromFieldWidget({
    super.key,
    required this.valText,
    required this.controller,
    required this.nKey,
    required this.obscureText,
    required this.hint,
    this.suffix,
  });
  final String valText;
  final TextEditingController controller;
  final bool obscureText;
  final GlobalKey<FormState> nKey;
  final String hint;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: nKey,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hint,
          suffix: suffix,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ScreenSize.width / 10),
          ),
        ),
        validator: (val) {
          if (val!.isEmpty) {
            return "من فضلك ادخل $valText";
          } else {
            return null;
          }
        },
      ),
    );
  }
}
