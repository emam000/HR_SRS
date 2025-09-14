class AttendanceModel {
  final int? id;
  final int employeeId;
  final String date;
  final String checkIn;
  final String checkOut;

  AttendanceModel({
    this.id,
    required this.employeeId,
    required this.date,
    required this.checkIn,
    required this.checkOut,
  });

  factory AttendanceModel.fromMap(Map<String, dynamic> map) {
    return AttendanceModel(
      id: map['id'] as int?,
      employeeId: map['employee_id'] as int,
      date: map['date'] as String,
      checkIn: map['check_in'] as String,
      checkOut: map['check_out'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'employee_id': employeeId,
      'date': date,
      'check_in': checkIn,
      'check_out': checkOut,
    };
  }

  AttendanceModel copyWith({
    int? id,
    int? employeeId,
    String? date,
    String? checkIn,
    String? checkOut,
  }) {
    return AttendanceModel(
      id: id ?? this.id,
      employeeId: employeeId ?? this.employeeId,
      date: date ?? this.date,
      checkIn: checkIn ?? this.checkIn,
      checkOut: checkOut ?? this.checkOut,
    );
  }
}
