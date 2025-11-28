import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_system/core/utils/enums.dart';
import 'package:gym_system/features/users/data/models/user_model.dart';
import 'package:gym_system/features/users/domin/usecases/users_usecase.dart';

// States
abstract class UsersState {}

class UsersInitial extends UsersState {}

class UsersLoading extends UsersState {}

class UsersLoaded extends UsersState {
  final List<UserModel> users;
  UsersLoaded(this.users);
}

class UsersError extends UsersState {
  final String message;
  UsersError(this.message);
}

// Cubit
class UsersCubit extends Cubit<UsersState> {
  final UsersUseCase _usersUseCase;

  UsersCubit(this._usersUseCase) : super(UsersInitial());

  List<UserModel> _allUsers = [];

  Future<void> getUsers() async {
    emit(UsersLoading());
    final response = await _usersUseCase.getUsers();

    if (response.state == ResponseState.success) {
      _allUsers = response.data as List<UserModel>;
      emit(UsersLoaded(_allUsers));
    } else {
      emit(UsersError(response.message ?? 'Failed to load users'));
    }
  }

  Future<void> searchUsers(String query) async {
    if (query.isEmpty) {
      emit(UsersLoaded(_allUsers));
      return;
    }

    final filteredUsers = _allUsers.where((user) {
      final searchLower = query.toLowerCase();
      return user.username.toLowerCase().contains(searchLower) ||
          user.email.toLowerCase().contains(searchLower) ||
          (user.firstName?.toLowerCase().contains(searchLower) ?? false) ||
          (user.lastName?.toLowerCase().contains(searchLower) ?? false) ||
          (user.phone?.contains(query) ?? false);
    }).toList();

    emit(UsersLoaded(filteredUsers));
  }

  Future<void> refreshUsers() async {
    await getUsers();
  }
}
