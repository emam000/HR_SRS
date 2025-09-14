import 'package:flutter/material.dart';
import 'package:hr_srs/features/hr/users/model/user_model.dart';
import 'package:hr_srs/features/hr/users/view/edit_user_view.dart';
import 'package:hr_srs/features/hr/users/view_model/cubit/users_cubit.dart';
import 'package:hr_srs/generated/l10n.dart';

class GetAllUsersForMobileWidget extends StatelessWidget {
  const GetAllUsersForMobileWidget({
    super.key,
    required this.users,
    required this.usersCubit,
  });

  final List<UserModel> users;
  final UsersCubit usersCubit;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: users.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final userModel = users[index];
        return Card(
          color: Colors.blue.shade100,
          child: ListTile(
            title: Text(userModel.fullName),
            subtitle: Text(
              userModel.role == "HR"
                  ? "HR • ${userModel.username}  "
                  : "Employee • ${userModel.email} ",
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EditUserView(user: users[index])));
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () async {
                    await usersCubit.deleteUser(userModel.id!);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(S.of(context).deleteUser),
                      backgroundColor: Colors.blue,
                    ));
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
