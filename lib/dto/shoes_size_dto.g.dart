// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shoes_size_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShoesSizeDto _$ShoesSizeDtoFromJson(Map<String, dynamic> json) => ShoesSizeDto(
      size: (json['size'] as num).toDouble(),
      countryType: json['countryType'] as String,
    );

Map<String, dynamic> _$ShoesSizeDtoToJson(ShoesSizeDto instance) =>
    <String, dynamic>{
      'size': instance.size,
      'countryType': instance.countryType,
    };
