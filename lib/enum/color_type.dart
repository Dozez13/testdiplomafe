import 'package:flutter/material.dart';

enum ColorType{
  white(uiRepresentation: "WHITE"), black(uiRepresentation: "BLACK"), blue(uiRepresentation: "BLUE"), green(uiRepresentation: "GREEN"), yellow(uiRepresentation: "YELLOW");
  final String uiRepresentation;

  const ColorType({required this.uiRepresentation});

  static ColorType of({required String uiRepresentation}) {
    return values.firstWhere(
            (element) => element.uiRepresentation == uiRepresentation,
        orElse: () => ColorType.white);
  }
}
extension ColorTypeExtension on ColorType{
  Color? get color{
    switch(this){
      case ColorType.white:
        return Colors.white;
      case ColorType.black:
        return Colors.black;
      case ColorType.blue:
        return Colors.blue;
      case ColorType.green:
        return Colors.green;
      case ColorType.yellow:
        return Colors.yellow;
      default:
        return null;
    }
  }
}