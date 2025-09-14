import 'package:flutter/material.dart';
import 'package:hr_srs/features/hr/users/model/user_model.dart';
import 'package:hr_srs/features/hr/users/view_model/cubit/users_cubit.dart';

class SaveEditUserButtonWidget extends StatelessWidget {
  const SaveEditUserButtonWidget({
    super.key,
    required this.child,
    required this.usersCubit,
    required this.formKey,
    required this.user,
  });
  final Widget child;
  final UsersCubit usersCubit;
  final GlobalKey<FormState> formKey;
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
      ),
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          final updatedUser = UserModel(
            id: user.id,
            groupId: user.role == 'HR' ? 1 : 2,
            fullName: usersCubit.fullNameController.text.trim(),
            email: usersCubit.emailController.text.trim().isEmpty
                ? null
                : usersCubit.emailController.text.trim(),
            username: usersCubit.usernameController.text.trim().isEmpty
                ? null
                : usersCubit.usernameController.text.trim(),
            password: usersCubit.passwordController.text,
            role: usersCubit.role!,
            createdAt: user.createdAt,
          );

          await usersCubit.updateUser(updatedUser);
          Navigator.pop(context);
        }
      },
      child: child,
    );
  }
}
