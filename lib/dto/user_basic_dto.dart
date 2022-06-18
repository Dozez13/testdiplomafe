import 'package:json_annotation/json_annotation.dart';
part 'user_basic_dto.g.dart';

@JsonSerializable()
class UserBasicDto{
   String firstName;
   String lastName;

   UserBasicDto({required this.firstName,required this.lastName});
   static UserBasicDto fromJsonModel(Object? json) =>
       UserBasicDto.fromJson(json as Map<String, dynamic>);

   static Map<String, dynamic> toJsonModel(
       UserBasicDto userBasicDto) =>
       userBasicDto.toJson();

   factory UserBasicDto.fromJson(Map<String, dynamic> json) =>
       _$UserBasicDtoFromJson(json);

   Map<String, dynamic> toJson() => _$UserBasicDtoToJson(this);

}