import 'package:dio_rxdart/network/user_api_provider.dart';
import 'package:dio_rxdart/user/model/user_response.dart';

class UserRepository{
  UserApiProvider _apiProvider = UserApiProvider();

  Future<UserResponse> getUser(){
    return _apiProvider.getUser();
  }
}