import 'package:dartz/dartz.dart';

import '../utils/enums.dart';

class HelperResponse<T> {
  final ResponseState state;
  final bool success;
  final String message;
  final T? data;
  final ErrorRequestType? errorType;

  HelperResponse({
    required this.state,
    required this.success,
    required this.message,
    this.data,
    this.errorType,
  });

  // === Factories للنجاح ===
  factory HelperResponse.success({
    T? data,
    String message = 'تمت العملية بنجاح',
  }) {
    return HelperResponse<T>(
      state: ResponseState.success,
      success: true,
      message: message,
      data: data,
    );
  }

  // === Factories للفشل ===
  factory HelperResponse.error({
    required String message,
    ErrorRequestType errorType = ErrorRequestType.unknown,
  }) {
    return HelperResponse<T>(
      state: ResponseState.error,
      success: false,
      message: message,
      errorType: errorType,
    );
  }

  factory HelperResponse.notFound({String message = 'السجل غير موجود'}) {
    return HelperResponse<T>(
      state: ResponseState.notFound,
      success: false,
      message: message,
      errorType: ErrorRequestType.notFound,
    );
  }

  factory HelperResponse.validationError({
    String message = 'بيانات غير صالحة',
  }) {
    return HelperResponse<T>(
      state: ResponseState.validationError,
      success: false,
      message: message,
      errorType: ErrorRequestType.validationError,
    );
  }

  factory HelperResponse.authenticationError({
    String message = 'خطأ في المصادقة',
  }) {
    return HelperResponse<T>(
      state: ResponseState.unauthorized,
      success: false,
      message: message,
      errorType: ErrorRequestType.unauthorized,
    );
  }

  factory HelperResponse.loading({String message = 'جاري المعالجة...'}) {
    return HelperResponse<T>(
      state: ResponseState.loading,
      success: false,
      message: message,
    );
  }

  factory HelperResponse.initial() {
    return HelperResponse<T>(
      state: ResponseState.initial,
      success: false,
      message: '',
    );
  }

  // === Methods مساعدة ===
  bool get hasData => data != null;
  bool get isLoading => state == ResponseState.loading;
  bool get isSuccess => state == ResponseState.success;
  bool get isError => state == ResponseState.error;

  // الدالة المطلوبة - مبسطة
  R when<R>({
    required R Function(T data) success,
    required R Function(String message, ErrorRequestType? errorType) error,
    R Function()? loading,
    R Function()? initial,
  }) {
    switch (state) {
      case ResponseState.success:
        return success(data as T);
      case ResponseState.loading:
        return loading?.call() ?? error('جاري المعالجة...', null);
      case ResponseState.initial:
        return initial?.call() ?? error('', null);
      default:
        return error(message, errorType);
    }
  }

  // دالة toEither مبسطة
  Either<String, T> toEither() {
    if (isSuccess && data != null) {
      return Right(data as T);
    } else {
      return Left(message);
    }
  }

  // أو نسخة أكثر مرونة
  Either<HelperResponse<T>, T> toEitherWithResponse() {
    if (isSuccess && data != null) {
      return Right(data as T);
    } else {
      return Left(this);
    }
  }

  @override
  String toString() {
    return 'HelperResponse(state: $state, success: $success, message: $message)';
  }
}
