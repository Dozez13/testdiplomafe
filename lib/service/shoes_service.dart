import 'package:dio/dio.dart';
import 'package:test_val/dto/shoes_info_dto.dart';
import 'package:test_val/service/dio_service.dart';

class ShoesService {
  static final ShoesService _instance = ShoesService._internal();
  final Dio dio;

  ShoesService._internal() : dio = DioService.withToken;

  static ShoesService get getInstance => _instance;

  Future<ShoesInfoDto> getShoesInfoDto({required int shoesId}) async {
    Response response = await dio.get(
      "/shoes/$shoesId",
    );
    ShoesInfoDto shoesInfoDto = ShoesInfoDto.fromJson(response.data);
    return shoesInfoDto;
  }
}
