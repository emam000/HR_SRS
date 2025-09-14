import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_srs/core/sizeconfig/size_config.dart';
import 'package:hr_srs/features/hr/payroll/model/payroll_model.dart';
import 'package:hr_srs/features/hr/payroll/view_model/cubit/payroll_cubit.dart';
import 'package:hr_srs/generated/l10n.dart';

class PayrollForEmployeeView extends StatefulWidget {
  const PayrollForEmployeeView(
      {super.key, required this.employeeId, required this.employeeName});
  final int employeeId;
  final String employeeName;
  @override
  State<PayrollForEmployeeView> createState() => _PayrollForEmployeeViewState();
}

class _PayrollForEmployeeViewState extends State<PayrollForEmployeeView> {
  @override
  void initState() {
    super.initState();
    context.read<PayrollCubit>().getEmployeePayroll(widget.employeeId);
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
          return buildMobileWidgets(
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
        S.of(context).payroll,
        style: TextStyle(
          fontSize: ScreenSize.width / 40,
        ),
      ),
    ),
    body: Padding(
      padding: EdgeInsets.all(ScreenSize.width / 40),
      child: BlocBuilder<PayrollCubit, PayrollState>(
        builder: (context, state) {
          if (state is PayrollLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PayrollSuccess) {
            final payrolls = state.payrolls;
            if (payrolls.isEmpty) {
              return Center(child: Text(S.of(context).noPayoll));
            }
            return ListView.builder(
              padding: EdgeInsets.all(ScreenSize.width / 30),
              itemCount: payrolls.length,
              itemBuilder: (context, index) {
                final PayrollModel p = payrolls[index];
                return Card(
                  color: Colors.blue.shade100,
                  child: ListTile(
                    title: Text(
                      "📅 : ${p.month}",
                      style: TextStyle(
                        fontSize: ScreenSize.width / 50,
                      ),
                    ),
                    subtitle: Text(
                      "${S.of(context).baseSalary}: ${p.baseSalary}\n"
                      "${S.of(context).deductions}: ${p.deductions}\n"
                      "${S.of(context).bonuses}: ${p.bonuses}\n"
                      "${S.of(context).netSalary}: ${p.netSalary}",
                      style: TextStyle(fontSize: ScreenSize.width / 60),
                    ),
                  ),
                );
              },
            );
          } else if (state is PayrollError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    ),
  );
}

Widget buildMobileWidgets(
    {required BuildContext context,
    required int employeeId,
    required String employeeName}) {
  return Scaffold(
    appBar: AppBar(
        title: Text(
      S.of(context).payroll,
      style: TextStyle(
        fontSize: ScreenSize.width / 18,
      ),
    )),
    body: BlocBuilder<PayrollCubit, PayrollState>(
      builder: (context, state) {
        if (state is PayrollLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PayrollSuccess) {
          final payrolls = state.payrolls;
          if (payrolls.isEmpty) {
            return Center(child: Text(S.of(context).noPayoll));
          }
          return ListView.builder(
            padding: EdgeInsets.all(ScreenSize.width / 30),
            itemCount: payrolls.length,
            itemBuilder: (context, index) {
              final PayrollModel p = payrolls[index];
              return Card(
                color: Colors.blue.shade100,
                child: ListTile(
                  title: Text("📅 : ${p.month}"),
                  subtitle: Text(
                    "${S.of(context).baseSalary}: ${p.baseSalary}\n"
                    "${S.of(context).deductions}: ${p.deductions}\n"
                    "${S.of(context).bonuses}: ${p.bonuses}\n"
                    "${S.of(context).netSalary}: ${p.netSalary}",
                  ),
                ),
              );
            },
          );
        } else if (state is PayrollError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox();
      },
    ),
  );
}
