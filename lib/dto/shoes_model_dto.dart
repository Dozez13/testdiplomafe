import 'package:json_annotation/json_annotation.dart';
part 'shoes_model_dto.g.dart';

@JsonSerializable()
class ShoesModelDto{

   int id;

   String modelName;

   double productPrice;

   String image;

   ShoesModelDto({required this.id,required this.modelName, required this.productPrice,required this.image});

   static ShoesModelDto fromJsonModel(Object? json) =>
       ShoesModelDto.fromJson(json as Map<String, dynamic>);

   static Map<String, dynamic> toJsonModel(
       ShoesModelDto shoesModelDto) =>
       shoesModelDto.toJson();

   factory ShoesModelDto.fromJson(Map<String, dynamic> json) =>
       _$ShoesModelDtoFromJson(json);

   Map<String, dynamic> toJson() => _$ShoesModelDtoToJson(this);
}