import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_val/dto/product_model_type_dto.dart';
import 'package:test_val/enum/model_type.dart';
import 'package:test_val/screen/fourth_screen.dart';

class TypeElement extends StatelessWidget {
  final ProductModelTypeDto productModelTypeDto;

  const TypeElement({super.key, required this.productModelTypeDto});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Ink(
        color: Color.fromRGBO(215, 215, 215, 1.0),
        child: InkWell(
          splashColor: Color.fromRGBO(140, 201, 238, 0.6),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return FourthScreen(
                  filterFieldsMap: {
                    "category": ModelType.of(
                                uiRepresentation:
                                    productModelTypeDto.typeName) ==
                            ModelType.allShoes
                        ? {}
                        : {
                            productModelTypeDto.typeName: true,
                          },
                    "color": {},
                    "price": {},
                    "size": {
                      "EU": {},
                      "UK": {},
                      "US": {},
                    },
                    "sort": {},
                  },
                );
              }),
            );
          },
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Image.memory(
                  base64.decode(productModelTypeDto.image),
                  filterQuality: FilterQuality.high,
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      productModelTypeDto.typeName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "FiraCode",
                        fontSize: 24,
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
