import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_srs/core/sizeconfig/size_config.dart';
import 'package:hr_srs/features/hr/add_and%20_edit_employees/view_model/cubit/employee_cubit.dart';
import 'package:hr_srs/features/hr/payroll/view/widgets/get_all_employees_payroll_for_wide_screen_widget.dart';
import 'package:hr_srs/features/hr/payroll/view/widgets/get_all_employees_payroll_widget.dart';
import 'package:hr_srs/features/hr/payroll/view_model/cubit/payroll_cubit.dart';
import 'package:hr_srs/generated/l10n.dart';

class PayrollView extends StatefulWidget {
  const PayrollView({super.key});

  @override
  State<PayrollView> createState() => _PayrollViewState();
}

class _PayrollViewState extends State<PayrollView> {
  @override
  void initState() {
    super.initState();
    context.read<EmployeeCubit>().getAllEmployeesData();
    context.read<PayrollCubit>().getAllPayrolls();
  }

  @override
  Widget build(BuildContext context) {
    PayrollCubit payrollCubit = BlocProvider.of<PayrollCubit>(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= 600) {
          return buildMobileWidgets(
              context: context, payrollCubit: payrollCubit);
        } else {
          return buildWideScreenWidgets(
              context: context, payrollCubit: payrollCubit);
        }
      },
    );
  }
}

Widget buildWideScreenWidgets(
    {required BuildContext context, required PayrollCubit payrollCubit}) {
  return Scaffold(
    appBar: AppBar(
        title: Text(
      S.of(context).payroll,
      style: TextStyle(fontSize: ScreenSize.width / 40),
    )),
    body: Padding(
      padding: EdgeInsets.all(ScreenSize.width / 30),
      child: BlocBuilder<EmployeeCubit, EmployeeState>(
        builder: (context, empState) {
          if (empState is GetAllEmployeesSuccess) {
            final employees = empState.employees;

            return BlocBuilder<PayrollCubit, PayrollState>(
              builder: (context, payState) {
                if (payState is PayrollSuccess) {
                  final payrolls = payState.payrolls;

                  return GetAllEmployeesPayrollForWideScreenWidget(
                      employees: employees,
                      payrolls: payrolls,
                      payrollCubit: payrollCubit);
                } else if (payState is PayrollLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Center(child: Text(S.of(context).noPayoll));
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

Widget buildMobileWidgets(
    {required BuildContext context, required PayrollCubit payrollCubit}) {
  return Scaffold(
    appBar: AppBar(
      title: Text(
        S.of(context).payroll,
        style: TextStyle(fontSize: ScreenSize.width / 18),
      ),
    ),
    body: Padding(
      padding: EdgeInsets.all(ScreenSize.width / 30),
      child: BlocBuilder<EmployeeCubit, EmployeeState>(
        builder: (context, empState) {
          if (empState is GetAllEmployeesSuccess) {
            final employees = empState.employees;

            return BlocBuilder<PayrollCubit, PayrollState>(
              builder: (context, payState) {
                if (payState is PayrollSuccess) {
                  final payrolls = payState.payrolls;

                  return GetAllEmployeesPayrollWidget(
                      employees: employees,
                      payrolls: payrolls,
                      payrollCubit: payrollCubit);
                } else if (payState is PayrollLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Center(child: Text(S.of(context).noPayoll));
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
