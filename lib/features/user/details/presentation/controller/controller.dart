import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/utils/enums.dart';
import '../../domain/usecases/usecase.dart';
import 'state.dart';

class UserDetailsController extends Cubit<UserDetailsState> {
  UserDetailsController() : super(UserDetailsState());

  final UserDetailsUseCase _useCase = UserDetailsUseCaseImpl();

  Future<void> getUserById(int id) async {
    emit(state.copyWith(requestState: RequestState.loading));
    final response = await _useCase.getUserById(id);

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
}
