import 'package:json_annotation/json_annotation.dart';
import 'package:test_val/dto/shoes_model_type_creation_dto.dart';
import 'package:test_val/dto/shoes_creation_dto.dart';

part 'shoes_model_creation_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class ShoesModelCreationDto {
  String modelName;
  ShoesModelTypeCreationDto type;
  List<ShoesCreationDto> products;

  ShoesModelCreationDto(
      {required this.modelName, required this.type, required this.products});

  static ShoesModelCreationDto fromJsonModel(Object? json) =>
      ShoesModelCreationDto.fromJson(json as Map<String, dynamic>);

  static Map<String, dynamic> toJsonModel(
          ShoesModelCreationDto shoesModelCreationDto) =>
      shoesModelCreationDto.toJson();

  factory ShoesModelCreationDto.fromJson(Map<String, dynamic> json) =>
      _$ShoesModelCreationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ShoesModelCreationDtoToJson(this);
}
