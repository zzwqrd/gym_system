import '../../../../../../core/utils/enums.dart';
import '../../data/model/model.dart';

class AdminListState {
  final RequestState requestState;
  final List<Admin> data;
  final String errorMessage;

  AdminListState({
    this.requestState = RequestState.initial,
    this.data = const [],
    this.errorMessage = '',
  });

  AdminListState copyWith({
    RequestState? requestState,
    List<Admin>? data,
    String? errorMessage,
  }) {
    return AdminListState(
      requestState: requestState ?? this.requestState,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
