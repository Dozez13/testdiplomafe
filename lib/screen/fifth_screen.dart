import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:test_val/dto/shoes_info_dto.dart';
import 'package:test_val/screen/six_screen.dart';
import 'package:test_val/service/shoes_service.dart';

class FifthScreen extends StatefulWidget {
  final int shoesId;

  const FifthScreen({Key? key, required this.shoesId}) : super(key: key);

  @override
  State<FifthScreen> createState() => _FifthScreenState();
}

class _FifthScreenState extends State<FifthScreen> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  late Future<ShoesInfoDto> shoesInfoFuture =
      ShoesService.getInstance.getShoesInfoDto(shoesId: widget.shoesId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromRGBO(95, 135, 161, 0.9)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
          child: CustomScrollView(slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: FutureBuilder<ShoesInfoDto>(
            future: shoesInfoFuture,
            builder:
                (BuildContext context, AsyncSnapshot<ShoesInfoDto> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                default:
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Column(
                      children: [
                        CarouselSlider(
                          items: snapshot.data!.shoesImages
                              .map((e) => Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color.fromRGBO(215, 215, 215, 1.0),
                                    ),
                                    child: Image.memory(
                                      base64Decode(e),
                                      width: double.infinity,
                                      filterQuality: FilterQuality.high,
                                    ),
                                  ))
                              .toList(),
                          carouselController: _controller,
                          options: CarouselOptions(
                              height: MediaQuery.of(context).size.height * 0.8,
                              enlargeCenterPage: true,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _current = index;
                                });
                              }),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                              List.generate(5, (index) => index).map((entry) {
                            return GestureDetector(
                              onTap: () => _controller.animateToPage(entry),
                              child: Container(
                                width: 12.0,
                                height: 12.0,
                                margin: EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _current == entry
                                      ? Color.fromRGBO(95, 135, 161, 0.9)
                                      : Color.fromRGBO(95, 135, 161, 0.6),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data!.modelName,
                                style: TextStyle(
                                  fontFamily: "FiraCode",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10, bottom: 10),
                                child: Text(
                                  "${snapshot.data!.productPrice}",
                                  style: TextStyle(
                                    fontFamily: "FiraCode",
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(82, 82, 82, 0.6),
                                  ),
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    children: [
                                      AbsorbPointer(
                                        child: RatingBar(
                                          initialRating:
                                              snapshot.data!.averageRating,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 25,
                                          ratingWidget: RatingWidget(
                                            full: Icon(
                                              Icons.star,
                                              color: Color.fromRGBO(
                                                  95, 135, 161, 0.9),
                                            ),
                                            half: Icon(
                                              Icons.star_half,
                                              color: Color.fromRGBO(
                                                  95, 135, 161, 0.9),
                                            ),
                                            empty: Icon(
                                              Icons.star_border,
                                              color: Color.fromRGBO(
                                                  95, 135, 161, 0.9),
                                            ),
                                          ),
                                          onRatingUpdate: (rating) {},
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          "${snapshot.data!.averageRating}",
                                          style: TextStyle(
                                            fontFamily: "FiraCode",
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "${snapshot.data!.countReviews}",
                                        style: TextStyle(
                                          fontFamily: "FiraCode",
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  )),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.symmetric(
                                        horizontal: BorderSide(
                                            color:
                                                Color.fromRGBO(82, 82, 82, 0.6),
                                            width: 0.5,
                                            style: BorderStyle.solid))),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: FormBuilderSearchableDropdown(
                                        name: 'color',
                                        items: snapshot.data!.colors,
                                        dropdownSearchTextStyle: TextStyle(
                                          fontFamily: "FiraCode",
                                          fontWeight: FontWeight.bold,
                                        ),
                                        popupProps:
                                            PopupProps<String>.bottomSheet(
                                          bottomSheetProps: BottomSheetProps(
                                              constraints: BoxConstraints(
                                            maxHeight: 250,
                                          )),
                                        ),
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            labelText: 'Select Color',
                                            labelStyle: TextStyle(
                                              fontFamily: "FiraCode",
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ),
                                    ),
                                    Container(
                                      height: 30,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: VerticalDivider(
                                        width: 0.5,
                                        color: Color.fromRGBO(82, 82, 82, 0.6),
                                      ),
                                    ),
                                    Expanded(
                                      child: FormBuilderSearchableDropdown(
                                        name: 'size',
                                        items: snapshot.data!.sizes,
                                        dropdownSearchTextStyle: TextStyle(
                                          fontFamily: "FiraCode",
                                          fontWeight: FontWeight.bold,
                                        ),
                                        popupProps:
                                            PopupProps<String>.bottomSheet(
                                                bottomSheetProps:
                                                    BottomSheetProps(
                                                        constraints:
                                                            BoxConstraints(
                                          maxHeight: 250,
                                        ))),
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            labelText: 'Select Size',
                                            labelStyle: TextStyle(
                                              fontFamily: "FiraCode",
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(vertical: 15),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color:
                                                Color.fromRGBO(82, 82, 82, 0.6),
                                            width: 0.5,
                                            style: BorderStyle.solid))),
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                      dividerColor: Colors.transparent),
                                  child: ExpansionTile(
                                    trailing: const SizedBox(),
                                    tilePadding: EdgeInsets.zero,
                                    title: Text(
                                      "Product details",
                                      style: TextStyle(
                                        fontFamily: "FiraCode",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    children: [
                                      Text('Big Bang'),
                                      Text('Birth of the Sun'),
                                      Text('Earth is Born'),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(vertical: 25),
                                margin: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color:
                                                Color.fromRGBO(82, 82, 82, 0.6),
                                            width: 0.5,
                                            style: BorderStyle.solid))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(bottom: 25),
                                      child: Text(
                                        "REVIEWS",
                                        style: TextStyle(
                                          fontFamily: "FiraCode",
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          AbsorbPointer(
                                            child: RatingBar(
                                              initialRating:
                                                  snapshot.data!.averageRating,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemSize: 25,
                                              ratingWidget: RatingWidget(
                                                full: Icon(
                                                  Icons.star,
                                                  color: Color.fromRGBO(
                                                      95, 135, 161, 0.9),
                                                ),
                                                half: Icon(
                                                  Icons.star_half,
                                                  color: Color.fromRGBO(
                                                      95, 135, 161, 0.9),
                                                ),
                                                empty: Icon(
                                                  Icons.star_border,
                                                  color: Color.fromRGBO(
                                                      95, 135, 161, 0.9),
                                                ),
                                              ),
                                              onRatingUpdate: (rating) {},
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text(
                                              "${snapshot.data!.averageRating}",
                                              style: TextStyle(
                                                fontFamily: "FiraCode",
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "(${snapshot.data!.countReviews} Reviews)",
                                            style: TextStyle(
                                              fontFamily: "FiraCode",
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Row(
                                        children: [
                                          Text(
                                            "5 stars",
                                            style: TextStyle(
                                              fontFamily: "FiraCode",
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Expanded(
                                            child: LinearPercentIndicator(
                                              lineHeight: 12.0,
                                              percent: (snapshot.data!
                                                              .countFiveStars *
                                                          100 /
                                                          snapshot.data!
                                                              .countReviews)
                                                      .isNaN
                                                  ? 0.0
                                                  : snapshot.data!
                                                          .countFiveStars /
                                                      snapshot
                                                          .data!.countReviews,
                                              backgroundColor: Color.fromRGBO(
                                                  204, 204, 204, 1.0),
                                              progressColor: Color.fromRGBO(
                                                  95, 135, 161, 0.9),
                                            ),
                                          ),
                                          Text(
                                            "(${snapshot.data!.countFiveStars})",
                                            style: TextStyle(
                                              fontFamily: "FiraCode",
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Row(
                                        children: [
                                          Text(
                                            "4 stars",
                                            style: TextStyle(
                                              fontFamily: "FiraCode",
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Expanded(
                                            child: LinearPercentIndicator(
                                              lineHeight: 12.0,
                                              percent: (snapshot.data!
                                                              .countFourStars *
                                                          100 /
                                                          snapshot.data!
                                                              .countReviews)
                                                      .isNaN
                                                  ? 0.0
                                                  : snapshot.data!
                                                          .countFourStars /
                                                      snapshot
                                                          .data!.countReviews,
                                              backgroundColor: Color.fromRGBO(
                                                  204, 204, 204, 1.0),
                                              progressColor: Color.fromRGBO(
                                                  95, 135, 161, 0.9),
                                            ),
                                          ),
                                          Text(
                                            "(${snapshot.data!.countFourStars})",
                                            style: TextStyle(
                                              fontFamily: "FiraCode",
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Row(
                                        children: [
                                          Text(
                                            "3 stars",
                                            style: TextStyle(
                                              fontFamily: "FiraCode",
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Expanded(
                                            child: LinearPercentIndicator(
                                              lineHeight: 12.0,
                                              percent: (snapshot.data!
                                                              .countThreeStars *
                                                          100 /
                                                          snapshot.data!
                                                              .countReviews)
                                                      .isNaN
                                                  ? 0.0
                                                  : snapshot.data!
                                                          .countThreeStars /
                                                      snapshot
                                                          .data!.countReviews,
                                              backgroundColor: Color.fromRGBO(
                                                  204, 204, 204, 1.0),
                                              progressColor: Color.fromRGBO(
                                                  95, 135, 161, 0.9),
                                            ),
                                          ),
                                          Text(
                                            "(${snapshot.data!.countThreeStars})",
                                            style: TextStyle(
                                              fontFamily: "FiraCode",
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Row(
                                        children: [
                                          Text(
                                            "2 stars",
                                            style: TextStyle(
                                              fontFamily: "FiraCode",
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Expanded(
                                            child: LinearPercentIndicator(
                                              lineHeight: 12.0,
                                              percent: (snapshot.data!
                                                              .countTwoStars *
                                                          100 /
                                                          snapshot.data!
                                                              .countReviews)
                                                      .isNaN
                                                  ? 0.0
                                                  : snapshot
                                                          .data!.countTwoStars  /
                                                      snapshot
                                                          .data!.countReviews,
                                              backgroundColor: Color.fromRGBO(
                                                  204, 204, 204, 1.0),
                                              progressColor: Color.fromRGBO(
                                                  95, 135, 161, 0.9),
                                            ),
                                          ),
                                          Text(
                                            "(${snapshot.data!.countTwoStars})",
                                            style: TextStyle(
                                              fontFamily: "FiraCode",
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Row(
                                        children: [
                                          Text(
                                            "1 stars",
                                            style: TextStyle(
                                              fontFamily: "FiraCode",
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Expanded(
                                            child: LinearPercentIndicator(
                                              lineHeight: 12.0,
                                              percent: (snapshot.data!
                                                              .countOneStars *
                                                          100 /
                                                          snapshot.data!
                                                              .countReviews)
                                                      .isNaN
                                                  ? 0.0
                                                  : snapshot
                                                          .data!.countOneStars  /
                                                      snapshot
                                                          .data!.countReviews,
                                              backgroundColor: Color.fromRGBO(
                                                  204, 204, 204, 1.0),
                                              progressColor: Color.fromRGBO(
                                                  95, 135, 161, 0.9),
                                            ),
                                          ),
                                          Text(
                                            "(${snapshot.data!.countOneStars})",
                                            style: TextStyle(
                                              fontFamily: "FiraCode",
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(1),
                                        spreadRadius: 2,
                                        blurRadius: 1,
                                        offset: Offset(0, 1),
                                      )
                                    ]),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 15.0),
                                    primary: Color.fromRGBO(95, 135, 161, 0.9),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.zero)),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) {
                                        return SixScreen(
                                            shoesId: widget.shoesId);
                                      }),
                                    );
                                  },
                                  child: Text(
                                    "View reviews",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: "FiraCode",
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  }
              }
            },
          ),
        ),
      ])),
    );
  }
}
