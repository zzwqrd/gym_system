import '../../../../../../core/utils/enums.dart';
import '../../data/model/model.dart';

class AdminDetailsState {
  final RequestState requestState;
  final Admin? data;
  final String errorMessage;

  AdminDetailsState({
    this.requestState = RequestState.initial,
    this.data,
    this.errorMessage = '',
  });

  AdminDetailsState copyWith({
    RequestState? requestState,
    Admin? data,
    String? errorMessage,
  }) {
    return AdminDetailsState(
      requestState: requestState ?? this.requestState,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
