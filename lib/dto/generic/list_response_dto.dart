import 'package:json_annotation/json_annotation.dart';

part 'list_response_dto.g.dart';

@JsonSerializable(explicitToJson: true, genericArgumentFactories: true)
class ListResponseDto<T> {
  List<T> elements;

  ListResponseDto({required this.elements});
  factory ListResponseDto.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ListResponseDtoFromJson<T>(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T) toJsonT) =>
      _$ListResponseDtoToJson<T>(this, toJsonT);
}
