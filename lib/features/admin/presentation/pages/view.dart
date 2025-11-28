import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_system/core/utils/ui_extensions/extensions_init.dart';
import 'package:gym_system/features/admin/data/models/admin_model.dart';
import 'package:gym_system/features/admin/domin/usecases/admins_usecase.dart';
import 'package:gym_system/features/admin/presentation/cubit/admins_cubit.dart';
import 'package:gym_system/features/admin/presentation/pages/add_admin_screen.dart';
import 'package:gym_system/features/admin/presentation/pages/edit_admin_screen.dart';

class AdminView extends StatelessWidget {
  const AdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminsCubit(AdminsUseCaseImpl())..getAdmins(),
      child: const AdminViewBody(),
    );
  }
}

class AdminViewBody extends StatefulWidget {
  const AdminViewBody({super.key});

  @override
  State<AdminViewBody> createState() => _AdminViewBodyState();
}

class _AdminViewBodyState extends State<AdminViewBody> {
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
                'Admins Management'.h3,
                10.verticalSpace,
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search admins...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(borderRadius: 10.r),
                    contentPadding: 10.p,
                  ),
                  onChanged: (value) {
                    context.read<AdminsCubit>().searchAdmins(value);
                  },
                ),
              ],
            ),
          ),

          // Admins List
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await context.read<AdminsCubit>().refreshAdmins();
                _searchController.clear();
              },
              child: BlocBuilder<AdminsCubit, AdminsState>(
                builder: (context, state) {
                  if (state is AdminsLoading) {
                    return const CircularProgressIndicator().center;
                  } else if (state is AdminsError) {
                    return state.message.body.center;
                  } else if (state is AdminsLoaded) {
                    if (state.admins.isEmpty) {
                      return 'No admins found'.body.center;
                    }
                    return ListView.separated(
                      padding: 20.p,
                      itemCount: state.admins.length,
                      separatorBuilder: (context, index) => 10.verticalSpace,
                      itemBuilder: (context, index) {
                        final admin = state.admins[index];
                        return _AdminItem(admin: admin);
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
            MaterialPageRoute(builder: (_) => const AddAdminScreen()),
          );
          if (result == true) {
            context.read<AdminsCubit>().refreshAdmins();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _AdminItem extends StatelessWidget {
  final AdminModel admin;

  const _AdminItem({required this.admin});

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
            backgroundColor: Colors.purple.shade100,
            child: admin.name[0].toUpperCase().h4.colors(Colors.purple),
          ),
          15.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                admin.name.h6.bold(),
                5.verticalSpace,
                admin.email.caption,
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
                  color: admin.isActive
                      ? Colors.green.withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
                  borderRadius: 5.r,
                ),
                child: (admin.isActive ? 'Active' : 'Inactive').caption.colors(
                  admin.isActive ? Colors.green : Colors.red,
                ),
              ),
              10.verticalSpace,
              IconButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditAdminScreen(admin: admin),
                    ),
                  );
                  if (result == true) {
                    context.read<AdminsCubit>().refreshAdmins();
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
