import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/utils/enums.dart';
import '../../domain/usecases/usecase.dart';
import 'state.dart';

class UserListController extends Cubit<UserListState> {
  UserListController() : super(UserListState());

  final UserListUseCase _useCase = UserListUseCaseImpl();

  Future<void> getUsers() async {
    emit(state.copyWith(requestState: RequestState.loading));
    final response = await _useCase.getUsers();

    response.when(
      success: (data) {
        emit(state.copyWith(requestState: RequestState.done, data: data));
      },
      error: (message, errorType) {
        emit(
          state.copyWith(
            requestState: RequestState.error,
            errorMessage: message,
          ),
        );
      },
    );
  }

  Future<void> deleteUser(int id) async {
    emit(state.copyWith(requestState: RequestState.loading));
    final response = await _useCase.deleteUser(id);

    response.when(
      success: (_) {
        getUsers();
      },
      error: (message, errorType) {
        emit(
          state.copyWith(
            requestState: RequestState.error,
            errorMessage: message,
          ),
        );
      },
    );
  }
}
