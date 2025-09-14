import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_srs/core/sizeconfig/size_config.dart';
import 'package:hr_srs/features/auth/view/widgets/logo_container_widget.dart';
import 'package:hr_srs/features/auth/view/widgets/sign_in_button.dart';
import 'package:hr_srs/features/auth/view/widgets/sign_in_text_form_field_widget.dart';
import 'package:hr_srs/features/auth/view_model/cubit/auth_cubit.dart';
import 'package:hr_srs/features/home/view/employee_home_view.dart';
import 'package:hr_srs/features/home/view/hr_home_view.dart';
import 'package:hr_srs/generated/l10n.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) async {
        if (state is SignInSuccess) {
          if (state.user.role == "HR") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HrHomeView()),
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(S.of(context).signInSuccesHR),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state.user.role == "Employee") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    EmployeeHomeView(employee: state.employee!),
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(S.of(context).signInSuccesEmp),
                backgroundColor: Colors.green,
              ),
            );
          }
          authCubit.emailOrUsername.clear();
          authCubit.password.clear();
        } else if (state is SignInError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= 800) {
              return buildWideLayout(context, authCubit, state);
            } else {
              return buildMobileLayout(context, authCubit, state);
            }
          },
        );
      },
    );
  }
}

Widget buildWideLayout(
  BuildContext context,
  AuthCubit authCubit,
  AuthState state,
) {
  return ModalProgressHUD(
    inAsyncCall: state is SignInLoading,
    color: Colors.blue,
    child: Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.blue.shade50,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LogoContainerWidget(
                      height: ScreenSize.height / 3,
                      width: ScreenSize.width / 4,
                    ),
                    SizedBox(height: ScreenSize.height / 30),
                    Text(
                      S.of(context).welcome,
                      style: TextStyle(
                        fontSize: ScreenSize.width / 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(height: ScreenSize.height / 150),
                    Text(
                      S.of(context).slogan,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(ScreenSize.width / 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: ScreenSize.height / 10),
                    SignInTextFromFieldWidget(
                      valText: S.of(context).validEmail,
                      controller: authCubit.emailOrUsername,
                      nKey: authCubit.eKey,
                      obscureText: false,
                      hint: S.of(context).validEmail,
                    ),
                    SizedBox(height: ScreenSize.height / 30),
                    SignInTextFromFieldWidget(
                      valText: S.of(context).validPassword,
                      controller: authCubit.password,
                      nKey: authCubit.pKey,
                      obscureText: authCubit.passwordObscureText,
                      hint: S.of(context).hintPassword,
                      suffix: GestureDetector(
                        onTap: () {
                          authCubit.changeObscureText();
                        },
                        child: Icon(
                          authCubit.passwordObscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: ScreenSize.height / 25),
                    SignInButton(
                      title: S.of(context).signin,
                      fontSize: ScreenSize.width / 35,
                      onPressed: () async {
                        await authCubit.signIn(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildMobileLayout(
  BuildContext context,
  AuthCubit authCubit,
  AuthState state,
) {
  return ModalProgressHUD(
    inAsyncCall: state is SignInLoading,
    color: Colors.blue,
    child: Scaffold(
      body: Padding(
        padding: EdgeInsets.all(ScreenSize.width / 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: ScreenSize.height / 5),
              LogoContainerWidget(
                height: ScreenSize.height / 7,
                width: ScreenSize.width / 3,
              ),
              SizedBox(height: ScreenSize.height / 20),
              SignInTextFromFieldWidget(
                valText: S.of(context).validEmail,
                controller: authCubit.emailOrUsername,
                nKey: authCubit.eKey,
                obscureText: false,
                hint: S.of(context).hintEmailOrUsername,
              ),
              SizedBox(height: ScreenSize.height / 30),
              SignInTextFromFieldWidget(
                valText: S.of(context).validPassword,
                controller: authCubit.password,
                nKey: authCubit.pKey,
                obscureText: authCubit.passwordObscureText,
                hint: S.of(context).hintPassword,
                suffix: GestureDetector(
                  onTap: () {
                    authCubit.changeObscureText();
                  },
                  child: Icon(
                    authCubit.passwordObscureText
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: ScreenSize.height / 25),
              SignInButton(
                title: S.of(context).signin,
                fontSize: ScreenSize.width / 20,
                onPressed: () async {
                  await authCubit.signIn(context);
                  // await delete();
                },
              )
            ],
          ),
        ),
      ),
    ),
  );
}
