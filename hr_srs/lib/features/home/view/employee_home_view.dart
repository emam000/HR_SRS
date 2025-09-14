import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_srs/core/locale/cubit/locale_cubit.dart';
import 'package:hr_srs/core/sizeconfig/size_config.dart';
import 'package:hr_srs/features/employee/employee_atendance/view/attendance_for_emplyee_view.dart';
import 'package:hr_srs/features/employee/employee_payroll/view/payroll_for_employee_view.dart';
import 'package:hr_srs/features/employee/personal_info/view/employee_info_view.dart';
import 'package:hr_srs/features/hr/add_and%20_edit_employees/model/employee_model.dart';
import 'package:hr_srs/features/auth/view/sign_in_view.dart';
import 'package:hr_srs/features/home/view/widgets/title_card_in_hr_home_widget.dart';
import 'package:hr_srs/generated/l10n.dart';

class EmployeeHomeView extends StatelessWidget {
  const EmployeeHomeView({
    super.key,
    required this.employee,
  });
  final EmployeeModel employee;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 800) {
          return buildWideScreenWidgets(context: context, employee: employee);
        } else {
          return buildMobileWidgets(context: context, employee: employee);
        }
      },
    );
  }
}

Widget buildWideScreenWidgets(
    {required BuildContext context, required EmployeeModel employee}) {
  return Scaffold(
    appBar: AppBar(
      title: Text(
        S.of(context).homeTitle,
        style: TextStyle(fontSize: ScreenSize.width / 40),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(
            left: context.read<LocaleCubit>().isArabic()
                ? ScreenSize.width / 40
                : 0,
            right: context.read<LocaleCubit>().isArabic()
                ? 0
                : ScreenSize.width / 40,
          ),
          child: BlocBuilder<LocaleCubit, LocaleState>(
            builder: (context, state) {
              return DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: state is ChangeLocaleSuccess
                      ? state.locale.languageCode
                      : null,
                  icon: const Icon(Icons.language, color: Colors.white),
                  dropdownColor: Colors.blue.shade100,
                  items: const [
                    DropdownMenuItem(
                      value: "en",
                      child: Text("English "),
                    ),
                    DropdownMenuItem(
                      value: "ar",
                      child: Text("العربية"),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      context.read<LocaleCubit>().changeLocale(value);
                    }
                  },
                ),
              );
            },
          ),
        ),
      ],
    ),
    body: Row(
      children: [
        SizedBox(
          width: ScreenSize.width / 6,
          child: NavigationRail(
            backgroundColor: Colors.blue.shade50,
            selectedIndex: null,
            // onDestinationSelected: null,
            labelType: NavigationRailLabelType.all,
            leading: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                S.of(context).homeTitle,
                style: TextStyle(
                  fontSize: ScreenSize.width / 50,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            destinations: [
              NavigationRailDestination(
                disabled: true,
                icon: Icon(Icons.people),
                label: Text(S.of(context).myData),
              ),
              NavigationRailDestination(
                disabled: true,
                icon: Icon(Icons.access_time),
                label: Text(S.of(context).attendance),
              ),
              NavigationRailDestination(
                disabled: true,
                icon: Icon(Icons.money),
                label: Text(S.of(context).payroll),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(ScreenSize.width / 30),
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 50,
                mainAxisSpacing: 50,
                childAspectRatio: 6.5,
              ),
              children: [
                TitleCardInHRHomeWidget(
                  title: S.of(context).myData,
                  fontSize: ScreenSize.width / 50,
                  leading: const Icon(Icons.people),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EmployeeInfoView(employee: employee)));
                  },
                ),
                TitleCardInHRHomeWidget(
                  title: S.of(context).attendance,
                  fontSize: ScreenSize.width / 50,
                  leading: const Icon(Icons.access_time),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AttendanceForEmplyeeView(
                                employeeId: employee.id!,
                                employeeName: employee.fullName)));
                  },
                ),
                TitleCardInHRHomeWidget(
                  title: S.of(context).payroll,
                  fontSize: ScreenSize.width / 50,
                  leading: const Icon(Icons.attach_money),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PayrollForEmployeeView(
                                employeeId: employee.id!,
                                employeeName: employee.fullName)));
                  },
                ),
                TitleCardInHRHomeWidget(
                  title: S.of(context).logout,
                  fontSize: ScreenSize.width / 50,
                  leading: const Icon(Icons.logout),
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => SignInView()),
                      (Route route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildMobileWidgets(
    {required BuildContext context, required EmployeeModel employee}) {
  return Scaffold(
    appBar: AppBar(
      title: Text(
        S.of(context).homeTitle,
        style: TextStyle(fontSize: ScreenSize.width / 18),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(
            left: context.read<LocaleCubit>().isArabic()
                ? ScreenSize.width / 20
                : 0,
            right: context.read<LocaleCubit>().isArabic()
                ? 0
                : ScreenSize.width / 20,
          ),
          child: BlocBuilder<LocaleCubit, LocaleState>(
            builder: (context, state) {
              return DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: state is ChangeLocaleSuccess
                      ? state.locale.languageCode
                      : null,
                  icon: const Icon(Icons.language, color: Colors.white),
                  dropdownColor: Colors.blue.shade100,
                  items: const [
                    DropdownMenuItem(
                      value: "en",
                      child: Text("English "),
                    ),
                    DropdownMenuItem(
                      value: "ar",
                      child: Text("العربية"),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      context.read<LocaleCubit>().changeLocale(value);
                    }
                  },
                ),
              );
            },
          ),
        ),
      ],
    ),
    body: Padding(
      padding: EdgeInsets.all(ScreenSize.width / 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            " ${S.of(context).welcome} ${employee.fullName} 👋",
            style: TextStyle(
              fontSize: ScreenSize.width / 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          TitleCardInHRHomeWidget(
            title: S.of(context).myData,
            fontSize: ScreenSize.width / 21,
            leading: Icon(Icons.person),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          EmployeeInfoView(employee: employee)));
            },
          ),
          TitleCardInHRHomeWidget(
            title: S.of(context).attendance,
            fontSize: ScreenSize.width / 21,
            leading: Icon(Icons.access_time),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AttendanceForEmplyeeView(
                          employeeId: employee.id!,
                          employeeName: employee.fullName)));
            },
          ),
          TitleCardInHRHomeWidget(
            title: S.of(context).payroll,
            fontSize: ScreenSize.width / 21,
            leading: Icon(Icons.attach_money),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PayrollForEmployeeView(
                          employeeId: employee.id!,
                          employeeName: employee.fullName)));
            },
          ),
          // const Spacer(),
          TitleCardInHRHomeWidget(
            title: S.of(context).logout,
            fontSize: ScreenSize.width / 21,
            leading: Icon(Icons.logout),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => SignInView()),
                (Route route) => false,
              );
            },
          ),
        ],
      ),
    ),
  );
}
