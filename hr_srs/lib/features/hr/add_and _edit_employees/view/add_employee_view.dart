import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_srs/core/sizeconfig/size_config.dart';
import 'package:hr_srs/features/hr/add_and%20_edit_employees/model/employee_model.dart';
import 'package:hr_srs/features/hr/add_and%20_edit_employees/view/widgets/add_employee_for_wide_screen_widget.dart';
import 'package:hr_srs/features/hr/add_and%20_edit_employees/view/widgets/add_employee_widget.dart';
import 'package:hr_srs/features/hr/add_and%20_edit_employees/view_model/cubit/employee_cubit.dart';
import 'package:hr_srs/features/hr/users/model/user_model.dart';
import 'package:hr_srs/generated/l10n.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AddEmployeeView extends StatefulWidget {
  const AddEmployeeView({super.key});

  @override
  State<AddEmployeeView> createState() => _AddEmployeeViewState();
}

class _AddEmployeeViewState extends State<AddEmployeeView> {
  @override
  Widget build(BuildContext context) {
    EmployeeCubit employeeCubit = BlocProvider.of<EmployeeCubit>(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= 800) {
          return buildMobileWidgets(employeeCubit: employeeCubit);
        } else {
          return buildWideScreenWidgets(employeeCubit: employeeCubit);
        }
      },
    );
  }
}

Widget buildWideScreenWidgets({required EmployeeCubit employeeCubit}) {
  return BlocConsumer<EmployeeCubit, EmployeeState>(
    listener: (context, state) {
      if (state is GetAllEmployeesSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("تم اضافة الموظف بنجاح"),
            backgroundColor: Colors.blue,
          ),
        );
        Navigator.pop(context);
        clearAllTextField(employeeCubit: employeeCubit);
      } else if (state is EmployeesError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message),
            backgroundColor: Colors.red,
          ),
        );
      }
    },
    builder: (context, state) {
      return ModalProgressHUD(
        inAsyncCall: state is GetAllEmployeesLoading,
        color: Colors.blue,
        child: Scaffold(
          appBar: AppBar(
              title: Text(
            S.of(context).addEmployee,
            style: TextStyle(fontSize: ScreenSize.width / 40),
          )),
          body: AddEmployeeForWideScreenWidget(
            employeeCubit: employeeCubit,
          ),
        ),
      );
    },
  );
}

Widget buildMobileWidgets({required EmployeeCubit employeeCubit}) {
  return BlocConsumer<EmployeeCubit, EmployeeState>(
    listener: (context, state) {
      if (state is GetAllEmployeesSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context).addEmployeesuccess),
            backgroundColor: Colors.blue,
          ),
        );
        Navigator.pop(context);
        clearAllTextField(employeeCubit: employeeCubit);
      } else if (state is EmployeesError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message),
            backgroundColor: Colors.red,
          ),
        );
      }
    },
    builder: (context, state) {
      return ModalProgressHUD(
        inAsyncCall: state is GetAllEmployeesLoading,
        color: Colors.blue,
        child: Scaffold(
          appBar: AppBar(
              title: Text(
            S.of(context).addEmployee,
            style: TextStyle(fontSize: ScreenSize.width / 18),
          )),
          body: AddEmployeeWidget(
            fontSize: ScreenSize.width / 15,
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
                  baseSalary: double.parse(employeeCubit.salaryController.text),
                  workStart: "09:00",
                  workEnd: "05:00",
                );
                await employeeCubit.addEployee(employee: employee);
              }
            },
          ),
        ),
      );
    },
  );
}

void clearAllTextField({required EmployeeCubit employeeCubit}) {
  employeeCubit.fullNameController.clear();
  employeeCubit.nationalIdController.clear();
  employeeCubit.phoneController.clear();
  employeeCubit.departmentController.clear();
  employeeCubit.addressController.clear();
  employeeCubit.nationalityController.clear();
  employeeCubit.salaryController.clear();
  employeeCubit.emailController.clear();
  employeeCubit.usernameController.clear();
  employeeCubit.passwordController.clear();
  employeeCubit.role = "Employee";
  employeeCubit.gender = "ذكر";
  employeeCubit.birthDate = null;
  employeeCubit.joinDate = null;
}
