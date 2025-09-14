part of 'attendance_cubit.dart';

@immutable
sealed class AttendanceState {}

final class AttendanceInitial extends AttendanceState {}

class AttendanceLoading extends AttendanceState {}

class AttendanceSuccess extends AttendanceState {
  final List<AttendanceModel> attendanceList;
  final String? message;
  AttendanceSuccess({required this.attendanceList, this.message});
}

class AttendanceError extends AttendanceState {
  final String message;
  AttendanceError({required this.message});
}
