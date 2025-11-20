// lib/features/users/presentation/cubit/get_data_user_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/database/db_helper.dart';
import 'user_model.dart';

class GetDataUserCubit extends Cubit<GetDataUserState> {
  final DBHelper _dbHelper = DBHelper();

  GetDataUserCubit() : super(GetDataUserInitial());

  // جلب كل المستخدمين
  Future<void> getAllUsers() async {
    try {
      emit(GetDataUserLoading());

      final results = await _dbHelper.table('users').get();

      final users = results.map((userMap) => User.fromMap(userMap)).toList();

      emit(GetDataUserLoaded(users));
    } catch (e) {
      emit(GetDataUserError('Failed to load users: $e'));
    }
  }

  // جلب مستخدم واحد
  Future<void> getFirstUser() async {
    try {
      emit(GetDataUserLoading());

      final userMap = await _dbHelper.table('users').first();

      if (userMap != null) {
        final user = User.fromMap(userMap);
        emit(GetDataUserLoaded([user]));
      } else {
        emit(GetDataUserError('No users found'));
      }
    } catch (e) {
      emit(GetDataUserError('Failed to load user: $e'));
    }
  }

  // جلب مستخدم بالإيميل
  Future<void> getUserByEmail(String email) async {
    try {
      emit(GetDataUserLoading());

      final userMap = await _dbHelper
          .table('users')
          .where('email', email)
          .first();

      if (userMap != null) {
        final user = User.fromMap(userMap);
        emit(GetDataUserLoaded([user]));
      } else {
        emit(GetDataUserError('User not found'));
      }
    } catch (e) {
      emit(GetDataUserError('Failed to load user: $e'));
    }
  }

  // جلب المستخدمين النشطين فقط
  Future<void> getActiveUsers() async {
    try {
      emit(GetDataUserLoading());

      final results = await _dbHelper
          .table('users')
          .where('is_active', 1)
          .get();

      final users = results.map((userMap) => User.fromMap(userMap)).toList();

      emit(GetDataUserLoaded(users));
    } catch (e) {
      emit(GetDataUserError('Failed to load active users: $e'));
    }
  }

  // تحديث State
  void reset() {
    emit(GetDataUserInitial());
  }
}

class GetDataUserState {}

class GetDataUserInitial extends GetDataUserState {}

class GetDataUserLoading extends GetDataUserState {}

class GetDataUserLoaded extends GetDataUserState {
  final List<User> users;
  GetDataUserLoaded(this.users);
}

class GetDataUserError extends GetDataUserState {
  final String message;
  GetDataUserError(this.message);
}
