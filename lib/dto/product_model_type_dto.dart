import 'package:json_annotation/json_annotation.dart';

part 'product_model_type_dto.g.dart';

@JsonSerializable()
class ProductModelTypeDto {
  String typeName;
  String image;

  ProductModelTypeDto({required this.typeName, required this.image});

  static ProductModelTypeDto fromJsonModel(Object? json) => ProductModelTypeDto.fromJson(json as Map<String,dynamic>);
  static Map<String, dynamic> toJsonModel(ProductModelTypeDto productModelTypeDto) => productModelTypeDto.toJson();

  factory ProductModelTypeDto.fromJson(Map<String, dynamic> json) => _$ProductModelTypeDtoFromJson(json);


  Map<String, dynamic> toJson() => _$ProductModelTypeDtoToJson(this);
}