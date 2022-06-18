import 'package:dio/dio.dart';
import 'package:test_val/service/dio_service.dart';
import 'package:test_val/dto/product_model_category_dto.dart';
import 'package:test_val/dto/generic/list_response_dto.dart';

class ProductModelCategoryService {
  static final ProductModelCategoryService _instance =
      ProductModelCategoryService._internal();
  final Dio dio;

  ProductModelCategoryService._internal() : dio = DioService.withToken;

  static ProductModelCategoryService get getInstance => _instance;

  Future<List<ProductModelCategoryDto>> getAllCategories() async {
    Response response = await dio.get("/categories");
    ListResponseDto<ProductModelCategoryDto> elements =
        ListResponseDto.fromJson(
            response.data, ProductModelCategoryDto.fromJsonModel);
    return elements.elements;
  }
}
