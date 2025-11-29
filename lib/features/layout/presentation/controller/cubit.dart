import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_system/features/home/presentation/pages/view.dart';
import 'package:gym_system/features/layout/presentation/controller/state.dart';

import '../../../admin/list/presentation/pages/view.dart';
import '../../../user/list/presentation/pages/view.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitialState());

  static LayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    const HomeView(),
    const UserListView(),
    const AdminListView(),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(LayoutChangeBottomNavState());
  }
}
