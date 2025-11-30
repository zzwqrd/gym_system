import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../commonWidget/text_input.dart';
import '../../../../../../core/utils/ui_extensions/extensions_init.dart';
import '../../../../../di/service_locator.dart';
import '../controller/controller.dart';
import '../controller/state.dart';
import '../../../../../../core/routes/routes.dart';
import '../widgets/admin_card.dart';

class AdminListView extends StatefulWidget {
  const AdminListView({super.key});

  @override
  State<AdminListView> createState() => _AdminListViewState();
}

class _AdminListViewState extends State<AdminListView> {
  final TextEditingController _searchController = TextEditingController();
  final controller = sl<AdminListController>();

  @override
  void initState() {
    super.initState();
    controller.getAdmins();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: 'المسؤولين'.h6),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            RouteNames.addAdmin,
          ).then((_) => controller.getAdmins());
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          AppCustomForm(
            hintText: 'بحث...',
            controller: _searchController,
            prefixIcon: const Icon(Icons.search),
            onChanged: (val) {
              // Trigger a rebuild to apply search filter
              setState(() {});
            },
            isRequired: false,
          ).paddingAll(16),
          Expanded(
            child: BlocBuilder<AdminListController, AdminListState>(
              bloc: controller,
              builder: (context, state) {
                if (state.requestState.isLoading) {
                  return const CircularProgressIndicator().center;
                } else if (state.requestState.isError) {
                  return Text(state.errorMessage).center;
                }

                final query = _searchController.text.toLowerCase();
                final filteredList = state.data.where((admin) {
                  return admin.name.toLowerCase().contains(query) ||
                      admin.email.toLowerCase().contains(query);
                }).toList();

                if (filteredList.isEmpty) {
                  if (query.isNotEmpty) {
                    return 'لا توجد نتائج للبحث'.bodyLarge().center;
                  } else {
                    return 'لا يوجد بيانات'.bodyLarge().center;
                  }
                }

                return ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    final admin = filteredList[index];
                    return AdminCard(
                      admin: admin,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteNames.adminDetails,
                          arguments: {'adminId': admin.id, 'admin': admin},
                        );
                      },
                      onEdit: () {
                        Navigator.pushNamed(
                          context,
                          RouteNames.editAdmin,
                          arguments: {'admin': admin},
                        ).then((_) => controller.getAdmins());
                      },
                      onDelete: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: 'تأكيد الحذف'.h6,
                            content: 'هل أنت متأكد من حذف هذا المسؤول؟'.body,
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: 'إلغاء'.body,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(ctx);
                                  controller.deleteAdmin(admin.id);
                                },
                                child: 'حذف'.body,
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
