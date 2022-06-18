import 'package:json_annotation/json_annotation.dart';

part 'shoes_model_type_creation_dto.g.dart';

@JsonSerializable()
class ShoesModelTypeCreationDto{
   int id;

   String typeName;

   ShoesModelTypeCreationDto({required this.id,required this.typeName});


   static ShoesModelTypeCreationDto fromJsonModel(Object? json) => ShoesModelTypeCreationDto.fromJson(json as Map<String,dynamic>);
   static Map<String, dynamic> toJsonModel(ShoesModelTypeCreationDto shoesModelTypeCreationDto) => shoesModelTypeCreationDto.toJson();

   factory ShoesModelTypeCreationDto.fromJson(Map<String, dynamic> json) => _$ShoesModelTypeCreationDtoFromJson(json);

   Map<String, dynamic> toJson() => _$ShoesModelTypeCreationDtoToJson(this);

}