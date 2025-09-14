import 'package:flutter/material.dart';
import 'package:hr_srs/core/sizeconfig/size_config.dart';
import 'package:hr_srs/core/widgets/headline_text_widget.dart';
import 'package:hr_srs/features/hr/add_and%20_edit_employees/view/widgets/employee_data_field_widget.dart';
import 'package:hr_srs/features/hr/add_and%20_edit_employees/view/widgets/save_button_widget.dart';
import 'package:hr_srs/features/hr/add_and%20_edit_employees/view/widgets/user_data_field_widget.dart';
import 'package:hr_srs/features/hr/add_and%20_edit_employees/view_model/cubit/employee_cubit.dart';
import 'package:hr_srs/generated/l10n.dart';

class AddEmployeeWidget extends StatelessWidget {
  const AddEmployeeWidget({
    super.key,
    required this.employeeCubit,
    required this.onPressed,
    required this.fontSize,
  });

  final EmployeeCubit employeeCubit;
  final void Function() onPressed;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ScreenSize.width / 15),
      child: Form(
        key: employeeCubit.formKey,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeadlineTextWidget(
                title: S.of(context).loginData,
                fontSize: ScreenSize.width / 21,
                textColor: Colors.blue,
              ),
              UserDataFieldWidget(employeeCubit: employeeCubit),
              SizedBox(height: ScreenSize.height / 30),
              HeadlineTextWidget(
                title: S.of(context).employeeData,
                fontSize: ScreenSize.width / 21,
                textColor: Colors.blue,
              ),
              EmployeeDataFieldWidget(employeeCubit: employeeCubit),
              SaveButtonWidget(
                fontSize: fontSize,
                employeeCubit: employeeCubit,
                onPressed: onPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
