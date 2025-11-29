import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/utils/enums.dart';
import '../../domain/usecases/usecase.dart';
import 'state.dart';

class AdminListController extends Cubit<AdminListState> {
  AdminListController() : super(AdminListState());

  final AdminListUseCase _useCase = AdminListUseCaseImpl();

  Future<void> getAdmins() async {
    emit(state.copyWith(requestState: RequestState.loading));
    final response = await _useCase.getAdmins();

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

  Future<void> deleteAdmin(int id) async {
    emit(state.copyWith(requestState: RequestState.loading));
    final response = await _useCase.deleteAdmin(id);

    response.when(
      success: (_) {
        getAdmins();
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
