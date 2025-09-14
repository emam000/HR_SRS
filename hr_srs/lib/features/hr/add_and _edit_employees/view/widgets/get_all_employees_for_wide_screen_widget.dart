import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_srs/core/sizeconfig/size_config.dart';
import 'package:hr_srs/features/hr/add_and%20_edit_employees/model/employee_model.dart';
import 'package:hr_srs/features/hr/add_and%20_edit_employees/view/edit_employee_view.dart';
import 'package:hr_srs/features/hr/add_and%20_edit_employees/view_model/cubit/employee_cubit.dart';
import 'package:hr_srs/generated/l10n.dart';

class GetAllEmployeesForWideScreenWidget extends StatelessWidget {
  const GetAllEmployeesForWideScreenWidget(
      {super.key,
      required this.employeeCubit,
      required this.employees,
      required this.crossAxisCount});
  final EmployeeCubit employeeCubit;
  final List<EmployeeModel> employees;
  final int crossAxisCount;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ScreenSize.width / 50),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: crossAxisCount == 2 ? 2 : 1.8,
        ),
        itemCount: employees.length,
        itemBuilder: (context, index) {
          final employee = employees[index];
          return _buildEmployeeCard(context, employee, index);
        },
      ),
    );
  }
}

Widget _buildEmployeeCard(
    BuildContext context, EmployeeModel employee, int index) {
  return Card(
    color: Colors.blue.shade100,
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: EdgeInsets.all(ScreenSize.width / 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            employee.fullName,
            style: Theme.of(context).textTheme.bodyLarge,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: ScreenSize.height / 200),
          Text(
            employee.department,
            style: Theme.of(context).textTheme.bodyMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            employee.phone,
            style: Theme.of(context).textTheme.bodyMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: ScreenSize.height / 200),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditEmployeeView(
                                employee: employee,
                              )));
                },
                icon: Icon(
                  Icons.edit,
                  size: ScreenSize.width / 60,
                  color: Colors.blue,
                ),
                label: Text(S.of(context).edit,
                    style: TextStyle(
                        fontSize: ScreenSize.width / 90,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue)),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  await context
                      .read<EmployeeCubit>()
                      .deleteEmployee(employee.id!);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(S.of(context).deleteEmployee),
                    backgroundColor: Colors.blue,
                  ));
                },
                icon: Icon(
                  Icons.delete,
                  size: ScreenSize.width / 60,
                  color: Colors.red,
                ),
                label: Text(S.of(context).delete,
                    style: TextStyle(
                        fontSize: ScreenSize.width / 90,
                        fontWeight: FontWeight.bold,
                        color: Colors.red)),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
