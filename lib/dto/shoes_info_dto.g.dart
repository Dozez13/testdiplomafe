// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shoes_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShoesInfoDto _$ShoesInfoDtoFromJson(Map<String, dynamic> json) => ShoesInfoDto(
      shoesId: json['shoesId'] as int,
      shoesImages: (json['shoesImages'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      modelName: json['modelName'] as String,
      productPrice: (json['productPrice'] as num).toDouble(),
      colors:
          (json['colors'] as List<dynamic>).map((e) => e as String).toList(),
      sizes: (json['sizes'] as List<dynamic>).map((e) => e as String).toList(),
      countFiveStars: json['countFiveStars'] as int,
      countFourStars: json['countFourStars'] as int,
      countThreeStars: json['countThreeStars'] as int,
      countTwoStars: json['countTwoStars'] as int,
      countOneStars: json['countOneStars'] as int,
      countReviews: json['countReviews'] as int,
      averageRating: (json['averageRating'] as num).toDouble(),
    );

Map<String, dynamic> _$ShoesInfoDtoToJson(ShoesInfoDto instance) =>
    <String, dynamic>{
      'shoesId': instance.shoesId,
      'shoesImages': instance.shoesImages,
      'modelName': instance.modelName,
      'productPrice': instance.productPrice,
      'colors': instance.colors,
      'sizes': instance.sizes,
      'countFiveStars': instance.countFiveStars,
      'countFourStars': instance.countFourStars,
      'countThreeStars': instance.countThreeStars,
      'countTwoStars': instance.countTwoStars,
      'countOneStars': instance.countOneStars,
      'countReviews': instance.countReviews,
      'averageRating': instance.averageRating,
    };
