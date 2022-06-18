import 'package:dio/dio.dart';
import 'package:test_val/dto/user_basic_dto.dart';
import 'package:test_val/service/dio_service.dart';

class UserService{
  static final UserService _instance = UserService._internal();
  final Dio dio;

  UserService._internal() : dio = DioService.withToken;

  static UserService get getInstance => _instance;

  Future<UserBasicDto> getUserFirstLastName() async {
    Response response = await dio.get(
      "/users/basicCredentials",
    );
    UserBasicDto shoesInfoDto = UserBasicDto.fromJson(response.data);
    return shoesInfoDto;
  }
}