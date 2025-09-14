part of 'employee_cubit.dart';

@immutable
sealed class EmployeeState {}

final class EmployeeInitial extends EmployeeState {}

final class AddUserLoading extends EmployeeState {}

final class AddUserSuccess extends EmployeeState {}

final class AddUserError extends EmployeeState {
  final String message;

  AddUserError({required this.message});
}

final class GetAllEmployeesLoading extends EmployeeState {}

final class GetAllEmployeesSuccess extends EmployeeState {
  final List<EmployeeModel> employees;

  GetAllEmployeesSuccess({required this.employees});
}

final class EmployeesError extends EmployeeState {
  final String message;

  EmployeesError({required this.message});
}

class ChangeGenderValueSuccess extends EmployeeState {}

class ChangeDateValueSuccess extends EmployeeState {}

class ChangeRoleValueSuccess extends EmployeeState {}
