import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hr_srs/core/database/database_helper.dart';
import 'package:hr_srs/features/hr/users/model/user_model.dart';
import 'package:meta/meta.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit() : super(UsersInitial());

  Future<void> getAllUsers() async {
    try {
      emit(UserLoading());
      final users = await DatabaseHelper().getAllUsers();
      emit(GetAllUsers(users: users));
    } catch (e) {
      emit(UserError(message: "فشل تحميل المستخدمين: $e"));
    }
  }

  Future<void> updateUser(UserModel user) async {
    try {
      await DatabaseHelper().updateUser(user);
      final employee = await DatabaseHelper().getEmployeeById(user.id!);
      if (employee != null) {
        final updatedEmployee = employee.copyWith(fullName: user.fullName);
        await DatabaseHelper().updateEmployee(updatedEmployee);
      }
      await getAllUsers();
    } catch (e) {
      emit(UserError(message: "فشل تعديل المستخدم: $e"));
    }
  }

  Future<void> deleteUser(int id) async {
    try {
      await DatabaseHelper().deleteUserById(id);
      await getAllUsers();
    } catch (e) {
      emit(UserError(message: "فشل حذف المستخدم: $e"));
    }
  }

  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late String? role;

  //! function for change role value ...

  void changingRolerValue(String? value) {
    role = value!;
    emit(ChangeRoleValueSuccess());
  }

  @override
  Future<void> close() {
    fullNameController.dispose();
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
