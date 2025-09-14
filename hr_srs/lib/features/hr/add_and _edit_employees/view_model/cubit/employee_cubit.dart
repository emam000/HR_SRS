import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hr_srs/core/database/database_helper.dart';
import 'package:hr_srs/features/hr/add_and%20_edit_employees/model/employee_model.dart';
import 'package:hr_srs/features/hr/users/model/user_model.dart';
import 'package:meta/meta.dart';

part 'employee_state.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  EmployeeCubit() : super(EmployeeInitial());

  Future<void> getAllEmployeesData() async {
    try {
      emit(GetAllEmployeesLoading());
      final List<EmployeeModel> employees =
          await DatabaseHelper().getAllEmployees();
      emit(GetAllEmployeesSuccess(employees: employees));
    } catch (e) {
      emit(EmployeesError(message: "فشل تحميل الموظفين: $e"));
    }
  }

  Future<int> addUser({required UserModel user}) async {
    try {
      emit(AddUserLoading());
      final userId = await DatabaseHelper().insertUser(user);
      emit(AddUserSuccess());
      log("addddd user :$userId ");
      return userId;
    } catch (e) {
      emit(AddUserError(message: "فشل إضافة المستخدم: $e"));
      throw Exception("فشل إضافة المستخدم: $e");
    }
  }

  Future<void> addEployee({required EmployeeModel employee}) async {
    try {
      emit(GetAllEmployeesLoading());

      await DatabaseHelper().insertEmployee(employee);

      final employees = await DatabaseHelper().getAllEmployees();
      emit(GetAllEmployeesSuccess(employees: employees));
      log("done add emploooo");
    } catch (e) {
      emit(EmployeesError(message: "فشل إضافة الموظف $e"));
    }
  }

  Future<void> updateEmployee(EmployeeModel employee) async {
    try {
      await DatabaseHelper().updateEmployee(employee);
      final user = await DatabaseHelper().getUserById(employee.id!);
      if (user != null) {
        final updatedUser = user.copyWith(fullName: employee.fullName);
        await DatabaseHelper().updateUser(updatedUser);
      }
      await getAllEmployeesData();
    } catch (e) {
      emit(EmployeesError(message: "فشل تعديل الموظف: $e"));
    }
  }

  Future<void> deleteEmployee(int id) async {
    try {
      await DatabaseHelper().deleteUserById(id);

      final employees = await DatabaseHelper().getAllEmployees();
      emit(GetAllEmployeesSuccess(employees: employees));
    } catch (e) {
      emit(EmployeesError(message: "فشل حذف الموظف: $e"));
    }
  }

  //! add employee ///////////
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? role;
  TextEditingController nationalIdController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  DateTime? birthDate;
  DateTime? joinDate;
  String? gender;
//! function for pick join date ...
  void pickedJoinDate(BuildContext context) async {
    final pick = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (pick != null) {
      joinDate = pick;
      emit(ChangeDateValueSuccess());
    }
  }
//! function for pick birth date ...

  void pickedBirthDate(BuildContext context) async {
    final pick = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pick != null) {
      birthDate = pick;
      emit(ChangeDateValueSuccess());
    }
  }
//! function for change gender value ...

  void changingGenderValue(String? value) {
    gender = value!;
    emit(ChangeGenderValueSuccess());
  }
  //! function for change role value ...

  void changingRolerValue(String? value) {
    role = value!;
    emit(ChangeRoleValueSuccess());
  }
}
