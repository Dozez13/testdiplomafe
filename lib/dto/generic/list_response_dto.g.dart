// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListResponseDto<T> _$ListResponseDtoFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ListResponseDto<T>(
      elements: (json['elements'] as List<dynamic>).map(fromJsonT).toList(),
    );

Map<String, dynamic> _$ListResponseDtoToJson<T>(
  ListResponseDto<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'elements': instance.elements.map(toJsonT).toList(),
    };
