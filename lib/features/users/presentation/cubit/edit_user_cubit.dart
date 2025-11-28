import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_system/core/utils/enums.dart';
import 'package:gym_system/features/users/data/models/user_model.dart';
import 'package:gym_system/features/users/domin/usecases/users_usecase.dart';

// States
abstract class EditUserState {}

class EditUserInitial extends EditUserState {}

class EditUserLoading extends EditUserState {}

class EditUserSuccess extends EditUserState {
  final String message;
  EditUserSuccess(this.message);
}

class EditUserFailure extends EditUserState {
  final String message;
  EditUserFailure(this.message);
}

// Cubit
class EditUserCubit extends Cubit<EditUserState> {
  final UsersUseCase _usersUseCase;

  EditUserCubit(this._usersUseCase) : super(EditUserInitial());

  Future<void> updateUser(UserModel user) async {
    emit(EditUserLoading());
    final response = await _usersUseCase.updateUser(user);

    if (response.state == ResponseState.success) {
      emit(EditUserSuccess(response.message ?? 'User updated successfully'));
    } else {
      emit(EditUserFailure(response.message ?? 'Failed to update user'));
    }
  }
}
