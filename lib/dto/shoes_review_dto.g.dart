// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shoes_review_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShoesReviewDto _$ShoesReviewDtoFromJson(Map<String, dynamic> json) =>
    ShoesReviewDto(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      rating: json['rating'] as int,
      reviewDateTime: json['reviewDateTime'] as String,
      payload: json['payload'] as String,
    );

Map<String, dynamic> _$ShoesReviewDtoToJson(ShoesReviewDto instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'rating': instance.rating,
      'reviewDateTime': instance.reviewDateTime,
      'payload': instance.payload,
    };
