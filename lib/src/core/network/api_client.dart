import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../enums/http_method.dart';
import '../errors/exception.dart';

abstract class ApiClient {
  Future<Response> request(
    HttpMethod method,
    String path, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
    dynamic body,
  });
}

/// This class provides http calls using dio package
class ApiClientImpl implements ApiClient {
  final Dio dio;

  ApiClientImpl({required this.dio});

  @override
  Future<Response> request(
    HttpMethod method,
    String path, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
    dynamic body,
  }) async {
    // we can add headers here which are common for every restapi call
    headers ??= <String, dynamic>{};
    headers = {'content-type': 'application/json'};

    try {
      final response = await dio.request(
        path,
        options: Options(
          method: method.apiMethodString,
          headers: headers,
        ),
        queryParameters: queryParams,
        data: body,
      );
      return response;
    } on DioError catch (ex) {
      switch (ex.response?.statusCode) {
        case 400:
          debugPrint("Request was invalid: ${ex.response?.data}");
          throw const ServerException('Invalid Request');
        case 403:
          debugPrint("Request Error: $ex");
          throw ServerException(ex.response?.data['detail'] ?? "Server Error");
        default:
          debugPrint("Request Error: $ex");
          throw const ServerException('Unknown Server Error');
      }
    }
  }
}
