import 'package:json_annotation/json_annotation.dart';
import 'package:test_val/dto/shoes_size_dto.dart';

part 'shoes_creation_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class ShoesCreationDto {
  List<String> images;
  ShoesSizeDto size;
  double price;
  String color;

  ShoesCreationDto(
      {required this.images,
      required this.size,
      required this.price,
      required this.color});

  static ShoesCreationDto fromJsonModel(Object? json) =>
      ShoesCreationDto.fromJson(json as Map<String, dynamic>);

  static Map<String, dynamic> toJsonModel(ShoesCreationDto shoesCreationDto) =>
      shoesCreationDto.toJson();

  factory ShoesCreationDto.fromJson(Map<String, dynamic> json) =>
      _$ShoesCreationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ShoesCreationDtoToJson(this);
}
