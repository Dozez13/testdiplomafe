import 'package:json_annotation/json_annotation.dart';
part 'shoes_review_create_dto.g.dart';

@JsonSerializable()
class ShoesReviewCreateDto {
  int shoesId;
  String payload;
  int rating;

  ShoesReviewCreateDto(
      {required this.shoesId, required this.payload, required this.rating});

  static ShoesReviewCreateDto fromJsonModel(Object? json) => ShoesReviewCreateDto.fromJson(json as Map<String,dynamic>);
  static Map<String, dynamic> toJsonModel(ShoesReviewCreateDto shoesReviewCreateDto) => shoesReviewCreateDto.toJson();

  factory ShoesReviewCreateDto.fromJson(Map<String, dynamic> json) => _$ShoesReviewCreateDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ShoesReviewCreateDtoToJson(this);
}
