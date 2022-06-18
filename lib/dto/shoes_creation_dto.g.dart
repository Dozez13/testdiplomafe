// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shoes_creation_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShoesCreationDto _$ShoesCreationDtoFromJson(Map<String, dynamic> json) =>
    ShoesCreationDto(
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      size: ShoesSizeDto.fromJson(json['size'] as Map<String, dynamic>),
      price: (json['price'] as num).toDouble(),
      color: json['color'] as String,
    );

Map<String, dynamic> _$ShoesCreationDtoToJson(ShoesCreationDto instance) =>
    <String, dynamic>{
      'images': instance.images,
      'size': instance.size.toJson(),
      'price': instance.price,
      'color': instance.color,
    };
