class GroupPermissionModel {
  final int groupId;
  final int permissionId;

  GroupPermissionModel({
    required this.groupId,
    required this.permissionId,
  });

  factory GroupPermissionModel.fromMap(Map<String, dynamic> map) {
    return GroupPermissionModel(
      groupId: map['group_id'] as int,
      permissionId: map['permission_id'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'group_id': groupId,
      'permission_id': permissionId,
    };
  }

  GroupPermissionModel copyWith({
    int? groupId,
    int? permissionId,
  }) {
    return GroupPermissionModel(
      groupId: groupId ?? this.groupId,
      permissionId: permissionId ?? this.permissionId,
    );
  }
}
