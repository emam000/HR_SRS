import 'package:flutter/material.dart';
import 'package:hr_srs/core/sizeconfig/size_config.dart';
import 'package:hr_srs/features/hr/add_and%20_edit_employees/model/employee_model.dart';
import 'package:hr_srs/features/hr/add_and%20_edit_employees/view/widgets/save_button_widget.dart';
import 'package:hr_srs/features/hr/add_and%20_edit_employees/view_model/cubit/employee_cubit.dart';
import 'package:hr_srs/features/hr/users/model/user_model.dart';
import 'package:hr_srs/features/hr/users/view/widgets/add_and_edit_field_for_wide_screen_widget.dart';
import 'package:hr_srs/generated/l10n.dart';

class AddEmployeeForWideScreenWidget extends StatelessWidget {
  const AddEmployeeForWideScreenWidget({
    super.key,
    required this.employeeCubit,
  });
  final EmployeeCubit employeeCubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ScreenSize.width / 30),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          key: employeeCubit.formKey,
          child: Column(
            children: [
              SizedBox(height: ScreenSize.height / 25),
              Text(
                S.of(context).addEmployee,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: ScreenSize.width / 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              AddAndEditFieldForWideScreenWidget(
                title: S.of(context).fullName,
                controller: employeeCubit.fullNameController,
                validator: (value) => value == null || value.isEmpty
                    ? S.of(context).requiredField
                    : null,
              ),
              AddAndEditFieldForWideScreenWidget(
                  title: S.of(context).email,
                  controller: employeeCubit.emailController,
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
                  }),
              AddAndEditFieldForWideScreenWidget(
                title: S.of(context).username,
                controller: employeeCubit.usernameController,
                validator: (v) {
                  if (employeeCubit.role == 'HR') {
                    if (v == null || v.trim().isEmpty) {
                      return S.of(context).userRequForHRAcc;
                    }
                  }
                  return null;
                },
              ),
              AddAndEditFieldForWideScreenWidget(
                title: S.of(context).password,
                controller: employeeCubit.passwordController,
                validator: (value) => value == null || value.isEmpty
                    ? S.of(context).requiredField
                    : null,
              ),
              Row(
                children: [
                  SizedBox(
                    width: ScreenSize.width / 5,
                    child: Text(
                      S.of(context).department,
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
                    child: DropdownButtonFormField<String>(
                      value: employeeCubit.role,
                      items: [
                        DropdownMenuItem(
                            value: 'HR', child: Text(S.of(context).hr)),
                        DropdownMenuItem(
                            value: 'Employee', child: Text(S.of(context).emp)),
                      ],
                      onChanged: (value) {
                        employeeCubit.changingRolerValue(value);
                      },
                      decoration:
                          InputDecoration(labelText: S.of(context).role),
                    ),
                  ),
                ],
              ),
              SizedBox(height: ScreenSize.height / 25),
              Text(
                S.of(context).employeeData,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: ScreenSize.width / 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              AddAndEditFieldForWideScreenWidget(
                title: S.of(context).nationalID,
                controller: employeeCubit.nationalIdController,
                validator: (value) => value == null || value.isEmpty
                    ? S.of(context).requiredField
                    : null,
              ),
              AddAndEditFieldForWideScreenWidget(
                title: S.of(context).phoneNumber,
                controller: employeeCubit.phoneController,
                validator: (value) => value == null || value.isEmpty
                    ? S.of(context).requiredField
                    : null,
              ),
              AddAndEditFieldForWideScreenWidget(
                title: S.of(context).department,
                controller: employeeCubit.departmentController,
                validator: (value) => value == null || value.isEmpty
                    ? S.of(context).requiredField
                    : null,
              ),
              AddAndEditFieldForWideScreenWidget(
                title: S.of(context).address,
                controller: employeeCubit.addressController,
                validator: (value) => value == null || value.isEmpty
                    ? S.of(context).requiredField
                    : null,
              ),
              AddAndEditFieldForWideScreenWidget(
                title: S.of(context).nationality,
                controller: employeeCubit.nationalityController,
                validator: (value) => value == null || value.isEmpty
                    ? S.of(context).requiredField
                    : null,
              ),
              AddAndEditFieldForWideScreenWidget(
                title: S.of(context).salary,
                controller: employeeCubit.salaryController,
                validator: (value) => value == null || value.isEmpty
                    ? S.of(context).requiredField
                    : null,
              ),
              Row(
                children: [
                  SizedBox(
                    width: ScreenSize.width / 5,
                    child: Text(
                      S.of(context).workStart,
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
                    child: TextField(
                      enabled: false,
                      decoration: InputDecoration(
                          label: Text(S.of(context).workTimeStartAt)),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: ScreenSize.width / 5,
                    child: Text(
                      S.of(context).workEnd,
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
                    child: TextField(
                      enabled: false,
                      decoration: InputDecoration(
                          label: Text(S.of(context).workTimeEndAt)),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: ScreenSize.width / 5,
                    child: Text(
                      S.of(context).gender,
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
                    child: DropdownButtonFormField<String>(
                        value: employeeCubit.gender,
                        decoration:
                            InputDecoration(labelText: S.of(context).gender),
                        items: [
                          DropdownMenuItem(
                              value: "ذكر", child: Text(S.of(context).male)),
                          DropdownMenuItem(
                              value: "انثي", child: Text(S.of(context).female)),
                        ],
                        onChanged: (value) {
                          employeeCubit.changingGenderValue(value);
                        }),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: ScreenSize.width / 5,
                    child: Text(
                      S.of(context).dateOfBirth,
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
                    child: ListTile(
                      title: Text(employeeCubit.birthDate == null
                          ? S.of(context).chooseBirthday
                          : "${S.of(context).dateOfBirth}: ${employeeCubit.birthDate!.toString().substring(0, 10)}"),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: () async {
                        employeeCubit.pickedBirthDate(context);
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: ScreenSize.width / 5,
                    child: Text(
                      S.of(context).joinDate,
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
                    child: ListTile(
                      title: Text(employeeCubit.joinDate == null
                          ? S.of(context).chooseJoinDate
                          : "${S.of(context).joinDate}: ${employeeCubit.joinDate!.toString().substring(0, 10)}"),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: () async {
                        employeeCubit.pickedJoinDate(context);
                      },
                    ),
                  ),
                ],
              ),
              SaveButtonWidget(
                  fontSize: ScreenSize.width / 35,
                  employeeCubit: employeeCubit,
                  onPressed: () async {
                    if (employeeCubit.formKey.currentState!.validate()) {
                      final user = UserModel(
                          email: employeeCubit.emailController.text,
                          username: employeeCubit.usernameController.text,
                          id: null,
                          groupId: employeeCubit.role == 'HR' ? 1 : 2,
                          fullName: employeeCubit.fullNameController.text,
                          role: employeeCubit.role!,
                          password: employeeCubit.passwordController.text,
                          createdAt: DateTime.now().toIso8601String());
                      final employee = EmployeeModel(
                        id: await employeeCubit.addUser(user: user),
                        fullName: employeeCubit.fullNameController.text,
                        nationalId: employeeCubit.nationalIdController.text,
                        birthDate: employeeCubit.birthDate!.toIso8601String(),
                        gender: employeeCubit.gender!,
                        nationality: employeeCubit.nationalityController.text,
                        phone: employeeCubit.phoneController.text,
                        address: employeeCubit.addressController.text,
                        joinDate: employeeCubit.joinDate!.toIso8601String(),
                        department: employeeCubit.departmentController.text,
                        baseSalary:
                            double.parse(employeeCubit.salaryController.text),
                        workStart: "09:00",
                        workEnd: "05:00",
                      );
                      await employeeCubit.addEployee(employee: employee);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
