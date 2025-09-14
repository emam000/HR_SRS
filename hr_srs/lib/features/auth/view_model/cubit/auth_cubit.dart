import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hr_srs/core/database/database_helper.dart';
import 'package:hr_srs/features/hr/add_and%20_edit_employees/model/employee_model.dart';
import 'package:hr_srs/features/hr/users/model/user_model.dart';
import 'package:hr_srs/generated/l10n.dart';
import 'package:meta/meta.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  TextEditingController emailOrUsername = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> eKey = GlobalKey();
  GlobalKey<FormState> pKey = GlobalKey();
  bool passwordObscureText = true;
  void changeObscureText() {
    passwordObscureText = !passwordObscureText;
    emit(ChangeObscureTextSuccess());
  }

  Future<void> signIn(BuildContext context) async {
    if (emailOrUsername.text.isEmpty && password.text.isEmpty) {
      emit(SignInError(message: S.of(context).emptyEmailAndPass));
      return;
    }
    if (emailOrUsername.text.isEmpty) {
      emit(SignInError(message: S.of(context).emptyEmail));
      return;
    }
    if (password.text.isEmpty) {
      emit(SignInError(message: S.of(context).EmptyPassword));
      return;
    }

    try {
      emit(SignInLoading());

      final result = await DatabaseHelper().authenticateUser(
        identifier: emailOrUsername.text,
        password: password.text,
      );

      if (result != null) {
        final user = result['user'] as UserModel;
        final employee = result['employee'] as EmployeeModel?;

        emit(SignInSuccess(user: user, employee: employee));
      } else {
        emit(SignInError(
            message:
                "${S.of(context).validEmail} ${S.of(context).validPassword}"));
      }
    } catch (e) {
      emit(SignInError(message: "حدث خطأ غير متوقع: $e"));
      log(e.toString());
    }
  }

  @override
  Future<void> close() {
    emailOrUsername.dispose();
    password.dispose();
    return super.close();
  }
}
