import 'data_state.dart';

class ErrorHandler {
  static DataState<T> handle<T>(Object e) {
    return DataFailed<T>(e.toString());
  }
}
