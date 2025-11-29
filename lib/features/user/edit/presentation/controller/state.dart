import '../../../../../../core/utils/enums.dart';

class EditUserState {
  final RequestState requestState;
  final String errorMessage;

  EditUserState({
    this.requestState = RequestState.initial,
    this.errorMessage = '',
  });

  EditUserState copyWith({RequestState? requestState, String? errorMessage}) {
    return EditUserState(
      requestState: requestState ?? this.requestState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
