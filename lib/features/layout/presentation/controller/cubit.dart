import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_system/features/admin/presentation/pages/view.dart';
import 'package:gym_system/features/home/presentation/pages/view.dart';
import 'package:gym_system/features/layout/presentation/controller/state.dart';
import 'package:gym_system/features/users/presentation/pages/view.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitialState());

  static LayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    const HomeView(),
    const UsersView(),
    const AdminView(),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(LayoutChangeBottomNavState());
  }
}
