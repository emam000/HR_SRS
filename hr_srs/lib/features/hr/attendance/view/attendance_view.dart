import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_srs/core/sizeconfig/size_config.dart';
import 'package:hr_srs/core/widgets/headline_text_widget.dart';
import 'package:hr_srs/features/hr/add_and%20_edit_employees/view_model/cubit/employee_cubit.dart';
import 'package:hr_srs/features/hr/attendance/view/widgets/get_all_employees_attendance_for_wide_screen_widget.dart';
import 'package:hr_srs/features/hr/attendance/view/widgets/get_all_employees_attendance_widget.dart';
import 'package:hr_srs/features/hr/attendance/view_model/cubit/attendance_cubit.dart';
import 'package:hr_srs/generated/l10n.dart';

class AttendanceView extends StatefulWidget {
  const AttendanceView({super.key});

  @override
  State<AttendanceView> createState() => _AttendanceViewState();
}

class _AttendanceViewState extends State<AttendanceView> {
  @override
  void initState() {
    super.initState();
    context.read<EmployeeCubit>().getAllEmployeesData();
    context.read<AttendanceCubit>().getAllAttendance();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= 600) {
          return buildMobileWidgets(context: context);
        } else {
          return buildWideScreenWidgets(context: context);
        }
      },
    );
  }
}

Widget buildWideScreenWidgets({required BuildContext context}) {
  return Scaffold(
    appBar: AppBar(
      title: Text(
        S.of(context).attendance,
        style: TextStyle(fontSize: ScreenSize.width / 40),
      ),
    ),
    body: Padding(
      padding: EdgeInsets.all(ScreenSize.width / 30),
      child: BlocBuilder<EmployeeCubit, EmployeeState>(
        builder: (context, empState) {
          if (empState is GetAllEmployeesSuccess) {
            final employees = empState.employees;

            return BlocConsumer<AttendanceCubit, AttendanceState>(
              listener: (context, attState) {
                if (attState is AttendanceSuccess && attState.message != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(attState.message!),
                      backgroundColor: Colors.blue,
                    ),
                  );
                } else if (attState is AttendanceError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(attState.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, attState) {
                if (attState is AttendanceSuccess) {
                  return Padding(
                    padding: EdgeInsets.all(ScreenSize.width / 20),
                    child: Column(
                      children: [
                        HeadlineTextWidget(
                          title: S.of(context).attndenceTitle,
                          fontSize: ScreenSize.width / 40,
                          textColor: Colors.blue,
                        ),
                        SizedBox(height: ScreenSize.height / 50),
                        GetAllEmployeesAttendanceForWideScreenWidget(
                          employees: employees,
                          attendanceList: attState.attendanceList,
                        ),
                      ],
                    ),
                  );
                } else if (attState is AttendanceLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Center(child: Text(S.of(context).noAttendance));
                }
              },
            );
          } else if (empState is GetAllEmployeesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Center(child: Text(S.of(context).emptyEmployee));
          }
        },
      ),
    ),
  );
}

Widget buildMobileWidgets({required BuildContext context}) {
  return Scaffold(
    appBar: AppBar(
      title: Text(
        S.of(context).attendance,
        style: TextStyle(fontSize: ScreenSize.width / 18),
      ),
    ),
    body: Padding(
      padding: EdgeInsets.all(ScreenSize.width / 30),
      child: BlocBuilder<EmployeeCubit, EmployeeState>(
        builder: (context, empState) {
          if (empState is GetAllEmployeesSuccess) {
            final employees = empState.employees;

            return BlocConsumer<AttendanceCubit, AttendanceState>(
              listener: (context, attState) {
                if (attState is AttendanceSuccess && attState.message != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(attState.message!),
                      backgroundColor: Colors.blue,
                    ),
                  );
                } else if (attState is AttendanceError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(attState.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, attState) {
                if (attState is AttendanceSuccess) {
                  return Column(
                    children: [
                      HeadlineTextWidget(
                        title: S.of(context).attndenceTitle,
                        fontSize: ScreenSize.width / 21,
                        textColor: Colors.blue,
                      ),
                      SizedBox(height: ScreenSize.height / 50),
                      GetAllEmployeesAttendanceWidget(
                          employees: employees,
                          attendanceList: attState.attendanceList),
                    ],
                  );
                } else if (attState is AttendanceLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Center(child: Text(S.of(context).noAttendance));
                }
              },
            );
          } else if (empState is GetAllEmployeesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Center(child: Text(S.of(context).emptyEmployee));
          }
        },
      ),
    ),
  );
}
