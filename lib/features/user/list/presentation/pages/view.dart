import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_system/core/routes/navigation.dart';
import '../../../../../../commonWidget/text_input.dart';
import '../../../../../../core/utils/ui_extensions/extensions_init.dart';
import '../../../../../di/service_locator.dart';
import '../controller/controller.dart';
import '../controller/state.dart';
import '../../../../../../core/routes/routes.dart';
import '../widgets/user_card.dart';

class UserListView extends StatefulWidget {
  const UserListView({super.key});

  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  final TextEditingController _searchController = TextEditingController();
  final _controller = sl<UserListController>();

  @override
  void initState() {
    super.initState();
    _controller.getUsers();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: 'المشتركين'.h6),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(RouteNames.addUser).then((_) => _controller.getUsers());
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
              bloc: _controller,
              builder: (context, state) {
                if (state.requestState.isLoading && state.data.isEmpty) {
                  return const CircularProgressIndicator().center;
                } else if (state.requestState.isError) {
                  return Text(state.errorMessage).center;
                }

                final filteredList = state.data.where((user) {
                  final query = _searchController.text.toLowerCase();
                  return user.name.toLowerCase().contains(query) ||
                      user.email.toLowerCase().contains(query);
                }).toList();

                if (filteredList.isEmpty) {
                  if (_searchController.text.isNotEmpty) {
                    return 'لا توجد نتائج للبحث'.bodyLarge().center;
                  } else {
                    return 'لا يوجد بيانات'.bodyLarge().center;
                  }
                }

                return ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    final user = filteredList[index];
                    return UserCard(
                      user: user,
                      onTap: () {
                        context.push(
                          RouteNames.userDetails,
                          arguments: {'userId': user.id, 'user': user},
                        );
                      },
                      onEdit: () {
                        context
                            .push(
                              RouteNames.editUser,
                              arguments: {'user': user},
                            )
                            .then((_) => _controller.getUsers());
                      },
                      onDelete: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: 'تأكيد الحذف'.h6,
                            content: 'هل أنت متأكد من حذف هذا المشترك؟'.body,
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: 'إلغاء'.body,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(ctx);
                                  _controller.deleteUser(user.id);
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
