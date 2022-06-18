import 'package:json_annotation/json_annotation.dart';

part 'shoes_size_dto.g.dart';

@JsonSerializable()
class ShoesSizeDto {
  double size;
  String countryType;

  ShoesSizeDto({required this.size, required this.countryType});

  static ShoesSizeDto fromJsonModel(Object? json) => ShoesSizeDto.fromJson(json as Map<String,dynamic>);
  static Map<String, dynamic> toJsonModel(ShoesSizeDto shoesSizeDto) => shoesSizeDto.toJson();

  factory ShoesSizeDto.fromJson(Map<String, dynamic> json) => _$ShoesSizeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ShoesSizeDtoToJson(this);


}
