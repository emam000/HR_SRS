import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_srs/core/locale/cubit/locale_cubit.dart';
import 'package:hr_srs/core/sizeconfig/size_config.dart';
import 'package:hr_srs/features/hr/add_and%20_edit_employees/view/emplyees_view.dart';
import 'package:hr_srs/features/hr/attendance/view/attendance_view.dart';
import 'package:hr_srs/features/auth/view/sign_in_view.dart';
import 'package:hr_srs/features/home/view/widgets/title_card_in_hr_home_widget.dart';
import 'package:hr_srs/features/hr/groups_and_prmi/view/groups_and_perm_view.dart';
import 'package:hr_srs/features/hr/payroll/view/payroll_view.dart';
import 'package:hr_srs/features/hr/users/view/users_view.dart';
import 'package:hr_srs/generated/l10n.dart';

class HrHomeView extends StatelessWidget {
  const HrHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 800) {
          return _buildWideLayout(context);
        } else {
          return _buildMobileLayout(context);
        }
      },
    );
  }

  Widget _buildWideLayout(BuildContext context) {
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
                  label: Text(S.of(context).users),
                ),
                NavigationRailDestination(
                  disabled: true,
                  icon: Icon(Icons.people),
                  label: Text(S.of(context).employee),
                ),
                NavigationRailDestination(
                  disabled: true,
                  icon: Icon(Icons.security),
                  label: Text(S.of(context).groupsAndPerm),
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
                    title: S.of(context).users,
                    fontSize: ScreenSize.width / 50,
                    leading: const Icon(Icons.people),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => UsersView()));
                    },
                  ),
                  TitleCardInHRHomeWidget(
                    title: S.of(context).employee,
                    fontSize: ScreenSize.width / 50,
                    leading: const Icon(Icons.people),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EmployeesView()));
                    },
                  ),
                  TitleCardInHRHomeWidget(
                    title: S.of(context).groupsAndPerm,
                    fontSize: ScreenSize.width / 50,
                    leading: const Icon(Icons.security),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GroupsAndPermView()));
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
                          builder: (context) => AttendanceView(),
                        ),
                      );
                    },
                  ),
                  TitleCardInHRHomeWidget(
                    title: S.of(context).payroll,
                    fontSize: ScreenSize.width / 50,
                    leading: const Icon(Icons.money),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PayrollView()));
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

  Widget _buildMobileLayout(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        title: Text(
          S.of(context).homeTitle,
          style: TextStyle(fontSize: ScreenSize.width / 18),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(ScreenSize.width / 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TitleCardInHRHomeWidget(
              title: S.of(context).users,
              fontSize: ScreenSize.width / 21,
              leading: const Icon(Icons.people),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UsersView()));
              },
            ),
            TitleCardInHRHomeWidget(
              title: S.of(context).employee,
              fontSize: ScreenSize.width / 21,
              leading: const Icon(Icons.people),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EmployeesView()));
              },
            ),
            TitleCardInHRHomeWidget(
              title: S.of(context).groupsAndPerm,
              fontSize: ScreenSize.width / 21,
              leading: const Icon(Icons.security),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GroupsAndPermView()));
              },
            ),
            TitleCardInHRHomeWidget(
              title: S.of(context).attendance,
              fontSize: ScreenSize.width / 21,
              leading: const Icon(Icons.access_time),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AttendanceView(),
                  ),
                );
              },
            ),
            TitleCardInHRHomeWidget(
              title: S.of(context).payroll,
              fontSize: ScreenSize.width / 21,
              leading: const Icon(Icons.money),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PayrollView()));
              },
            ),
            TitleCardInHRHomeWidget(
              title: S.of(context).logout,
              fontSize: ScreenSize.width / 21,
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
    );
  }
}
