// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shoes_model_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShoesModelDto _$ShoesModelDtoFromJson(Map<String, dynamic> json) =>
    ShoesModelDto(
      id: json['id'] as int,
      modelName: json['modelName'] as String,
      productPrice: (json['productPrice'] as num).toDouble(),
      image: json['image'] as String,
    );

Map<String, dynamic> _$ShoesModelDtoToJson(ShoesModelDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'modelName': instance.modelName,
      'productPrice': instance.productPrice,
      'image': instance.image,
    };
