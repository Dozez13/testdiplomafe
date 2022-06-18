// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shoes_model_creation_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShoesModelCreationDto _$ShoesModelCreationDtoFromJson(
        Map<String, dynamic> json) =>
    ShoesModelCreationDto(
      modelName: json['modelName'] as String,
      type: ShoesModelTypeCreationDto.fromJson(
          json['type'] as Map<String, dynamic>),
      products: (json['products'] as List<dynamic>)
          .map((e) => ShoesCreationDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ShoesModelCreationDtoToJson(
        ShoesModelCreationDto instance) =>
    <String, dynamic>{
      'modelName': instance.modelName,
      'type': instance.type.toJson(),
      'products': instance.products.map((e) => e.toJson()).toList(),
    };
