import 'package:flutter/material.dart';
import 'package:hr_srs/features/hr/add_and%20_edit_employees/model/employee_model.dart';
import 'package:hr_srs/features/hr/add_and%20_edit_employees/view/edit_employee_view.dart';
import 'package:hr_srs/features/hr/add_and%20_edit_employees/view_model/cubit/employee_cubit.dart';
import 'package:hr_srs/generated/l10n.dart';

class GetAllEmployeesWidget extends StatelessWidget {
  const GetAllEmployeesWidget({
    super.key,
    required this.employeeCubit,
    required this.employees,
  });

  final EmployeeCubit employeeCubit;
  final List<EmployeeModel> employees;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: employees.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final employee = employees[index];
        final name = employee.fullName;
        final dept = employee.department;
        final phone = employee.phone;

        return Card(
          color: Colors.blue.shade100,
          child: ListTile(
            title: Text(name),
            subtitle: Text('$dept • $phone'),
            onTap: () {},
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditEmployeeView(
                                  employee: employees[index],
                                )));
                  },
                  tooltip: 'تعديل',
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () async {
                    await employeeCubit.deleteEmployee(employee.id!);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(S.of(context).deleteEmployee),
                      backgroundColor: Colors.blue,
                    ));
                  },
                  tooltip: 'حذف',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
