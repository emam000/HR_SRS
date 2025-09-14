import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_srs/core/sizeconfig/size_config.dart';
import 'package:hr_srs/features/hr/add_and%20_edit_employees/view/widgets/custom_text_form_field_widget.dart';
import 'package:hr_srs/features/hr/users/model/user_model.dart';
import 'package:hr_srs/features/hr/users/view/widgets/add_and_edit_field_for_wide_screen_widget.dart';
import 'package:hr_srs/features/hr/users/view/widgets/save_edit_user_button_widget.dart';
import 'package:hr_srs/features/hr/users/view_model/cubit/users_cubit.dart';
import 'package:hr_srs/generated/l10n.dart';

class EditUserView extends StatefulWidget {
  const EditUserView({super.key, required this.user});
  final UserModel user;
  @override
  State<EditUserView> createState() => _EditUserViewState();
}

class _EditUserViewState extends State<EditUserView> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context.read<UsersCubit>().fullNameController =
        TextEditingController(text: widget.user.fullName);
    context.read<UsersCubit>().emailController =
        TextEditingController(text: widget.user.email ?? "");
    context.read<UsersCubit>().usernameController =
        TextEditingController(text: widget.user.username ?? "");
    context.read<UsersCubit>().passwordController =
        TextEditingController(text: widget.user.password);
    context.read<UsersCubit>().role = widget.user.role;
  }

  @override
  Widget build(BuildContext context) {
    UsersCubit usersCubit = BlocProvider.of<UsersCubit>(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= 800) {
          return buildMobileWidgets(
              usersCubit: usersCubit,
              context: context,
              user: widget.user,
              formKey: formKey);
        } else {
          return buildWideScreenWidgets(
              usersCubit: usersCubit,
              context: context,
              user: widget.user,
              formKey: formKey);
        }
      },
    );
  }
}

Widget buildWideScreenWidgets(
    {required BuildContext context,
    required UsersCubit usersCubit,
    required UserModel user,
    required GlobalKey<FormState> formKey}) {
  return Scaffold(
    appBar: AppBar(
      title: Text(
        S.of(context).editUserData,
        style: TextStyle(fontSize: ScreenSize.width / 40),
      ),
    ),
    body: Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.all(ScreenSize.width / 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AddAndEditFieldForWideScreenWidget(
              title: S.of(context).fullName,
              controller: usersCubit.fullNameController,
              validator: (value) => value == null || value.isEmpty
                  ? S.of(context).requiredField
                  : null,
            ),
            AddAndEditFieldForWideScreenWidget(
                title: S.of(context).email,
                controller: usersCubit.emailController,
                validator: (v) {
                  if (usersCubit.role == "Employee") {
                    if (v == null || v.trim().isEmpty) {
                      return S.of(context).emailRequForEmpAcc;
                    }

                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(v.trim())) {
                      return S.of(context).validEmail;
                    }
                  }
                  return null;
                }),
            AddAndEditFieldForWideScreenWidget(
              title: S.of(context).username,
              controller: usersCubit.usernameController,
              validator: (v) {
                if (usersCubit.role == "HR") {
                  if (v == null || v.trim().isEmpty) {
                    return S.of(context).userRequForHRAcc;
                  }
                }
                return null;
              },
            ),
            AddAndEditFieldForWideScreenWidget(
              title: S.of(context).password,
              controller: usersCubit.passwordController,
              validator: (value) => value == null || value.isEmpty
                  ? S.of(context).requiredField
                  : null,
            ),
            Row(
              children: [
                SizedBox(
                  width: ScreenSize.width / 5,
                  child: Text(
                    S.of(context).role,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: ScreenSize.width / 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: ScreenSize.width / 8),
                SizedBox(
                  width: ScreenSize.width / 2,
                  child: DropdownButtonFormField<String>(
                    value: usersCubit.role,
                    items: [
                      DropdownMenuItem(
                          value: "HR", child: Text(S.of(context).hr)),
                      DropdownMenuItem(
                          value: "Employee", child: Text(S.of(context).emp)),
                    ],
                    onChanged: (value) {
                      usersCubit.changingRolerValue(value);
                    },
                    decoration: InputDecoration(labelText: S.of(context).role),
                  ),
                ),
              ],
            ),
            SaveEditUserButtonWidget(
              formKey: formKey,
              usersCubit: usersCubit,
              user: user,
              child: Text(
                S.of(context).saveEdits,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenSize.width / 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildMobileWidgets(
    {required BuildContext context,
    required UsersCubit usersCubit,
    required UserModel user,
    required GlobalKey<FormState> formKey}) {
  return Scaffold(
    appBar: AppBar(
      title: Text(
        S.of(context).editUserData,
        style: TextStyle(fontSize: ScreenSize.width / 18),
      ),
    ),
    body: Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.all(ScreenSize.width / 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: ScreenSize.height / 15),
              CustomTextFormFieldWidget(
                labelText: S.of(context).fullName,
                controller: usersCubit.fullNameController,
              ),
              SizedBox(height: ScreenSize.height / 35),
              TextFormField(
                controller: usersCubit.emailController,
                decoration: InputDecoration(labelText: S.of(context).email),
                validator: (v) {
                  if (usersCubit.role == "Employee") {
                    if (v == null || v.trim().isEmpty) {
                      return S.of(context).emailRequForEmpAcc;
                    }

                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(v.trim())) {
                      return S.of(context).validEmail;
                    }
                  }
                  return null;
                },
              ),
              SizedBox(height: ScreenSize.height / 35),
              TextFormField(
                controller: usersCubit.usernameController,
                decoration: InputDecoration(labelText: S.of(context).username),
                validator: (v) {
                  if (usersCubit.role == "HR") {
                    if (v == null || v.trim().isEmpty) {
                      return S.of(context).userRequForHRAcc;
                    }
                  }
                  return null;
                },
              ),
              SizedBox(height: ScreenSize.height / 35),
              CustomTextFormFieldWidget(
                labelText: S.of(context).password,
                controller: usersCubit.passwordController,
              ),
              SizedBox(height: ScreenSize.height / 35),
              DropdownButtonFormField<String>(
                value: usersCubit.role,
                items: [
                  DropdownMenuItem(value: "HR", child: Text(S.of(context).hr)),
                  DropdownMenuItem(
                      value: "Employee", child: Text(S.of(context).emp)),
                ],
                onChanged: (value) {
                  usersCubit.changingRolerValue(value);
                },
                decoration: InputDecoration(labelText: S.of(context).role),
              ),
              SizedBox(height: ScreenSize.height / 20),
              SaveEditUserButtonWidget(
                  usersCubit: usersCubit,
                  formKey: formKey,
                  user: user,
                  child: Text(
                    S.of(context).saveEdits,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenSize.width / 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ))
            ],
          ),
        ),
      ),
    ),
  );
}
