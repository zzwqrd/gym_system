import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_system/di/service_locator.dart';
import 'package:gym_system/features/layout/presentation/controller/cubit.dart';
import 'package:gym_system/features/layout/presentation/controller/state.dart';

class LayoutView extends StatelessWidget {
  const LayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = sl<LayoutCubit>();
    return BlocProvider(
      create: (context) => cubit,
      child: BlocBuilder<LayoutCubit, LayoutStates>(
        buildWhen: (previous, current) => current is LayoutChangeBottomNavState,
        builder: (context, state) {
          return Scaffold(
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNav(index);
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Users',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.admin_panel_settings),
                  label: 'Admin',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
