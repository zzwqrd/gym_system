import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../commonWidget/text_input.dart';
import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/utils/ui_extensions/extensions_init.dart';
import '../../../../../di/service_locator.dart';
import '../controller/controller.dart';
import '../controller/state.dart';
import '../widgets/user_card.dart';

class UserListView extends StatefulWidget {
  const UserListView({super.key});

  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  final TextEditingController _searchController = TextEditingController();
  late final UserListController _userListController;

  @override
  void initState() {
    super.initState();
    _userListController = sl<UserListController>();
    _userListController.getUsers();
  }

  @override
  void dispose() {
    _searchController.dispose();
    // Do not call getUsers() in dispose, as it's meant for cleanup, not data fetching.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('المشتركين')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to Add User Feature
          // Navigator.pushNamed(context, RouteNames.addUser);
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
              setState(() {}); // Rebuild to filter the list
            },
            isRequired: false,
          ).paddingAll(16),
          Expanded(
            child: BlocBuilder<UserListController, UserListState>(
              bloc: _userListController,
              builder: (context, state) {
                if (state.requestState == RequestState.loading) {
                  return const CircularProgressIndicator().center;
                } else if (state.requestState == RequestState.error) {
                  return Text(state.errorMessage).center;
                }

                final filteredList = state.data.where((user) {
                  final query = _searchController.text.toLowerCase();
                  return user.name.toLowerCase().contains(query) ||
                      user.email.toLowerCase().contains(query) ||
                      user.phone.contains(query);
                }).toList();

                if (filteredList.isEmpty) {
                  // Differentiate between no data initially and no search results
                  if (_searchController.text.isEmpty && state.data.isEmpty) {
                    return const Text('لا يوجد بيانات').center;
                  } else {
                    return const Text('لا توجد نتائج للبحث').center;
                  }
                }

                return ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    final user = filteredList[index];
                    return UserCard(
                      user: user,
                      onEdit: () {
                        // Navigate to Edit User Feature
                        // Navigator.pushNamed(context, RouteNames.editUser, arguments: user);
                      },
                      onDelete: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('تأكيد الحذف'),
                            content: const Text(
                              'هل أنت متأكد من حذف هذا المشترك؟',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: const Text('إلغاء'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(ctx);
                                  context.read<UserListController>().deleteUser(
                                    user.id,
                                  );
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
