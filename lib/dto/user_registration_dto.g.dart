// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_registration_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRegistrationDto _$UserRegistrationDtoFromJson(Map<String, dynamic> json) =>
    UserRegistrationDto(
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      password: json['password'] as String,
      birthDate: json['birthDate'] as String,
    );

Map<String, dynamic> _$UserRegistrationDtoToJson(
        UserRegistrationDto instance) =>
    <String, dynamic>{
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'password': instance.password,
      'birthDate': instance.birthDate,
    };
