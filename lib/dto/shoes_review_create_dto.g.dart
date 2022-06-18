// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shoes_review_create_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShoesReviewCreateDto _$ShoesReviewCreateDtoFromJson(
        Map<String, dynamic> json) =>
    ShoesReviewCreateDto(
      shoesId: json['shoesId'] as int,
      payload: json['payload'] as String,
      rating: json['rating'] as int,
    );

Map<String, dynamic> _$ShoesReviewCreateDtoToJson(
        ShoesReviewCreateDto instance) =>
    <String, dynamic>{
      'shoesId': instance.shoesId,
      'payload': instance.payload,
      'rating': instance.rating,
    };
