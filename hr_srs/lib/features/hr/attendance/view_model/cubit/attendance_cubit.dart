import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hr_srs/core/database/database_helper.dart';
import 'package:hr_srs/features/hr/attendance/model/attendance_model.dart';
import 'package:hr_srs/generated/l10n.dart';
import 'package:meta/meta.dart';

part 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  AttendanceCubit() : super(AttendanceInitial());

  Future<void> getAllAttendance() async {
    try {
      emit(AttendanceLoading());
      final data = await DatabaseHelper().getAllAttendance();
      emit(AttendanceSuccess(attendanceList: data));
    } catch (e) {
      emit(AttendanceError(message: "فشل تحميل الحضور: $e"));
    }
  }

  Future<void> getEmployeeAttendance(int employeeId) async {
    try {
      emit(AttendanceLoading());
      final records =
          await DatabaseHelper().getAttendanceByEmployeeId(employeeId);
      emit(AttendanceSuccess(attendanceList: records));
    } catch (e) {
      emit(AttendanceError(message: "فشل في تحميل سجلات الموظف: $e"));
    }
  }

  //! check in  ...
  Future<void> checkIn(int employeeId, BuildContext context) async {
    try {
      final today = DateTime.now().toIso8601String().split("T").first;
      final records =
          await DatabaseHelper().getAttendanceByDateRange(today, today);
      final existing =
          records.where((a) => a.employeeId == employeeId).toList();

      if (existing.isEmpty) {
        final now = DateTime.now();
        final newAttendance = AttendanceModel(
          id: null,
          employeeId: employeeId,
          date: today,
          checkIn: "${now.hour}:${now.minute}",
          checkOut: "",
        );
        await DatabaseHelper().insertAttendance(newAttendance);

        final data = await DatabaseHelper().getAllAttendance();
        emit(AttendanceSuccess(
            attendanceList: data, message: S.of(context).checkinMessage));
      } else {
        final data = await DatabaseHelper().getAllAttendance();
        emit(AttendanceSuccess(
            attendanceList: data, message: S.of(context).alredayChekin));
      }
    } catch (e) {
      emit(AttendanceError(message: "فشل تسجيل الدخول: $e"));
    }
  }

  //! check out  ...

  Future<void> checkOut(int employeeId, BuildContext context) async {
    try {
      final today = DateTime.now().toIso8601String().split("T").first;
      final records =
          await DatabaseHelper().getAttendanceByDateRange(today, today);
      final existing =
          records.where((a) => a.employeeId == employeeId).toList();

      if (existing.isNotEmpty) {
        final attendance = existing.first;

        if (attendance.checkOut.isEmpty) {
          final now = DateTime.now();
          final updated = attendance.copyWith(
            checkOut: "${now.hour}:${now.minute}",
          );

          await DatabaseHelper().updateAttendance(updated);

          final data = await DatabaseHelper().getAllAttendance();
          emit(AttendanceSuccess(
              attendanceList: data, message: S.of(context).CheckoutMessage));
        } else {
          final data = await DatabaseHelper().getAllAttendance();
          emit(AttendanceSuccess(
              attendanceList: data, message: S.of(context).alredayChekout));
        }
      } else {
        final data = await DatabaseHelper().getAllAttendance();
        emit(AttendanceSuccess(
            attendanceList: data, message: S.of(context).NoCheckintoday));
      }
    } catch (e) {
      emit(AttendanceError(message: "فشل تسجيل الخروج: $e"));
    }
  }
}
