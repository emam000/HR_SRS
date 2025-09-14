import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hr_srs/core/database/database_helper.dart';
import 'package:hr_srs/features/hr/groups_and_prmi/model/groups_model.dart';
import 'package:hr_srs/features/hr/groups_and_prmi/model/permission_model.dart';
import 'package:hr_srs/generated/l10n.dart';
import 'package:meta/meta.dart';

part 'groups_state.dart';

class GroupsCubit extends Cubit<GroupsState> {
  GroupsCubit() : super(GroupsInitial());

  Future<void> loadAll() async {
    try {
      emit(GroupsLoading());
      final groups = await DatabaseHelper().getAllGroups();
      final permissions = await DatabaseHelper().getAllPermissions();

      final Map<int, List<int>> map = {};
      for (final g in groups) {
        final perms = await DatabaseHelper().getPermissionsForGroup(g.id!);
        map[g.id!] = perms;
      }

      emit(GroupsLoaded(
          groups: groups, permissions: permissions, groupPermissions: map));
    } catch (e) {
      emit(GroupsError(message: "فشل تحميل المجموعات: $e"));
    }
  }

  Future<OperationResult> addGroup(String name) async {
    try {
      final group = GroupModel(name: name);
      await DatabaseHelper().insertGroup(group);
      await loadAll();
      return OperationResult(success: true, message: "تمت إضافة المجموعة");
    } catch (e) {
      return OperationResult(success: false, message: "فشل إضافة المجموعة: $e");
    }
  }

  Future<OperationResult> deleteGroup(int id) async {
    try {
      await DatabaseHelper().deleteGroup(id);
      await loadAll();
      return OperationResult(success: true, message: "تم حذف المجموعة");
    } catch (e) {
      return OperationResult(success: false, message: "فشل حذف المجموعة: $e");
    }
  }

  Future<OperationResult> togglePermission(
      int groupId, int permissionId) async {
    try {
      final currentState = state;
      List<int> current = [];
      if (currentState is GroupsLoaded) {
        current = currentState.groupPermissions[groupId] ?? [];
      } else {
        await loadAll();
        final s = state;
        if (s is GroupsLoaded) current = s.groupPermissions[groupId] ?? [];
      }

      if (current.contains(permissionId)) {
        await DatabaseHelper().deleteGroupPermission(groupId, permissionId);
        await loadAll();
        return OperationResult(
            success: true, message: "تم إزالة الصلاحية من المجموعة");
      } else {
        await DatabaseHelper().insertGroupPermission(groupId, permissionId);
        await loadAll();
        return OperationResult(
            success: true, message: "تم إضافة الصلاحية للمجموعة");
      }
    } catch (e) {
      return OperationResult(success: false, message: "فشل تحديث الصلاحية: $e");
    }
  }

  void showAddGroupDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(S.of(context).addNewGroup),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(labelText: S.of(context).groupName),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(S.of(context).cancel)),
          ElevatedButton(
            onPressed: () async {
              final name = controller.text.trim();
              if (name.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(S.of(context).pleaseEnterGroupName)));
                return;
              }
              Navigator.pop(ctx);
              final res = await addGroup(name);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(res.message),
                  backgroundColor: res.success ? Colors.green : Colors.red,
                ),
              );
            },
            child: Text(S.of(context).save),
          ),
        ],
      ),
    );
  }

  Future<void> confirmDelete(
      GroupModel groupmodel, BuildContext context) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(S.of(context).confirmDelete),
        content: Text("${S.of(context).didYouWantDelete} '${groupmodel.name}'"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(S.of(context).cancel)),
          ElevatedButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(S.of(context).delete)),
        ],
      ),
    );

    if (ok == true) {
      final res = await deleteGroup(groupmodel.id!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(res.message),
            backgroundColor: res.success ? Colors.green : Colors.red),
      );
    }
  }
}
