import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hr_srs/core/database/database_helper.dart';
import 'package:hr_srs/features/hr/payroll/model/payroll_model.dart';
import 'package:hr_srs/generated/l10n.dart';
import 'package:meta/meta.dart';

part 'payroll_state.dart';

class PayrollCubit extends Cubit<PayrollState> {
  PayrollCubit() : super(PayrollInitial());

  Future<void> addPayroll(PayrollModel payroll) async {
    try {
      emit(PayrollLoading());
      await DatabaseHelper().insertPayroll(payroll);
      emit(PayrollAdded());

      final payrolls = await DatabaseHelper().getAllPayrolls();
      emit(PayrollSuccess(payrolls: payrolls));
    } catch (e) {
      emit(PayrollError(message: "فشل إضافة الراتب: $e"));
    }
  }

  Future<void> getAllPayrolls() async {
    try {
      emit(PayrollLoading());
      final payrolls = await DatabaseHelper().getAllPayrolls();
      emit(PayrollSuccess(payrolls: payrolls));
    } catch (e) {
      emit(PayrollError(message: "فشل تحميل الرواتب: $e"));
    }
  }

  Future<void> getPayrollsByEmployee(int employeeId) async {
    try {
      emit(PayrollLoading());
      final payrolls = await DatabaseHelper().getPayrollsByEmployee(employeeId);
      emit(PayrollSuccess(payrolls: payrolls));
    } catch (e) {
      emit(PayrollError(message: "فشل تحميل رواتب الموظف: $e"));
    }
  }

  Future<void> deletePayroll(int id) async {
    try {
      emit(PayrollLoading());
      await DatabaseHelper().deletePayroll(id);
      emit(PayrollDeleted());

      final payrolls = await DatabaseHelper().getAllPayrolls();
      emit(PayrollSuccess(payrolls: payrolls));
    } catch (e) {
      emit(PayrollError(message: "فشل حذف الراتب: $e"));
    }
  }

  Future<void> getEmployeePayroll(int employeeId) async {
    try {
      emit(PayrollLoading());
      final db = await DatabaseHelper().getDatabase();
      final result = await db.query(
        'payroll',
        where: 'employee_id = ?',
        whereArgs: [employeeId],
      );
      final payrolls = result.map((e) => PayrollModel.fromMap(e)).toList();
      emit(PayrollSuccess(payrolls: payrolls));
    } catch (e) {
      emit(PayrollError(message: "فشل تحميل بيانات الرواتب: $e"));
    }
  }

  void showAddPayrollDialog(
      BuildContext context, int employeeId, double baseSalary) {
    final monthController = TextEditingController();
    final deductionController = TextEditingController();
    final bonusController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(S.of(context).addBonusesOrDeductions),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: monthController,
                  decoration: InputDecoration(labelText: S.of(context).month),
                ),
                TextFormField(
                  controller: deductionController,
                  decoration:
                      InputDecoration(labelText: S.of(context).deductions),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: bonusController,
                  decoration: InputDecoration(labelText: S.of(context).bonuses),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(S.of(context).cancel),
            ),
            ElevatedButton(
              onPressed: () async {
                final deductions =
                    double.tryParse(deductionController.text) ?? 0.0;
                final bonuses = double.tryParse(bonusController.text) ?? 0.0;
                final netSalary = baseSalary - deductions + bonuses;

                final payroll = PayrollModel(
                  id: null,
                  employeeId: employeeId,
                  month: monthController.text,
                  baseSalary: baseSalary,
                  deductions: deductions,
                  bonuses: bonuses,
                  netSalary: netSalary,
                );
                Navigator.pop(ctx);
                await addPayroll(payroll);
                ScaffoldMessenger.of(ctx).showSnackBar(
                  SnackBar(
                    content: Text(S.of(ctx).addpayrollMessg),
                    backgroundColor: Colors.blue,
                  ),
                );
              },
              child: Text(S.of(context).save),
            ),
          ],
        );
      },
    );
  }
}
