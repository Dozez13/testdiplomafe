import 'package:json_annotation/json_annotation.dart';

part 'user_login_dto.g.dart';

@JsonSerializable()
class UserLoginDto {
  String email;
  String password;

  UserLoginDto({required this.email, required this.password});

  factory UserLoginDto.fromJson(Map<String, dynamic> json) => _$UserLoginDtoFromJson(json);


  Map<String, dynamic> toJson() => _$UserLoginDtoToJson(this);
}
