// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shoes_creation_variation_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShoesCreationVariationDto _$ShoesCreationVariationDtoFromJson(
        Map<String, dynamic> json) =>
    ShoesCreationVariationDto(
      colors:
          (json['colors'] as List<dynamic>).map((e) => e as String).toList(),
      productCountryTypes: (json['productCountryTypes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ShoesCreationVariationDtoToJson(
        ShoesCreationVariationDto instance) =>
    <String, dynamic>{
      'colors': instance.colors,
      'productCountryTypes': instance.productCountryTypes,
    };
