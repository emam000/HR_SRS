class UserModel {
  final int? id;
  final int groupId;
  final String fullName;
  final String role;
  final String? username;
  final String? email;
  final String password;
  final String createdAt;

  UserModel({
    required this.id,
    required this.groupId,
    required this.fullName,
    required this.role,
    this.username,
    this.email,
    required this.password,
    required this.createdAt,
  });
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int,
      groupId: map['group_id'] as int,
      fullName: map['full_name'] as String,
      role: map['role'] as String,
      username: map['username'] as String?,
      email: map['email'] as String?,
      password: map['password'] as String,
      createdAt: map['created_at'] as String,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'group_id': groupId,
      'full_name': fullName,
      'role': role,
      'username': username,
      'email': email,
      'password': password,
      'created_at': createdAt,
    };
  }

  UserModel copyWith({
    int? id,
    int? groupId,
    String? fullName,
    String? role,
    String? username,
    String? email,
    String? password,
    String? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      fullName: fullName ?? this.fullName,
      role: role ?? this.role,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
