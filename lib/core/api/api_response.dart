import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';

@freezed
class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse.success(T data) = Success<T>;
  const factory ApiResponse.error(String message) = Error<T>;
  const factory ApiResponse.loading() = Loading<T>;
}

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException({
    required this.message,
    this.statusCode,
  });

  @override
  String toString() => 'ApiException: $message ${statusCode ?? ''}';
}

extension DioErrorX on Exception {
  String get errorMessage {
    return switch (this) {
      ApiException() => (this as ApiException).message,
      _ => 'An unexpected error occurred',
    };
  }
}
