import '../../../../../../core/utils/enums.dart';

class EditAdminState {
  final RequestState requestState;
  final String errorMessage;

  EditAdminState({
    this.requestState = RequestState.initial,
    this.errorMessage = '',
  });

  EditAdminState copyWith({RequestState? requestState, String? errorMessage}) {
    return EditAdminState(
      requestState: requestState ?? this.requestState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
