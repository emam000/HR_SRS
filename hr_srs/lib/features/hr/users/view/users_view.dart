import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_srs/core/sizeconfig/size_config.dart';
import 'package:hr_srs/features/hr/add_and%20_edit_employees/view/widgets/no_employee_or_user_data_widget.dart';
import 'package:hr_srs/features/hr/users/view/widgets/get_all_users_for_mobile_widget.dart';
import 'package:hr_srs/features/hr/users/view/widgets/get_all_users_for_wide_screen_widget.dart';
import 'package:hr_srs/features/hr/users/view_model/cubit/users_cubit.dart';
import 'package:hr_srs/generated/l10n.dart';

class UsersView extends StatefulWidget {
  const UsersView({super.key});

  @override
  State<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  @override
  void initState() {
    super.initState();
    context.read<UsersCubit>().getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    UsersCubit usersCubit = BlocProvider.of<UsersCubit>(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= 600) {
          return buildMobileWidgets(context: context, usersCubit: usersCubit);
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
          usersCubit: usersCubit,
          crossAxisCount: crossAxisCount,
        );
      },
    );
  }
}

Widget buildWideScreenWidgets(
    {required BuildContext context,
    required UsersCubit usersCubit,
    required int crossAxisCount}) {
  return Scaffold(
    appBar: AppBar(
        title: Text(
      S.of(context).users,
      style: TextStyle(fontSize: ScreenSize.width / 40),
    )),
    body: Padding(
      padding: EdgeInsets.all(ScreenSize.width / 30),
      child: BlocBuilder<UsersCubit, UsersState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.blue,
            ));
          } else if (state is GetAllUsers) {
            final users = state.users;

            if (users.isEmpty) {
              return NoEmployeeOrUserDataWidget(
                textOne: S.of(context).emptyUsers,
                textTwo: "",
              );
            }

            return GetAllUsersForWideScreenWidget(
                crossAxisCount: crossAxisCount,
                users: users,
                usersCubit: usersCubit);
          } else if (state is UserError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox();
          }
        },
      ),
    ),
  );
}

Widget buildMobileWidgets(
    {required BuildContext context, required UsersCubit usersCubit}) {
  return Scaffold(
    appBar: AppBar(
        title: Text(
      S.of(context).users,
      style: TextStyle(fontSize: ScreenSize.width / 18),
    )),
    body: Padding(
      padding: EdgeInsets.all(ScreenSize.width / 30),
      child: BlocBuilder<UsersCubit, UsersState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.blue,
            ));
          } else if (state is GetAllUsers) {
            final users = state.users;

            if (users.isEmpty) {
              return NoEmployeeOrUserDataWidget(
                textOne: S.of(context).emptyUsers,
                textTwo: "",
              );
            }

            return GetAllUsersForMobileWidget(
                users: users, usersCubit: usersCubit);
          } else if (state is UserError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox();
          }
        },
      ),
    ),
  );
}
