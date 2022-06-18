
import 'package:json_annotation/json_annotation.dart';

part 'user_registration_dto.g.dart';

@JsonSerializable()
class UserRegistrationDto {
  String email;

  String firstName;

  String lastName;

  String password;

  String birthDate;

  UserRegistrationDto(
      {required this.email,
      required this.firstName,
      required this.lastName,
      required this.password,
      required this.birthDate});

  factory UserRegistrationDto.fromJson(Map<String, dynamic> json) => _$UserRegistrationDtoFromJson(json);


  Map<String, dynamic> toJson() => _$UserRegistrationDtoToJson(this);
}
