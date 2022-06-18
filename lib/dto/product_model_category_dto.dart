import 'package:json_annotation/json_annotation.dart';

part 'product_model_category_dto.g.dart';

@JsonSerializable()
class ProductModelCategoryDto {
  String categoryName;
  String image;

  ProductModelCategoryDto({required this.categoryName, required this.image});

  static ProductModelCategoryDto fromJsonModel(Object? json) => ProductModelCategoryDto.fromJson(json as Map<String,dynamic>);
  static Map<String, dynamic> toJsonModel(ProductModelCategoryDto productModelCategoryDto) => productModelCategoryDto.toJson();

  factory ProductModelCategoryDto.fromJson(Map<String, dynamic> json) => _$ProductModelCategoryDtoFromJson(json);


  Map<String, dynamic> toJson() => _$ProductModelCategoryDtoToJson(this);
}