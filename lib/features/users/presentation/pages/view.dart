import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_system/core/utils/ui_extensions/extensions_init.dart';
import 'package:gym_system/features/users/data/models/user_model.dart';
import 'package:gym_system/features/users/domin/usecases/users_usecase.dart';
import 'package:gym_system/features/users/presentation/cubit/users_cubit.dart';
import 'package:gym_system/features/users/presentation/pages/add_user_screen.dart';
import 'package:gym_system/features/users/presentation/pages/edit_user_screen.dart';

class UsersView extends StatelessWidget {
  const UsersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UsersCubit(UsersUseCaseImpl())..getUsers(),
      child: const UsersViewBody(),
    );
  }
}

class UsersViewBody extends StatefulWidget {
  const UsersViewBody({super.key});

  @override
  State<UsersViewBody> createState() => _UsersViewBodyState();
}

class _UsersViewBodyState extends State<UsersViewBody> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header & Search
          Container(
            padding: 20.p,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                'Users Management'.h3,
                10.verticalSpace,
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search users...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(borderRadius: 10.r),
                    contentPadding: 10.p,
                  ),
                  onChanged: (value) {
                    context.read<UsersCubit>().searchUsers(value);
                  },
                ),
              ],
            ),
          ),

          // Users List
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await context.read<UsersCubit>().refreshUsers();
                _searchController.clear();
              },
              child: BlocBuilder<UsersCubit, UsersState>(
                builder: (context, state) {
                  if (state is UsersLoading) {
                    return const CircularProgressIndicator().center;
                  } else if (state is UsersError) {
                    return state.message.body.center;
                  } else if (state is UsersLoaded) {
                    if (state.users.isEmpty) {
                      return 'No users found'.body.center;
                    }
                    return ListView.separated(
                      padding: 20.p,
                      itemCount: state.users.length,
                      separatorBuilder: (context, index) => 10.verticalSpace,
                      itemBuilder: (context, index) {
                        final user = state.users[index];
                        return _UserItem(user: user);
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddUserScreen()),
          );
          if (result == true) {
            context.read<UsersCubit>().refreshUsers();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _UserItem extends StatelessWidget {
  final UserModel user;

  const _UserItem({required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 15.p,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: 10.r,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.blue.shade100,
            child:
                (user.firstName?.isNotEmpty == true
                        ? user.firstName![0].toUpperCase()
                        : user.username[0].toUpperCase())
                    .h4
                    .colors(Colors.blue),
          ),
          15.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (user.firstName != null && user.lastName != null
                        ? '${user.firstName} ${user.lastName}'
                        : user.username)
                    .h6
                    .bold(),
                5.verticalSpace,
                user.email.caption,
                if (user.phone != null) ...[
                  5.verticalSpace,
                  user.phone!.caption,
                ],
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: user.isActive
                      ? Colors.green.withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
                  borderRadius: 5.r,
                ),
                child: (user.isActive ? 'Active' : 'Inactive').caption.colors(
                  user.isActive ? Colors.green : Colors.red,
                ),
              ),
              10.verticalSpace,
              IconButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditUserScreen(user: user),
                    ),
                  );
                  if (result == true) {
                    context.read<UsersCubit>().refreshUsers();
                  }
                },
                icon: const Icon(Icons.edit, size: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
