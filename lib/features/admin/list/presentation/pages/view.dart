import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../commonWidget/text_input.dart';
import '../../../../../../core/utils/ui_extensions/extensions_init.dart';
import '../../../../../di/service_locator.dart';
import '../controller/controller.dart';
import '../controller/state.dart';
import '../widgets/admin_card.dart';

class AdminListView extends StatefulWidget {
  const AdminListView({super.key});

  @override
  State<AdminListView> createState() => _AdminListViewState();
}

class _AdminListViewState extends State<AdminListView> {
  final TextEditingController _searchController = TextEditingController();
  late final AdminListController _adminListController;

  @override
  void initState() {
    super.initState();
    _adminListController = sl<AdminListController>();
    _adminListController.getAdmins();
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
          // Navigate to Add Admin Feature
          // Navigator.pushNamed(context, RouteNames.addAdmin);
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
              setState(() {});
            },
            isRequired: false,
          ).paddingAll(16),
          Expanded(
            child: BlocBuilder<AdminListController, AdminListState>(
              bloc: _adminListController,
              builder: (context, state) {
                if (state.requestState.isLoading && state.data.isEmpty) {
                  return const CircularProgressIndicator().center;
                } else if (state.requestState.isError) {
                  return Text(state.errorMessage).center;
                } else if (state.data.isEmpty &&
                    !state.requestState.isLoading) {
                  return 'لا يوجد بيانات'.bodyLarge().center;
                }

                final filteredList = state.data.where((admin) {
                  final query = _searchController.text.toLowerCase();
                  return admin.name.toLowerCase().contains(query) ||
                      admin.email.toLowerCase().contains(query);
                }).toList();

                if (filteredList.isEmpty && _searchController.text.isNotEmpty) {
                  return 'لا توجد نتائج للبحث'.bodyLarge().center;
                } else if (filteredList.isEmpty &&
                    _searchController.text.isEmpty &&
                    !state.requestState.isLoading) {
                  return 'لا يوجد بيانات'.bodyLarge().center;
                }

                return ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    final admin = filteredList[index];
                    return AdminCard(
                      admin: admin,
                      onEdit: () {
                        // Navigate to Edit Admin Feature
                        // Navigator.pushNamed(context, RouteNames.editAdmin, arguments: admin);
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
                                  _adminListController.deleteAdmin(admin.id);
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
