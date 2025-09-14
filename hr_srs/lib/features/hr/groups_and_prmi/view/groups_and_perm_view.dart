import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_srs/core/sizeconfig/size_config.dart';
import 'package:hr_srs/features/hr/groups_and_prmi/model/permission_model.dart';
import 'package:hr_srs/features/hr/groups_and_prmi/view_model/cubit/groups_cubit.dart';
import 'package:hr_srs/generated/l10n.dart';

class GroupsAndPermView extends StatefulWidget {
  const GroupsAndPermView({super.key});

  @override
  State<GroupsAndPermView> createState() => _GroupsAndPermViewState();
}

class _GroupsAndPermViewState extends State<GroupsAndPermView> {
  @override
  void initState() {
    super.initState();
    context.read<GroupsCubit>().loadAll();
  }

  @override
  Widget build(BuildContext context) {
    GroupsCubit groupsCubit = BlocProvider.of<GroupsCubit>(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= 600) {
          return buildMobileWidgets(context: context, groupsCubit: groupsCubit);
        } else {
          return buildWideScreenWidgets(
              context: context, groupsCubit: groupsCubit);
        }
      },
    );
  }
}

Widget buildWideScreenWidgets(
    {required BuildContext context, required GroupsCubit groupsCubit}) {
  return Scaffold(
    appBar: AppBar(
        title: Text(
      S.of(context).groupsAndPerm,
      style: TextStyle(fontSize: ScreenSize.width / 40),
    )),
    floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.blue,
      onPressed: () {
        groupsCubit.showAddGroupDialog(context);
      },
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    ),
    body: Padding(
      padding: EdgeInsets.all(ScreenSize.width / 20),
      child: BlocBuilder<GroupsCubit, GroupsState>(
        builder: (context, state) {
          if (state is GroupsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GroupsLoaded) {
            final groups = state.groups;
            final permissions = state.permissions;
            final map = state.groupPermissions;

            if (groups.isEmpty) {
              return Center(child: Text(S.of(context).noGroups));
            }

            return ListView.builder(
              padding: EdgeInsets.all(ScreenSize.width / 30),
              itemCount: groups.length,
              itemBuilder: (context, idx) {
                final groupmodel = groups[idx];
                final assigned = map[groupmodel.id!] ?? [];

                return Card(
                  color: Colors.blue.shade100,
                  child: ExpansionTile(
                    title: Text(groupmodel.name,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () =>
                          groupsCubit.confirmDelete(groupmodel, context),
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenSize.width / 30),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(S.of(context).permissions,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            SizedBox(height: ScreenSize.height / 70),
                            ...permissions.map((PermissionModel p) {
                              final checked = assigned.contains(p.id);
                              return CheckboxListTile(
                                title: Text(p.name),
                                value: checked,
                                onChanged: (v) async {
                                  final res = await groupsCubit
                                      .togglePermission(groupmodel.id!, p.id!);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(res.message),
                                        backgroundColor: res.success
                                            ? Colors.green
                                            : Colors.red),
                                  );
                                },
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is GroupsError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text(S.of(context).loading));
        },
      ),
    ),
  );
}

Widget buildMobileWidgets(
    {required BuildContext context, required GroupsCubit groupsCubit}) {
  return Scaffold(
    appBar: AppBar(
        title: Text(
      S.of(context).groupsAndPerm,
      style: TextStyle(fontSize: ScreenSize.width / 18),
    )),
    floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.blue,
      onPressed: () {
        groupsCubit.showAddGroupDialog(context);
      },
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    ),
    body: BlocBuilder<GroupsCubit, GroupsState>(
      builder: (context, state) {
        if (state is GroupsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GroupsLoaded) {
          final groups = state.groups;
          final permissions = state.permissions;
          final map = state.groupPermissions;

          if (groups.isEmpty) {
            return Center(child: Text(S.of(context).noGroups));
          }

          return ListView.builder(
            padding: EdgeInsets.all(ScreenSize.width / 30),
            itemCount: groups.length,
            itemBuilder: (context, idx) {
              final groupmodel = groups[idx];
              final assigned = map[groupmodel.id!] ?? [];

              return Card(
                color: Colors.blue.shade100,
                child: ExpansionTile(
                  title: Text(groupmodel.name,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () =>
                        groupsCubit.confirmDelete(groupmodel, context),
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenSize.width / 30),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(S.of(context).permissions,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(height: ScreenSize.height / 70),
                          ...permissions.map((PermissionModel p) {
                            final checked = assigned.contains(p.id);
                            return CheckboxListTile(
                              title: Text(p.name),
                              value: checked,
                              onChanged: (v) async {
                                final res = await groupsCubit.togglePermission(
                                    groupmodel.id!, p.id!);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(res.message),
                                      backgroundColor: res.success
                                          ? Colors.green
                                          : Colors.red),
                                );
                              },
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else if (state is GroupsError) {
          return Center(child: Text(state.message));
        }
        return Center(child: Text(S.of(context).loading));
      },
    ),
  );
}
