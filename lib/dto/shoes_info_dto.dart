import 'package:json_annotation/json_annotation.dart';
part 'shoes_info_dto.g.dart';

@JsonSerializable()
class ShoesInfoDto {
  int shoesId;

  List<String> shoesImages;

  String modelName;

  double productPrice;

  List<String> colors;

  List<String> sizes;

  int countFiveStars;

  int countFourStars;

  int countThreeStars;

  int countTwoStars;

  int countOneStars;

  int countReviews;

  double averageRating;

  ShoesInfoDto(
      {required this.shoesId,
      required this.shoesImages,
      required this.modelName,
      required this.productPrice,
      required this.colors,
      required this.sizes,
      required this.countFiveStars,
      required this.countFourStars,
      required this.countThreeStars,
      required this.countTwoStars,
      required this.countOneStars,
      required this.countReviews,
      required this.averageRating});


  static ShoesInfoDto fromJsonModel(Object? json) =>
      ShoesInfoDto.fromJson(json as Map<String, dynamic>);

  static Map<String, dynamic> toJsonModel(
      ShoesInfoDto shoesInfoDto) =>
      shoesInfoDto.toJson();

  factory ShoesInfoDto.fromJson(Map<String, dynamic> json) =>
      _$ShoesInfoDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ShoesInfoDtoToJson(this);
}
