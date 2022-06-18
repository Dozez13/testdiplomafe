import 'package:flutter/material.dart';

class ShopElement extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? imageBackgroundColor;
  final EdgeInsets? margin;
  final GestureTapCallback onTap;
  final Image image;
  final Text productName;
  final Text productPrice;

  const ShopElement(
      {super.key,
      this.margin,
      this.width,
      this.height,
      this.imageBackgroundColor,
      required this.image,
      required this.productName,
      required this.productPrice,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      height: height,
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: imageBackgroundColor
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: image,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                productName,
                IconButton(
                  icon: Icon(
                    Icons.add_box_sharp,
                    color: Color.fromRGBO(95, 135, 161, 0.9),
                  ),
                  onPressed: () {},
                )
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: productPrice,
            )
          ],
        ),
      ),
    );
  }
}
