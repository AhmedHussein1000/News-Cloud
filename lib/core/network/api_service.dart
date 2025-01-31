// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:news_app/core/errors/exceptions.dart';
import 'package:news_app/core/errors/failures.dart';
import 'package:news_app/core/network/api_constants.dart';

class ApiService {
  static late Dio dio;

  static void initializeDio() {
    dio = Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 30),
    ));
  }

  Future<Response> getData({
    required String endPoint,
    Map<String, dynamic>? queryParams,
    Options? options,
  }) async {
    try {
      return await dio.get(
        endPoint,
        queryParameters: queryParams,
        options: options,
      );
    } on DioException catch (e) {
      throw DioNetworkException(
          ServerFailure.fromDioError(dioException: e).message);
    }
  }
}
