import 'package:dio/dio.dart';
import 'package:test_val/dto/generic/list_response_dto.dart';
import 'package:test_val/dto/shoes_review_create_dto.dart';
import 'package:test_val/dto/shoes_review_dto.dart';
import 'package:test_val/service/dio_service.dart';

class ShoesReviewService {
  static final ShoesReviewService _instance = ShoesReviewService._internal();
  final Dio dio;

  ShoesReviewService._internal() : dio = DioService.withToken;

  static ShoesReviewService get getInstance => _instance;

  Future<List<ShoesReviewDto>> getShoesReview({required int shoesId}) async {
    Response response = await dio.get("/shoes-reviews/$shoesId");
    ListResponseDto<ShoesReviewDto> elements =
        ListResponseDto.fromJson(response.data, ShoesReviewDto.fromJsonModel);
    return elements.elements;
  }

  Future<void> createReview(
      {required ShoesReviewCreateDto shoesReviewCreateDto}) async {
    await dio.post("/shoes-reviews", data: shoesReviewCreateDto.toJson());
  }
}
