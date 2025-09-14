import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_srs/core/sizeconfig/size_config.dart';
import 'package:hr_srs/features/hr/add_and%20_edit_employees/model/employee_model.dart';
import 'package:hr_srs/features/hr/add_and%20_edit_employees/view/widgets/custom_text_form_field_widget.dart';
import 'package:hr_srs/features/hr/add_and%20_edit_employees/view/widgets/save_button_widget.dart';
import 'package:hr_srs/features/hr/add_and%20_edit_employees/view_model/cubit/employee_cubit.dart';
import 'package:hr_srs/features/hr/users/view/widgets/add_and_edit_field_for_wide_screen_widget.dart';
import 'package:hr_srs/generated/l10n.dart';

class EditEmployeeView extends StatefulWidget {
  const EditEmployeeView({super.key, required this.employee});

  final EmployeeModel employee;

  @override
  State<EditEmployeeView> createState() => _EditEmployeeViewState();
}

class _EditEmployeeViewState extends State<EditEmployeeView> {
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    context.read<EmployeeCubit>().fullNameController.text =
        widget.employee.fullName;
    context.read<EmployeeCubit>().nationalIdController.text =
        widget.employee.nationalId;
    context.read<EmployeeCubit>().phoneController.text = widget.employee.phone;
    context.read<EmployeeCubit>().departmentController.text =
        widget.employee.department;
    context.read<EmployeeCubit>().addressController.text =
        widget.employee.address;
    context.read<EmployeeCubit>().nationalityController.text =
        widget.employee.nationality;
    context.read<EmployeeCubit>().salaryController.text =
        widget.employee.baseSalary.toString();
    context.read<EmployeeCubit>().gender = widget.employee.gender;
    context.read<EmployeeCubit>().joinDate =
        DateTime.parse(widget.employee.joinDate);
    context.read<EmployeeCubit>().birthDate =
        DateTime.parse(widget.employee.birthDate);
  }

  @override
  Widget build(BuildContext context) {
    EmployeeCubit employeeCubit = BlocProvider.of<EmployeeCubit>(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= 800) {
          return buildMobileWidgets(
              formKey: formKey,
              context: context,
              employee: widget.employee,
              employeeCubit: employeeCubit);
        } else {
          return buildWideScreenWidgets(
              formKey: formKey,
              context: context,
              employee: widget.employee,
              employeeCubit: employeeCubit);
        }
      },
    );
  }
}

Widget buildWideScreenWidgets(
    {required BuildContext context,
    required EmployeeModel employee,
    required EmployeeCubit employeeCubit,
    required GlobalKey<FormState> formKey}) {
  return Scaffold(
    appBar: AppBar(
      title: Text(
        S.of(context).editEmployeeData,
        style: TextStyle(fontSize: ScreenSize.width / 40),
      ),
    ),
    body: Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.all(ScreenSize.width / 30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AddAndEditFieldForWideScreenWidget(
                title: S.of(context).fullName,
                controller: employeeCubit.fullNameController,
                validator: (value) => value == null || value.isEmpty
                    ? S.of(context).requiredField
                    : null,
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
                        value: employee.gender,
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
                    if (formKey.currentState!.validate()) {
                      final updatedEmployee = EmployeeModel(
                        id: employee.id,
                        workStart: "09:00",
                        workEnd: "05:00",
                        birthDate: employeeCubit.birthDate.toString(),
                        gender: employeeCubit.gender!,
                        joinDate: employeeCubit.joinDate.toString(),
                        fullName: employeeCubit.fullNameController.text,
                        nationalId: employeeCubit.nationalIdController.text,
                        phone: employeeCubit.phoneController.text,
                        address: employeeCubit.addressController.text,
                        department: employeeCubit.departmentController.text,
                        baseSalary:
                            double.parse(employeeCubit.salaryController.text),
                        nationality: employeeCubit.nationalityController.text,
                      );

                      await employeeCubit.updateEmployee(updatedEmployee);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(S.of(context).saveChangesSucces),
                          backgroundColor: Colors.blue,
                        ),
                      );
                      Navigator.pop(context);
                    }
                  }),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget buildMobileWidgets(
    {required BuildContext context,
    required EmployeeModel employee,
    required EmployeeCubit employeeCubit,
    required GlobalKey<FormState> formKey}) {
  return Scaffold(
    appBar: AppBar(
      title: Text(
        S.of(context).editEmployeeData,
        style: TextStyle(fontSize: ScreenSize.width / 18),
      ),
    ),
    body: Padding(
      padding: EdgeInsets.all(ScreenSize.width / 15),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              CustomTextFormFieldWidget(
                labelText: S.of(context).fullName,
                controller: employeeCubit.fullNameController,
              ),
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
                decoration:
                    InputDecoration(label: Text(S.of(context).workTimeEndAt)),
              ),
              DropdownButtonFormField<String>(
                  value: employee.gender,
                  decoration: InputDecoration(labelText: S.of(context).gender),
                  items: [
                    DropdownMenuItem(
                        value: "ذكر", child: Text(S.of(context).male)),
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
              SaveButtonWidget(
                  fontSize: ScreenSize.width / 15,
                  employeeCubit: employeeCubit,
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      final updatedEmployee = EmployeeModel(
                        id: employee.id,
                        workStart: "09:00",
                        workEnd: "05:00",
                        birthDate: employeeCubit.birthDate.toString(),
                        gender: employeeCubit.gender!,
                        joinDate: employeeCubit.joinDate.toString(),
                        fullName: employeeCubit.fullNameController.text,
                        nationalId: employeeCubit.nationalIdController.text,
                        phone: employeeCubit.phoneController.text,
                        address: employeeCubit.addressController.text,
                        department: employeeCubit.departmentController.text,
                        baseSalary:
                            double.parse(employeeCubit.salaryController.text),
                        nationality: employeeCubit.nationalityController.text,
                      );

                      await employeeCubit.updateEmployee(updatedEmployee);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(S.of(context).saveChangesSucces),
                          backgroundColor: Colors.blue,
                        ),
                      );
                      Navigator.pop(context);
                    }
                  }),
            ],
          ),
        ),
      ),
    ),
  );
}
