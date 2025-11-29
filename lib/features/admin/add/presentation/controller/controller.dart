import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/utils/enums.dart';
import '../../data/model/send_data.dart';
import '../../domain/usecases/usecase.dart';
import 'state.dart';

class AddAdminController extends Cubit<AddAdminState> {
  AddAdminController() : super(AddAdminState());

  final AddAdminUseCase _useCase = AddAdminUseCaseImpl();

  Future<void> addAdmin(SendData sendData) async {
    emit(state.copyWith(requestState: RequestState.loading));
    final response = await _useCase.addAdmin(sendData);

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
