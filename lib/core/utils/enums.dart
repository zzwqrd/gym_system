enum RequestState {
  loading,
  done,
  error,
  empty,
  initial;

  bool get isLoading => this == RequestState.loading;

  bool get isDone => this == RequestState.done;

  bool get isError => this == RequestState.error;

  bool get isEmpty => this == RequestState.empty;

  bool get isInitial => this == RequestState.initial;
}

enum ErrorType {
  network,
  server,
  backEndValidation,
  unknown,
  none,
  unAuth,
  empty;

  bool get isNetwork => this == ErrorType.network;

  bool get isServer => this == ErrorType.server;

  bool get isBackEndValidation => this == ErrorType.backEndValidation;

  bool get isUnknown => this == ErrorType.unknown;

  bool get isEmpty => this == ErrorType.empty;

  bool get isUnAuth => this == ErrorType.unAuth;

  bool get isNone => this == ErrorType.none;
}

/// Simplified response states
enum ResponseState {
  success,
  loading,
  initial,
  error,
  notFound,
  validationError,
  unauthorized;

  bool get isSuccess => this == ResponseState.success;
  bool get isLoading => this == ResponseState.loading;
  bool get isInitial => this == ResponseState.initial;
  bool get isError => this == ResponseState.error;
  bool get isNotFound => this == ResponseState.notFound;
  bool get isValidationError => this == ResponseState.validationError;
  bool get isUnauthorized => this == ResponseState.unauthorized;
}

/// Simplified error types
enum ErrorRequestType {
  notFound,
  validationError,
  unauthorized,
  unknown;

  bool get isNotFound => this == ErrorRequestType.notFound;
  bool get isValidationError => this == ErrorRequestType.validationError;
  bool get isUnauthorized => this == ErrorRequestType.unauthorized;
  bool get isUnknown => this == ErrorRequestType.unknown;
}
