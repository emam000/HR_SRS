part of 'users_cubit.dart';

@immutable
sealed class UsersState {}

final class UsersInitial extends UsersState {}

class UserLoading extends UsersState {}

class GetAllUsers extends UsersState {
  final List<UserModel> users;

  GetAllUsers({required this.users});
}

class UserError extends UsersState {
  final String message;

  UserError({required this.message});
}

class ChangeRoleValueSuccess extends UsersState {}
