import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_system/di/service_locator.dart';
import 'package:gym_system/features/layout/presentation/controller/cubit.dart';
import 'package:gym_system/features/layout/presentation/controller/state.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  late final LayoutCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = sl<LayoutCubit>();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: BlocBuilder<LayoutCubit, LayoutStates>(
        buildWhen: (previous, current) => current is LayoutChangeBottomNavState,
        builder: (context, state) {
          return Scaffold(
            body: _cubit.screens[_cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _cubit.currentIndex,
              onTap: (index) {
                _cubit.changeBottomNav(index);
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
