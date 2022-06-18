import 'package:dio/dio.dart';
import 'package:test_val/dto/generic/list_response_dto.dart';
import 'package:test_val/dto/shoes_creation_variation_dto.dart';
import 'package:test_val/dto/shoes_model_creation_dto.dart';
import 'package:test_val/dto/shoes_model_dto.dart';
import 'package:test_val/dto/shoes_model_price_dto.dart';
import 'package:test_val/dto/shoes_similar_image_dto.dart';
import 'package:test_val/dto/shoes_size_dto.dart';
import 'package:test_val/service/dio_service.dart';
import 'package:test_val/util/request_param_util.dart';

class ShoesModelService {
  static final ShoesModelService _instance = ShoesModelService._internal();
  final Dio dio;

  ShoesModelService._internal() : dio = DioService.withToken;

  static ShoesModelService get getInstance => _instance;

  Future<List<String>> getFilteredShoesModelColors(
      Map<String, Map<String, dynamic>> filterFieldsMap) async {
    Map<String, dynamic> queryParams =
        RequestParamUtil.getInstance.getQueryParams(filterFieldsMap);
    Response response = await dio.get("/shoes-models/filter/colors/include",
        queryParameters: queryParams);
    ListResponseDto<String> elements =
        ListResponseDto.fromJson(response.data, (color) => color as String);
    return elements.elements;
  }

  Future<List<String>> getFilteredShoesModelTypes(
      Map<String, Map<String, dynamic>> filterFieldsMap) async {
    Map<String, dynamic> queryParams =
        RequestParamUtil.getInstance.getQueryParams(filterFieldsMap);
    Response response = await dio.get("/shoes-models/filter/types/include",
        queryParameters: queryParams);
    ListResponseDto<String> elements =
        ListResponseDto.fromJson(response.data, (type) => type as String);
    return elements.elements;
  }

  Future<List<ShoesSizeDto>> getFilteredShoesModelSizes(
      Map<String, Map<String, dynamic>> filterFieldsMap) async {
    Map<String, dynamic> queryParams =
        RequestParamUtil.getInstance.getQueryParams(filterFieldsMap);
    Response response = await dio.get("/shoes-models/filter/sizes/include",
        queryParameters: queryParams);
    ListResponseDto<ShoesSizeDto> elements =
        ListResponseDto.fromJson(response.data, ShoesSizeDto.fromJsonModel);
    return elements.elements;
  }

  Future<ShoesModelPriceDto> getFilteredShoesModelPrices(
      Map<String, Map<String, dynamic>> filterFieldsMap) async {
    Map<String, dynamic> queryParams =
        RequestParamUtil.getInstance.getQueryParams(filterFieldsMap);
    Response response = await dio.get("/shoes-models/filter/prices/include",
        queryParameters: queryParams);
    ShoesModelPriceDto shoesModelPriceDto =
        ShoesModelPriceDto.fromJson(response.data);
    return shoesModelPriceDto;
  }

  Future<List<String>> getAllShoesModelColors() async {
    Response response = await dio.get("/shoes-models/filter/colors");
    ListResponseDto<String> elements =
        ListResponseDto.fromJson(response.data, (color) => color as String);
    return elements.elements;
  }

  Future<List<String>> getAllShoesModelTypes() async {
    Response response = await dio.get("/shoes-models/filter/types");
    ListResponseDto<String> elements =
        ListResponseDto.fromJson(response.data, (type) => type as String);
    return elements.elements;
  }

  Future<List<ShoesSizeDto>> getAllShoesModelSizes() async {
    Response response = await dio.get("/shoes-models/filter/sizes");
    ListResponseDto<ShoesSizeDto> elements =
        ListResponseDto.fromJson(response.data, ShoesSizeDto.fromJsonModel);
    return elements.elements;
  }

  Future<ShoesModelPriceDto> getAllShoesModelPrices() async {
    Response response = await dio.get("/shoes-models/filter/prices");
    ShoesModelPriceDto shoesModelPriceDto =
        ShoesModelPriceDto.fromJson(response.data);
    return shoesModelPriceDto;
  }

  Future<List<ShoesModelDto>> getFilteredShoesModel(
      Map<String, Map<String, dynamic>> filterFieldsMap) async {
    Map<String, dynamic> queryParams =
        RequestParamUtil.getInstance.getQueryParams(filterFieldsMap);
    Response response =
        await dio.get("/shoes-models", queryParameters: queryParams);
    ListResponseDto<ShoesModelDto> elements =
        ListResponseDto.fromJson(response.data, ShoesModelDto.fromJsonModel);
    return elements.elements;
  }

  Future<ShoesCreationVariationDto> getShoesCreateInfo() async {
    Response response = await dio.get(
      "/shoes-models/create",
    );
    ShoesCreationVariationDto shoesCreationVariationDto =
        ShoesCreationVariationDto.fromJson(response.data);
    return shoesCreationVariationDto;
  }
  Future<void> createShoesModel(
      {required ShoesModelCreationDto shoesModelCreationDto}) async {
    await dio.post("/shoes-models", data: shoesModelCreationDto.toJson());
  }

  Future<List<ShoesModelDto>> getSimilarImages(ShoesSimilarImageDto shoesSimilarImageDto
      ) async {
    Response response =
    await dio.post("/shoes-models/similar", data: shoesSimilarImageDto.toJson());
    ListResponseDto<ShoesModelDto> elements =
    ListResponseDto.fromJson(response.data, ShoesModelDto.fromJsonModel);
    return elements.elements;
  }

}
