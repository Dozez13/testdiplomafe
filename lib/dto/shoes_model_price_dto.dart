import 'package:json_annotation/json_annotation.dart';

part 'shoes_model_price_dto.g.dart';

@JsonSerializable()
class ShoesModelPriceDto {
  double minPrice;
  double maxPrice;

  ShoesModelPriceDto({required this.minPrice, required this.maxPrice});

  static ShoesModelPriceDto fromJsonModel(Object? json) =>
      ShoesModelPriceDto.fromJson(json as Map<String, dynamic>);

  static Map<String, dynamic> toJsonModel(
          ShoesModelPriceDto shoesModelPriceDto) =>
      shoesModelPriceDto.toJson();

  factory ShoesModelPriceDto.fromJson(Map<String, dynamic> json) =>
      _$ShoesModelPriceDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ShoesModelPriceDtoToJson(this);
}
