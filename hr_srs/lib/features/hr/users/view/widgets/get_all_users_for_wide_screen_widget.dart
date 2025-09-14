import 'package:flutter/material.dart';
import 'package:hr_srs/core/sizeconfig/size_config.dart';
import 'package:hr_srs/features/hr/users/model/user_model.dart';
import 'package:hr_srs/features/hr/users/view/edit_user_view.dart';
import 'package:hr_srs/features/hr/users/view_model/cubit/users_cubit.dart';
import 'package:hr_srs/generated/l10n.dart';

class GetAllUsersForWideScreenWidget extends StatelessWidget {
  final List<UserModel> users;
  final UsersCubit usersCubit;
  final int crossAxisCount;

  const GetAllUsersForWideScreenWidget({
    super.key,
    required this.users,
    required this.usersCubit,
    this.crossAxisCount = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ScreenSize.width / 50),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: crossAxisCount == 2 ? 2.5 : 2,
        ),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return _buildUserCard(context, user, index);
        },
      ),
    );
  }

  Widget _buildUserCard(BuildContext context, UserModel user, int index) {
    return Card(
      color: Colors.blue.shade100,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(ScreenSize.width / 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.fullName,
              style: Theme.of(context).textTheme.bodyLarge,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: ScreenSize.height / 200),
            Text(
              "${S.of(context).email}: ${user.email ?? S.of(context).unavilable}",
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: ScreenSize.height / 200),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EditUserView(user: users[index])));
                  },
                  icon: Icon(
                    Icons.edit,
                    size: ScreenSize.width / 60,
                    color: Colors.blue,
                  ),
                  label: Text(S.of(context).edit,
                      style: TextStyle(
                          fontSize: ScreenSize.width / 90,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue)),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    await usersCubit.deleteUser(user.id!);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(S.of(context).deleteUser),
                        backgroundColor: Colors.blue,
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.delete,
                    size: ScreenSize.width / 60,
                    color: Colors.red,
                  ),
                  label: Text(S.of(context).delete,
                      style: TextStyle(
                          fontSize: ScreenSize.width / 90,
                          fontWeight: FontWeight.bold,
                          color: Colors.red)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
