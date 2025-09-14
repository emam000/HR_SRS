import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_srs/core/sizeconfig/size_config.dart';
import 'package:hr_srs/features/hr/attendance/model/attendance_model.dart';
import 'package:hr_srs/features/hr/attendance/view_model/cubit/attendance_cubit.dart';
import 'package:hr_srs/generated/l10n.dart';

class AttendanceForEmplyeeView extends StatefulWidget {
  const AttendanceForEmplyeeView(
      {super.key, required this.employeeId, required this.employeeName});
  final int employeeId;
  final String employeeName;

  @override
  State<AttendanceForEmplyeeView> createState() =>
      _AttendanceForEmplyeeViewState();
}

class _AttendanceForEmplyeeViewState extends State<AttendanceForEmplyeeView> {
  @override
  void initState() {
    super.initState();
    context.read<AttendanceCubit>().getEmployeeAttendance(widget.employeeId);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 800) {
          return buildWideScreenWidgets(
              context: context,
              employeeId: widget.employeeId,
              employeeName: widget.employeeName);
        } else {
          return buildMobileWidget(
              context: context,
              employeeId: widget.employeeId,
              employeeName: widget.employeeName);
        }
      },
    );
  }
}

Widget buildWideScreenWidgets(
    {required BuildContext context,
    required int employeeId,
    required String employeeName}) {
  return Scaffold(
    appBar: AppBar(
      title: Text(
        S.of(context).attendance,
        style: TextStyle(fontSize: ScreenSize.width / 40),
      ),
    ),
    body: Padding(
      padding: EdgeInsets.all(ScreenSize.width / 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await context
                      .read<AttendanceCubit>()
                      .checkIn(employeeId, context);
                  await context
                      .read<AttendanceCubit>()
                      .getEmployeeAttendance(employeeId);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(S.of(context).checkinMessage),
                      backgroundColor: Colors.blue,
                    ),
                  );
                },
                child: Text(
                  S.of(context).login,
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  await context
                      .read<AttendanceCubit>()
                      .checkOut(employeeId, context);
                  await context
                      .read<AttendanceCubit>()
                      .getEmployeeAttendance(employeeId);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(S.of(context).CheckoutMessage),
                      backgroundColor: Colors.blue,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text(
                  S.of(context).logout,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: ScreenSize.height / 25),
          Expanded(
            child: BlocBuilder<AttendanceCubit, AttendanceState>(
              builder: (context, state) {
                if (state is AttendanceLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is AttendanceSuccess) {
                  final records = state.attendanceList;
                  if (records.isEmpty) {
                    return Center(child: Text(S.of(context).noAttendance));
                  }
                  return ListView.builder(
                    itemCount: records.length,
                    itemBuilder: (context, index) {
                      final AttendanceModel att = records[index];
                      return Card(
                        color: Colors.blue.shade100,
                        child: ListTile(
                          title: Text(
                            "📅 ${att.date}",
                            style: TextStyle(fontSize: ScreenSize.width / 50),
                          ),
                          subtitle: Text(
                            "${S.of(context).checkin}: ${att.checkIn} | ${S.of(context).checkout}: ${att.checkOut.isEmpty ? "لم يسجل" : att.checkOut}",
                            style: TextStyle(fontSize: ScreenSize.width / 60),
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is AttendanceError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildMobileWidget(
    {required BuildContext context,
    required int employeeId,
    required String employeeName}) {
  return Scaffold(
    appBar: AppBar(
      title: Text(
        S.of(context).attendance,
        style: TextStyle(fontSize: ScreenSize.width / 18),
      ),
    ),
    body: Padding(
      padding: EdgeInsets.all(ScreenSize.width / 30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await context
                      .read<AttendanceCubit>()
                      .checkIn(employeeId, context);
                  await context
                      .read<AttendanceCubit>()
                      .getEmployeeAttendance(employeeId);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(S.of(context).checkinMessage),
                      backgroundColor: Colors.blue,
                    ),
                  );
                },
                child: Text(S.of(context).login),
              ),
              ElevatedButton(
                onPressed: () async {
                  await context
                      .read<AttendanceCubit>()
                      .checkOut(employeeId, context);
                  await context
                      .read<AttendanceCubit>()
                      .getEmployeeAttendance(employeeId);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(S.of(context).CheckoutMessage),
                      backgroundColor: Colors.blue,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text(S.of(context).logout),
              ),
            ],
          ),
          SizedBox(height: ScreenSize.height / 25),
          Expanded(
            child: BlocBuilder<AttendanceCubit, AttendanceState>(
              builder: (context, state) {
                if (state is AttendanceLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is AttendanceSuccess) {
                  final records = state.attendanceList;
                  if (records.isEmpty) {
                    return Center(child: Text(S.of(context).noAttendance));
                  }
                  return ListView.builder(
                    itemCount: records.length,
                    itemBuilder: (context, index) {
                      final AttendanceModel att = records[index];
                      return Card(
                        color: Colors.blue.shade100,
                        child: ListTile(
                          title: Text("📅 ${att.date}"),
                          subtitle: Text(
                            "${S.of(context).checkin}: ${att.checkIn} | ${S.of(context).checkout}: ${att.checkOut.isEmpty ? "لم يسجل" : att.checkOut}",
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is AttendanceError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    ),
  );
}
