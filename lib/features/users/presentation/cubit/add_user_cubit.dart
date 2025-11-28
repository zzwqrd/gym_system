import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_system/core/utils/enums.dart';
import 'package:gym_system/features/users/data/models/user_model.dart';
import 'package:gym_system/features/users/domin/usecases/users_usecase.dart';

// States
abstract class AddUserState {}

class AddUserInitial extends AddUserState {}

class AddUserLoading extends AddUserState {}

class AddUserSuccess extends AddUserState {
  final String message;
  AddUserSuccess(this.message);
}

class AddUserFailure extends AddUserState {
  final String message;
  AddUserFailure(this.message);
}

// Cubit
class AddUserCubit extends Cubit<AddUserState> {
  final UsersUseCase _usersUseCase;

  AddUserCubit(this._usersUseCase) : super(AddUserInitial());

  Future<void> addUser(UserModel user) async {
    emit(AddUserLoading());
    final response = await _usersUseCase.addUser(user);

    if (response.state == ResponseState.success) {
      emit(AddUserSuccess(response.message ?? 'User added successfully'));
    } else {
      emit(AddUserFailure(response.message ?? 'Failed to add user'));
    }
  }
}
