import 'package:flutter/material.dart';
import 'package:hr_srs/features/hr/add_and%20_edit_employees/model/employee_model.dart';
import 'package:hr_srs/features/hr/payroll/model/payroll_model.dart';
import 'package:hr_srs/features/hr/payroll/view_model/cubit/payroll_cubit.dart';
import 'package:hr_srs/generated/l10n.dart';

class GetAllEmployeesPayrollWidget extends StatelessWidget {
  const GetAllEmployeesPayrollWidget({
    super.key,
    required this.employees,
    required this.payrolls,
    required this.payrollCubit,
  });

  final List<EmployeeModel> employees;
  final List<PayrollModel> payrolls;
  final PayrollCubit payrollCubit;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: employees.length,
      itemBuilder: (context, index) {
        final emp = employees[index];
        final empPayrolls =
            payrolls.where((p) => p.employeeId == emp.id).toList();
        return Card(
          color: Colors.blue.shade100,
          child: ExpansionTile(
            title: Text(
              emp.fullName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
                "${S.of(context).department}: ${emp.department} | ${S.of(context).baseSalary}: ${emp.baseSalary} ج.م"),
            trailing: IconButton(
              icon: const Icon(Icons.add, color: Colors.green),
              onPressed: () {
                payrollCubit.showAddPayrollDialog(
                    context, emp.id!, emp.baseSalary);
              },
            ),
            children: empPayrolls.isEmpty
                ? [ListTile(title: Text(S.of(context).toAddPayroll))]
                : empPayrolls.map((p) {
                    return ListTile(
                      title: Text("📅 ${p.month}"),
                      subtitle: Text(
                          "${S.of(context).baseSalary}: ${p.baseSalary} | ${S.of(context).netSalary}: ${p.netSalary}"),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          await payrollCubit.deletePayroll(p.id!);
                          await payrollCubit.getAllPayrolls();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(S.of(context).deleteMessgPayroll),
                              backgroundColor: Colors.blue,
                            ),
                          );
                        },
                      ),
                    );
                  }).toList(),
          ),
        );
      },
    );
  }
}
