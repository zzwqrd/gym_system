import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/utils/enums.dart';
import '../../domain/usecases/usecase.dart';
import 'state.dart';

class AdminDetailsController extends Cubit<AdminDetailsState> {
  AdminDetailsController() : super(AdminDetailsState());

  final AdminDetailsUseCase _useCase = AdminDetailsUseCaseImpl();

  Future<void> getAdminById(int id) async {
    emit(state.copyWith(requestState: RequestState.loading));
    final response = await _useCase.getAdminById(id);

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
