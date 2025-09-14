import 'package:flutter/material.dart';
import 'package:hr_srs/features/hr/add_and%20_edit_employees/view/widgets/custom_text_form_field_widget.dart';
import 'package:hr_srs/features/hr/add_and%20_edit_employees/view_model/cubit/employee_cubit.dart';
import 'package:hr_srs/generated/l10n.dart';

class EmployeeDataFieldWidget extends StatelessWidget {
  const EmployeeDataFieldWidget({super.key, required this.employeeCubit});
  final EmployeeCubit employeeCubit;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormFieldWidget(
          labelText: S.of(context).nationalID,
          controller: employeeCubit.nationalIdController,
        ),
        CustomTextFormFieldWidget(
          labelText: S.of(context).phoneNumber,
          controller: employeeCubit.phoneController,
          keyboardType: TextInputType.phone,
        ),
        CustomTextFormFieldWidget(
          labelText: S.of(context).department,
          controller: employeeCubit.departmentController,
        ),
        CustomTextFormFieldWidget(
          labelText: S.of(context).address,
          controller: employeeCubit.addressController,
        ),
        CustomTextFormFieldWidget(
          labelText: S.of(context).nationality,
          controller: employeeCubit.nationalityController,
        ),
        CustomTextFormFieldWidget(
          labelText: S.of(context).salary,
          controller: employeeCubit.salaryController,
          keyboardType: TextInputType.number,
        ),
        TextField(
          enabled: false,
          decoration:
              InputDecoration(label: Text(S.of(context).workTimeStartAt)),
        ),
        TextField(
          enabled: false,
          decoration: InputDecoration(label: Text(S.of(context).workTimeEndAt)),
        ),
        DropdownButtonFormField<String>(
            value: employeeCubit.gender,
            decoration: InputDecoration(labelText: S.of(context).gender),
            items: [
              DropdownMenuItem(value: "ذكر", child: Text(S.of(context).male)),
              DropdownMenuItem(
                  value: "انثي", child: Text(S.of(context).female)),
            ],
            onChanged: (value) {
              employeeCubit.changingGenderValue(value);
            }),
        ListTile(
          title: Text(employeeCubit.birthDate == null
              ? S.of(context).chooseBirthday
              : "${S.of(context).dateOfBirth}: ${employeeCubit.birthDate!.toString().substring(0, 10)}"),
          trailing: const Icon(Icons.calendar_today),
          onTap: () async {
            employeeCubit.pickedBirthDate(context);
          },
        ),
        ListTile(
          title: Text(employeeCubit.joinDate == null
              ? S.of(context).chooseJoinDate
              : "${S.of(context).joinDate}: ${employeeCubit.joinDate!.toString().substring(0, 10)}"),
          trailing: const Icon(Icons.calendar_today),
          onTap: () async {
            employeeCubit.pickedJoinDate(context);
          },
        ),
      ],
    );
  }
}
