// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_login_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLoginDto _$UserLoginDtoFromJson(Map<String, dynamic> json) => UserLoginDto(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$UserLoginDtoToJson(UserLoginDto instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };
