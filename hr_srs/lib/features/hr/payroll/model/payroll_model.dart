class PayrollModel {
  final int? id;
  final int employeeId;
  final String month;
  final double baseSalary;
  final double deductions;
  final double bonuses;
  final double netSalary;

  PayrollModel({
    required this.id,
    required this.employeeId,
    required this.month,
    required this.baseSalary,
    required this.deductions,
    required this.bonuses,
    required this.netSalary,
  });

  factory PayrollModel.fromMap(Map<String, dynamic> map) {
    return PayrollModel(
      id: map['id'] as int,
      employeeId: map['employee_id'] as int,
      month: map['month'] as String,
      baseSalary: (map['base_salary'] as num).toDouble(),
      deductions: (map['deductions'] as num).toDouble(),
      bonuses: (map['bonuses'] as num).toDouble(),
      netSalary: (map['net_salary'] as num).toDouble(),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'employee_id': employeeId,
      'month': month,
      'base_salary': baseSalary,
      'deductions': deductions,
      'bonuses': bonuses,
      'net_salary': netSalary,
    };
  }
}
