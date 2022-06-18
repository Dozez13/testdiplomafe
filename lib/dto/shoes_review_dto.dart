import 'package:json_annotation/json_annotation.dart';

part 'shoes_review_dto.g.dart';

@JsonSerializable()
class ShoesReviewDto{
   String firstName;
   String lastName;
   int rating;
   String reviewDateTime;
   String payload;

   ShoesReviewDto({required this.firstName, required this.lastName, required this.rating,
      required this.reviewDateTime, required this.payload});

   static ShoesReviewDto fromJsonModel(Object? json) => ShoesReviewDto.fromJson(json as Map<String,dynamic>);
   static Map<String, dynamic> toJsonModel(ShoesReviewDto shoesReviewDto) => shoesReviewDto.toJson();

   factory ShoesReviewDto.fromJson(Map<String, dynamic> json) => _$ShoesReviewDtoFromJson(json);

   Map<String, dynamic> toJson() => _$ShoesReviewDtoToJson(this);

}