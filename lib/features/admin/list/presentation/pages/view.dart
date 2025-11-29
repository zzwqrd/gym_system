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
      appBar: AppBar(title: const Text('المسؤولين')),
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
              // Trigger a rebuild to re-filter the list based on the search query
              setState(() {});
            },
            isRequired: false,
          ).paddingAll(16),
          Expanded(
            child: BlocBuilder<AdminListController, AdminListState>(
              bloc: _adminListController, // Use the instance from initState
              builder: (context, state) {
                if (state.requestState.isLoading && state.data.isEmpty) {
                  return const CircularProgressIndicator().center;
                } else if (state.requestState.isError) {
                  return Text(state.errorMessage).center;
                } else if (state.data.isEmpty &&
                    !state.requestState.isLoading) {
                  // Only show 'لا يوجد بيانات' if not loading and data is truly empty
                  return const Text('لا يوجد بيانات').center;
                }

                final filteredList = state.data.where((admin) {
                  final query = _searchController.text.toLowerCase();
                  return admin.name.toLowerCase().contains(query) ||
                      admin.email.toLowerCase().contains(query);
                }).toList();

                if (filteredList.isEmpty && _searchController.text.isNotEmpty) {
                  return const Text('لا توجد نتائج للبحث').center;
                } else if (filteredList.isEmpty &&
                    _searchController.text.isEmpty &&
                    !state.requestState.isLoading) {
                  // This case should be covered by the 'لا يوجد بيانات' above, but as a fallback
                  return const Text('لا يوجد بيانات').center;
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
                            title: const Text('تأكيد الحذف'),
                            content: const Text(
                              'هل أنت متأكد من حذف هذا المسؤول؟',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: const Text('إلغاء'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(ctx);
                                  // Ensure the controller instance is used
                                  _adminListController.deleteAdmin(admin.id);
                                },
                                child: const Text(
                                  'حذف',
                                  style: TextStyle(color: Colors.red),
                                ),
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
