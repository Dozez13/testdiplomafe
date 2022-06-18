import 'package:dio/dio.dart';
import 'package:test_val/service/dio_service.dart';
import 'package:test_val/dto/product_model_type_dto.dart';
import 'package:test_val/dto/generic/list_response_dto.dart';
import 'package:test_val/dto/shoes_model_type_creation_dto.dart';

class ShoesModelTypeService {
  static final ShoesModelTypeService _instance =
      ShoesModelTypeService._internal();
  final Dio dio;

  ShoesModelTypeService._internal() : dio = DioService.withToken;

  static ShoesModelTypeService get getInstance => _instance;

  Future<List<ProductModelTypeDto>> getAllShoesTypes() async {
    Response response = await dio.get("/shoes-model-types");
    ListResponseDto<ProductModelTypeDto> elements = ListResponseDto.fromJson(
        response.data, ProductModelTypeDto.fromJsonModel);
    return elements.elements;
  }
  Future<List<ShoesModelTypeCreationDto>> getAllShoesTypesWitId() async {
    Response response = await dio.get("/shoes-model-types/shoes-create");
    ListResponseDto<ShoesModelTypeCreationDto> elements = ListResponseDto.fromJson(
        response.data, ShoesModelTypeCreationDto.fromJsonModel);
    return elements.elements;
  }



}
