import 'dart:developer';

import 'package:dio_rxdart/user/model/user_response.dart';

import 'package:dio/dio.dart';

class UserApiProvider{
  final String _endpoint = "https://randomuser.me/api/";
  Dio _dio = Dio();

  UserApiProvider(){
    Options options = Options(receiveTimeout: 5000, connectTimeout: 5000);
    _dio = Dio(options);
  }
  Future<UserResponse> getUser() async {
    try {
      Response response = await _dio.get(_endpoint);
      log('response = $response');
      return UserResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return UserResponse.withError(_handleError(error));
    }
  }

  String _handleError(Error error) {
    String errorDescription = "";
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.CANCEL:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.DEFAULT:
          errorDescription =
          "Connection to API server failed due to internet connection";
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.RESPONSE:
          errorDescription =
          "Received invalid status code: ${error.response.statusCode}";
          break;
      }
    } else {
      errorDescription = "Unexpected error occured";
    }
    return errorDescription;
  }
}