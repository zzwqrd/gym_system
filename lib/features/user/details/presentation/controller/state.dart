import '../../../../../../core/utils/enums.dart';
import '../../data/model/model.dart';

class UserDetailsState {
  final RequestState requestState;
  final User? data;
  final String errorMessage;

  UserDetailsState({
    this.requestState = RequestState.initial,
    this.data,
    this.errorMessage = '',
  });

  UserDetailsState copyWith({
    RequestState? requestState,
    User? data,
    String? errorMessage,
  }) {
    return UserDetailsState(
      requestState: requestState ?? this.requestState,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
