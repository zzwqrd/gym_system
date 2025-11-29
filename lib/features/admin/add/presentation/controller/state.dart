import '../../../../../../core/utils/enums.dart';

class AddAdminState {
  final RequestState requestState;
  final String errorMessage;

  AddAdminState({
    this.requestState = RequestState.initial,
    this.errorMessage = '',
  });

  AddAdminState copyWith({RequestState? requestState, String? errorMessage}) {
    return AddAdminState(
      requestState: requestState ?? this.requestState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
