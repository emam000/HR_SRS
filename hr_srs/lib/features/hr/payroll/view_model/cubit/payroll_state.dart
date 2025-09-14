part of 'payroll_cubit.dart';

@immutable
sealed class PayrollState {}

final class PayrollInitial extends PayrollState {}

class PayrollLoading extends PayrollState {}

class PayrollSuccess extends PayrollState {
  final List<PayrollModel> payrolls;
  PayrollSuccess({required this.payrolls});
}

class PayrollError extends PayrollState {
  final String message;
  PayrollError({required this.message});
}

class PayrollAdded extends PayrollState {}

class PayrollUpdated extends PayrollState {}

class PayrollDeleted extends PayrollState {}
