import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_srs/core/sizeconfig/size_config.dart';
import 'package:hr_srs/features/hr/add_and%20_edit_employees/model/employee_model.dart';
import 'package:hr_srs/features/hr/attendance/model/attendance_model.dart';
import 'package:hr_srs/features/hr/attendance/view_model/cubit/attendance_cubit.dart';
import 'package:hr_srs/generated/l10n.dart';

class GetAllEmployeesAttendanceWidget extends StatelessWidget {
  const GetAllEmployeesAttendanceWidget({
    super.key,
    required this.employees,
    required this.attendanceList,
  });

  final List<EmployeeModel> employees;
  final List<AttendanceModel> attendanceList;

  @override
  Widget build(BuildContext context) {
    AttendanceCubit attendanceCubit = BlocProvider.of<AttendanceCubit>(context);
    return Expanded(
      child: ListView.builder(
        itemCount: employees.length,
        itemBuilder: (context, index) {
          final emp = employees[index];
          final empAttendance =
              attendanceList.where((a) => a.employeeId == emp.id).toList();

          return Card(
            color: Colors.blue.shade100,
            child: ExpansionTile(
              title: Text(
                emp.fullName,
                style: TextStyle(
                  fontSize: ScreenSize.width / 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text("${S.of(context).department}: ${emp.department}"),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await attendanceCubit.checkIn(emp.id!, context);
                      },
                      child: Text(S.of(context).login),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await attendanceCubit.checkOut(emp.id!, context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: Text(S.of(context).logout),
                    ),
                  ],
                ),
                SizedBox(height: ScreenSize.height / 40),
                if (empAttendance.isEmpty)
                  ListTile(title: Text(S.of(context).noAttendance))
                else
                  ...empAttendance.map((a) {
                    return ListTile(
                      title: Text(" ${a.date}"),
                      subtitle: Text(
                        "${S.of(context).checkin}: ${a.checkIn} | ${S.of(context).checkout}: ${a.checkOut.isEmpty ? "لم يسجل" : a.checkOut}",
                      ),
                    );
                  }),
              ],
            ),
          );
        },
      ),
    );
  }
}
