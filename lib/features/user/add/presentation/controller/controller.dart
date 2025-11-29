import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/utils/enums.dart';
import '../../data/model/send_data.dart';
import '../../domain/usecases/usecase.dart';
import 'state.dart';

class AddUserController extends Cubit<AddUserState> {
  AddUserController() : super(AddUserState());

  final AddUserUseCase _useCase = AddUserUseCaseImpl();

  Future<void> addUser(SendData sendData) async {
    emit(state.copyWith(requestState: RequestState.loading));
    final response = await _useCase.addUser(sendData);

    response.when(
      success: (data) {
        emit(state.copyWith(requestState: RequestState.done));
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
