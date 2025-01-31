import 'dart:developer';
import 'package:dio/dio.dart';

abstract class Failure {
  final String message;

 const Failure({required this.message});
}

class ServerFailure extends Failure {
 const ServerFailure({required super.message});

  factory ServerFailure.fromDioError({
    required DioException dioException,
  }) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return const ServerFailure(message: 'Connection Timeout');
      case DioExceptionType.sendTimeout:
        return const ServerFailure(message: 'Request Send Timeout');
      case DioExceptionType.receiveTimeout:
        return const ServerFailure(message: 'Response Receive Timeout');
      case DioExceptionType.badCertificate:
        return const ServerFailure(message: 'Invalid SSL Certificate');
      case DioExceptionType.badResponse:
        return ServerFailure._handleStatusCode(response: dioException.response);
      case DioExceptionType.cancel:
        return const ServerFailure(message: 'Request Cancelled');
      case DioExceptionType.connectionError:
        return const ServerFailure(message: 'Network Connection Error');
      case DioExceptionType.unknown:
        return ServerFailure(
          message:
              'Unexpected Error: ${dioException.message ?? 'Unknown error'}',
        );
      
    }
  }

  factory ServerFailure._handleStatusCode({required Response? response}) {
    final statusCode = response?.statusCode;

    switch (statusCode) {
      case 400:
        return const ServerFailure(
            message:
                'Invalid request. Please check the data you have entered.');
      case 401:
        return const ServerFailure(
            message:
                'Unauthorized access. Please check your login credentials.');
      case 403:
        return const ServerFailure(
            message:
                'Access denied. You do not have the required permissions.');
      case 404:
        return const ServerFailure(
            message:
                'Resource not found. The requested item might have been removed.');
      case 500:
        return const ServerFailure(message: 'Server error. Please try again later.');
      case 502:
        return const ServerFailure(
            message: 'Bad Gateway. The server received an invalid response.');
      case 503:
        return const ServerFailure(
            message:
                'Service unavailable. The server is currently unable to handle the request.');
      case 504:
        return const ServerFailure(
            message: 'Gateway timeout. The server did not respond in time.');

      default:
        log('ServerFailure._handleStatusCode statusCode: $statusCode');
        return const ServerFailure(
          message: 'Unexpected Error occurred please try again.',
        );
    }
  }
}
