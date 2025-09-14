import 'package:flutter/material.dart';
import 'package:hr_srs/features/hr/add_and%20_edit_employees/view/widgets/custom_text_form_field_widget.dart';
import 'package:hr_srs/features/hr/add_and%20_edit_employees/view_model/cubit/employee_cubit.dart';
import 'package:hr_srs/generated/l10n.dart';

class UserDataFieldWidget extends StatelessWidget {
  const UserDataFieldWidget({super.key, required this.employeeCubit});
  final EmployeeCubit employeeCubit;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormFieldWidget(
          labelText: S.of(context).fullName,
          controller: employeeCubit.fullNameController,
        ),
        TextFormField(
          controller: employeeCubit.emailController,
          decoration: InputDecoration(labelText: S.of(context).email),
          validator: (v) {
            if (employeeCubit.role == 'Employee') {
              if (v == null || v.trim().isEmpty) {
                return S.of(context).emailRequForEmpAcc;
              }

              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(v.trim())) {
                return S.of(context).validEmail;
              }
            }
            return null;
          },
        ),
        TextFormField(
          controller: employeeCubit.usernameController,
          decoration: InputDecoration(labelText: S.of(context).username),
          validator: (v) {
            if (employeeCubit.role == 'HR') {
              if (v == null || v.trim().isEmpty) {
                return S.of(context).userRequForHRAcc;
              }
            }
            return null;
          },
        ),
        CustomTextFormFieldWidget(
          labelText: S.of(context).password,
          controller: employeeCubit.passwordController,
        ),
        DropdownButtonFormField<String>(
          value: employeeCubit.role,
          items: [
            DropdownMenuItem(value: 'HR', child: Text(S.of(context).hr)),
            DropdownMenuItem(value: 'Employee', child: Text(S.of(context).emp)),
          ],
          onChanged: (value) {
            employeeCubit.changingRolerValue(value);
          },
          decoration: InputDecoration(labelText: S.of(context).groupsAndPerm),
        ),
      ],
    );
  }
}
