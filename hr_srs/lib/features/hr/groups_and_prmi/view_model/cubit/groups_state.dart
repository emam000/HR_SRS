part of 'groups_cubit.dart';

class OperationResult {
  final bool success;
  final String message;
  OperationResult({required this.success, required this.message});
}

@immutable
sealed class GroupsState {}

final class GroupsInitial extends GroupsState {}

class GroupsLoading extends GroupsState {}

class GroupsLoaded extends GroupsState {
  final List<GroupModel> groups;
  final List<PermissionModel> permissions;
  final Map<int, List<int>> groupPermissions;

  GroupsLoaded({
    required this.groups,
    required this.permissions,
    required this.groupPermissions,
  });
}

class GroupsError extends GroupsState {
  final String message;
  GroupsError({required this.message});
}
