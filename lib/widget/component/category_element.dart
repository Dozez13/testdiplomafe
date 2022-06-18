import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:test_val/dto/product_model_category_dto.dart';
import 'package:test_val/enum/model_category.dart';
import 'package:test_val/screen/third_screen.dart';

class CategoryElement extends StatelessWidget {
  final ProductModelCategoryDto productModelCategoryDto;

  const CategoryElement({super.key, required this.productModelCategoryDto});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      margin: EdgeInsets.symmetric(vertical: 10),
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
                return ThirdScreen(
                  modelCategory: ModelCategory.of(
                      uiRepresentation: productModelCategoryDto.categoryName),
                );
              }),
            );
          },
          child: Row(
            children: [
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  productModelCategoryDto.categoryName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "FiraCode",
                    fontSize: 36,
                  ),
                ),
              )),
              Expanded(
                child: Image.memory(
                  base64.decode(productModelCategoryDto.image),
                  filterQuality: FilterQuality.high,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
