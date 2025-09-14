class EmployeeModel {
  final int? id;
  final String fullName;
  final String nationalId;
  final String gender;
  final String birthDate;
  final String nationality;
  final String phone;
  final String address;
  final String joinDate;
  final String department;
  final double baseSalary;
  final String workStart;
  final String workEnd;

  EmployeeModel({
    this.id,
    required this.fullName,
    required this.nationalId,
    required this.gender,
    required this.birthDate,
    required this.nationality,
    required this.phone,
    required this.address,
    required this.joinDate,
    required this.department,
    required this.baseSalary,
    required this.workStart,
    required this.workEnd,
  });
  factory EmployeeModel.fromMap(Map<String, dynamic> map) {
    return EmployeeModel(
      id: map['id'] as int,
      fullName: map['full_name'] as String,
      nationalId: map['national_id'] as String,
      birthDate: map['birth_date'] as String,
      gender: map['gender'] as String,
      nationality: map['nationality'] as String,
      phone: map['phone'] as String,
      address: map['address'] as String,
      joinDate: map['join_date'] as String,
      department: map['department'] as String,
      baseSalary: (map['base_salary'] as num).toDouble(),
      workStart: map['work_start'] as String,
      workEnd: map['work_end'] as String,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_name': fullName,
      'national_id': nationalId,
      'birth_date': birthDate,
      'gender': gender,
      'nationality': nationality,
      'phone': phone,
      'address': address,
      'join_date': joinDate,
      'department': department,
      'base_salary': baseSalary,
      'work_start': workStart,
      'work_end': workEnd,
    };
  }

  EmployeeModel copyWith({
    int? id,
    String? fullName,
    String? nationalId,
    String? gender,
    String? birthDate,
    String? nationality,
    String? phone,
    String? address,
    String? joinDate,
    String? department,
    double? baseSalary,
    String? workStart,
    String? workEnd,
  }) {
    return EmployeeModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      nationalId: nationalId ?? this.nationalId,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      nationality: nationality ?? this.nationality,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      joinDate: joinDate ?? this.joinDate,
      department: department ?? this.department,
      baseSalary: baseSalary ?? this.baseSalary,
      workStart: workStart ?? this.workStart,
      workEnd: workEnd ?? this.workEnd,
    );
  }
}
