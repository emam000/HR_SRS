part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class ChangeObscureTextSuccess extends AuthState {}

class SignInLoading extends AuthState {}

class SignInSuccess extends AuthState {
  final UserModel user;
  final EmployeeModel? employee;

  SignInSuccess({this.employee, required this.user});
}

class SignInError extends AuthState {
  final String message;

  SignInError({required this.message});
}
