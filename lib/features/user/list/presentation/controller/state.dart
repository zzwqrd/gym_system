import '../../../../../../core/utils/enums.dart';
import '../../data/model/model.dart';

class UserListState {
  final RequestState requestState;
  final List<User> data;
  final String errorMessage;

  UserListState({
    this.requestState = RequestState.initial,
    this.data = const [],
    this.errorMessage = '',
  });

  UserListState copyWith({
    RequestState? requestState,
    List<User>? data,
    String? errorMessage,
  }) {
    return UserListState(
      requestState: requestState ?? this.requestState,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
