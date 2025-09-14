import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_srs/core/sizeconfig/size_config.dart';
import 'package:hr_srs/features/hr/add_and%20_edit_employees/view/widgets/add_employee_button_widget.dart';
import 'package:hr_srs/features/hr/add_and%20_edit_employees/view/widgets/get_all_employees_for_wide_screen_widget.dart';
import 'package:hr_srs/features/hr/add_and%20_edit_employees/view/widgets/get_all_employees_widget.dart';
import 'package:hr_srs/features/hr/add_and%20_edit_employees/view/widgets/no_employee_or_user_data_widget.dart';
import 'package:hr_srs/features/hr/add_and%20_edit_employees/view_model/cubit/employee_cubit.dart';
import 'package:hr_srs/generated/l10n.dart';

class EmployeesView extends StatefulWidget {
  const EmployeesView({super.key});

  @override
  State<EmployeesView> createState() => _EmployeesViewState();
}

class _EmployeesViewState extends State<EmployeesView> {
  @override
  void initState() {
    super.initState();
    context.read<EmployeeCubit>().getAllEmployeesData();
  }

  @override
  Widget build(BuildContext context) {
    EmployeeCubit employeeCubit = BlocProvider.of<EmployeeCubit>(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= 600) {
          return buildMobileWidgets(
              context: context, employeeCubit: employeeCubit);
        }
        int crossAxisCount = 1;
        if (constraints.maxWidth > 600) {
          crossAxisCount = 2;
        }
        if (constraints.maxWidth > 900) {
          crossAxisCount = 3;
        }
        if (constraints.maxWidth > 1200) {
          crossAxisCount = 4;
        }

        return buildWideScreenWidgets(
          context: context,
          employeeCubit: employeeCubit,
          crossAxisCount: crossAxisCount,
        );
      },
    );
  }
}

Widget buildWideScreenWidgets(
    {required BuildContext context,
    required EmployeeCubit employeeCubit,
    required int crossAxisCount}) {
  return Scaffold(
    appBar: AppBar(
      title: Text(
        S.of(context).employee,
        style: TextStyle(fontSize: ScreenSize.width / 40),
      ),
    ),
    body: Padding(
      padding: EdgeInsets.all(ScreenSize.width / 30),
      child: BlocBuilder<EmployeeCubit, EmployeeState>(
        builder: (context, state) {
          if (state is GetAllEmployeesLoading) {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.blue,
            ));
          } else if (state is GetAllEmployeesSuccess) {
            final employee = state.employees;

            if (employee.isEmpty) {
              return NoEmployeeOrUserDataWidget(
                textOne: S.of(context).emptyEmployee,
                textTwo: S.of(context).addEmployee,
              );
            }

            return GetAllEmployeesForWideScreenWidget(
                crossAxisCount: crossAxisCount,
                employees: employee,
                employeeCubit: employeeCubit);
          } else if (state is EmployeesError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox();
          }
        },
      ),
    ),
    floatingActionButton: AddEmployeeButtonWidget(),
  );
}

Widget buildMobileWidgets(
    {required BuildContext context, required EmployeeCubit employeeCubit}) {
  return Scaffold(
    appBar: AppBar(
      title: Text(
        S.of(context).employee,
        style: TextStyle(fontSize: ScreenSize.width / 18),
      ),
    ),
    body: Padding(
      padding: EdgeInsets.all(ScreenSize.width / 30),
      child: BlocBuilder<EmployeeCubit, EmployeeState>(
        builder: (context, state) {
          if (state is GetAllEmployeesLoading) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.blue,
            ));
          } else if (state is GetAllEmployeesSuccess) {
            if (state.employees.isEmpty) {
              return NoEmployeeOrUserDataWidget(
                textOne: S.of(context).emptyEmployee,
                textTwo: S.of(context).toAddEmployee,
              );
            }
            return GetAllEmployeesWidget(
              employeeCubit: employeeCubit,
              employees: state.employees,
            );
          } else if (state is EmployeesError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    ),
    floatingActionButton: AddEmployeeButtonWidget(),
  );
}
