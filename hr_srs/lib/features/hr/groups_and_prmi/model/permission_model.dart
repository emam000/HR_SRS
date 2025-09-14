class PermissionModel {
  final int? id;
  final String name;

  PermissionModel({
    this.id,
    required this.name,
  });

  factory PermissionModel.fromMap(Map<String, dynamic> map) {
    return PermissionModel(
      id: map['id'] as int?,
      name: map['name'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  PermissionModel copyWith({
    int? id,
    String? name,
  }) {
    return PermissionModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
