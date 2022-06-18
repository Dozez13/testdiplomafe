import 'package:json_annotation/json_annotation.dart';

part 'shoes_similar_image_dto.g.dart';

@JsonSerializable()
class ShoesSimilarImageDto{
   String base64Image;

   ShoesSimilarImageDto({required this.base64Image});
   static ShoesSimilarImageDto fromJsonModel(Object? json) => ShoesSimilarImageDto.fromJson(json as Map<String,dynamic>);
   static Map<String, dynamic> toJsonModel(ShoesSimilarImageDto shoesSimilarImageDto) => shoesSimilarImageDto.toJson();

   factory ShoesSimilarImageDto.fromJson(Map<String, dynamic> json) => _$ShoesSimilarImageDtoFromJson(json);

   Map<String, dynamic> toJson() => _$ShoesSimilarImageDtoToJson(this);
}