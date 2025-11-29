import '../../../../../../core/utils/enums.dart';

class AddUserState {
  final RequestState requestState;
  final String errorMessage;

  AddUserState({
    this.requestState = RequestState.initial,
    this.errorMessage = '',
  });

  AddUserState copyWith({RequestState? requestState, String? errorMessage}) {
    return AddUserState(
      requestState: requestState ?? this.requestState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
