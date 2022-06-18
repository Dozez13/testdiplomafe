// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shoes_model_price_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShoesModelPriceDto _$ShoesModelPriceDtoFromJson(Map<String, dynamic> json) =>
    ShoesModelPriceDto(
      minPrice: (json['minPrice'] as num).toDouble(),
      maxPrice: (json['maxPrice'] as num).toDouble(),
    );

Map<String, dynamic> _$ShoesModelPriceDtoToJson(ShoesModelPriceDto instance) =>
    <String, dynamic>{
      'minPrice': instance.minPrice,
      'maxPrice': instance.maxPrice,
    };
