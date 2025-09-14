import 'package:flutter/material.dart';
import 'package:hr_srs/core/sizeconfig/size_config.dart';
import 'package:hr_srs/features/employee/personal_info/view/widgets/card_employee_info_for_wide_screen_widget.dart';
import 'package:hr_srs/features/employee/personal_info/view/widgets/card_employee_info_widget.dart';
import 'package:hr_srs/features/hr/add_and%20_edit_employees/model/employee_model.dart';
import 'package:hr_srs/generated/l10n.dart';

class EmployeeInfoView extends StatelessWidget {
  const EmployeeInfoView({super.key, required this.employee});
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
        S.of(context).myData,
        style: TextStyle(
          fontSize: ScreenSize.width / 40,
        ),
      ),
    ),
    body: Padding(
      padding: EdgeInsets.all(ScreenSize.width / 20),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: ScreenSize.height / 30),
            CardEmployeeInfoForWideScreenWidget(
              title: S.of(context).fullName,
              value: employee.fullName,
            ),
            CardEmployeeInfoForWideScreenWidget(
              title: S.of(context).nationalID,
              value: employee.fullName,
            ),
            CardEmployeeInfoForWideScreenWidget(
              title: S.of(context).gender,
              value: employee.gender,
            ),
            CardEmployeeInfoForWideScreenWidget(
              title: S.of(context).nationality,
              value: employee.nationality,
            ),
            CardEmployeeInfoForWideScreenWidget(
              title: S.of(context).phoneNumber,
              value: employee.phone,
            ),
            CardEmployeeInfoForWideScreenWidget(
              title: S.of(context).address,
              value: employee.address,
            ),
            CardEmployeeInfoForWideScreenWidget(
              title: S.of(context).dateOfBirth,
              value: employee.birthDate.toString().substring(0, 11),
            ),
            CardEmployeeInfoForWideScreenWidget(
              title: S.of(context).joinDate,
              value: employee.joinDate.toString().substring(0, 11),
            ),
            CardEmployeeInfoForWideScreenWidget(
              title: S.of(context).department,
              value: employee.department,
            ),
            CardEmployeeInfoForWideScreenWidget(
              title: S.of(context).baseSalary,
              value: "${employee.baseSalary} ج.م",
            ),
            CardEmployeeInfoForWideScreenWidget(
              title: S.of(context).workStart,
              value: "${employee.workStart} AM",
            ),
            CardEmployeeInfoForWideScreenWidget(
              title: S.of(context).workEnd,
              value: "${employee.workEnd} PM",
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildMobileWidgets(
    {required BuildContext context, required EmployeeModel employee}) {
  return Scaffold(
    appBar: AppBar(
        title: Text(
      S.of(context).myData,
      style: TextStyle(fontSize: ScreenSize.width / 18),
    )),
    body: Padding(
      padding: EdgeInsets.all(ScreenSize.width / 30),
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          CardEmployeeInfoWidget(
            title: S.of(context).fullName,
            subtitle: Text(employee.fullName),
          ),
          CardEmployeeInfoWidget(
            title: S.of(context).nationalID,
            subtitle: Text(employee.nationalId),
          ),
          CardEmployeeInfoWidget(
              title: S.of(context).gender, subtitle: Text(employee.gender)),
          CardEmployeeInfoWidget(
            title: S.of(context).nationality,
            subtitle: Text(employee.nationality),
          ),
          CardEmployeeInfoWidget(
            title: S.of(context).phoneNumber,
            subtitle: Text(employee.phone),
          ),
          CardEmployeeInfoWidget(
            title: S.of(context).address,
            subtitle: Text(employee.address),
          ),
          CardEmployeeInfoWidget(
            title: S.of(context).dateOfBirth,
            subtitle: Text(employee.birthDate.toString().substring(0, 10)),
          ),
          CardEmployeeInfoWidget(
            title: S.of(context).joinDate,
            subtitle: Text(employee.joinDate.toString().substring(0, 10)),
          ),
          CardEmployeeInfoWidget(
              title: S.of(context).department,
              subtitle: Text(employee.department)),
          CardEmployeeInfoWidget(
            title: S.of(context).baseSalary,
            subtitle: Text(" ${employee.baseSalary} ج.م"),
          ),
          CardEmployeeInfoWidget(
            title: S.of(context).workStart,
            subtitle: Text("${employee.workStart} AM"),
          ),
          CardEmployeeInfoWidget(
            title: S.of(context).workEnd,
            subtitle: Text("${employee.workEnd} PM"),
          ),
        ],
      ),
    ),
  );
}
