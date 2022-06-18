import 'package:json_annotation/json_annotation.dart';

part 'shoes_creation_variation_dto.g.dart';

@JsonSerializable()
class ShoesCreationVariationDto{
   List<String> colors;
   List<String> productCountryTypes;

   ShoesCreationVariationDto({required this.colors,required this.productCountryTypes});

   static ShoesCreationVariationDto fromJsonModel(Object? json) => ShoesCreationVariationDto.fromJson(json as Map<String,dynamic>);
   static Map<String, dynamic> toJsonModel(ShoesCreationVariationDto shoesCreationVariationDto) => shoesCreationVariationDto.toJson();

   factory ShoesCreationVariationDto.fromJson(Map<String, dynamic> json) => _$ShoesCreationVariationDtoFromJson(json);


   Map<String, dynamic> toJson() => _$ShoesCreationVariationDtoToJson(this);
}