import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:test_val/dto/shoes_review_create_dto.dart';
import 'package:test_val/dto/shoes_review_dto.dart';
import 'package:test_val/dto/user_basic_dto.dart';
import 'package:test_val/service/shoes_review_service.dart';
import 'package:test_val/service/user_service.dart';

class SixScreen extends StatefulWidget {
  final int shoesId;

  const SixScreen({Key? key, required this.shoesId}) : super(key: key);

  @override
  State<SixScreen> createState() => _SixScreenState();
}

class _SixScreenState extends State<SixScreen> {
  late Future<List<ShoesReviewDto>> shoesReviewsFuture =
      ShoesReviewService.getInstance.getShoesReview(shoesId: widget.shoesId);
  Future<UserBasicDto> userBasicDto =
      UserService.getInstance.getUserFirstLastName();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey();
  final GlobalKey<FormBuilderFieldState> _payloadKey = GlobalKey();
  final GlobalKey<FormBuilderFieldState> _ratingKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Reviews",
          style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: "FiraCode",
              fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromRGBO(95, 135, 161, 0.9)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    isDismissible: true,
                    context: context,
                    builder: (BuildContext context) {
                      return Column(
                        children: [
                          Expanded(
                            child: DraggableScrollableSheet(
                                initialChildSize: 0.7,
                                maxChildSize: 0.7,
                                minChildSize: 0.7,
                                expand: true,
                                builder: (context, scrollController) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(10)),
                                    ),
                                    child: Scaffold(
                                      body: SafeArea(
                                        child: FormBuilder(
                                          key: _formKey,
                                          child: CustomScrollView(
                                            slivers: [
                                              SliverFillRemaining(
                                                hasScrollBody: false,
                                                child: Container(
                                                  padding: EdgeInsets.all(10),
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 20.0),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      right:
                                                                          10),
                                                              child: Icon(Icons
                                                                  .account_circle)),
                                                          FutureBuilder<
                                                                  UserBasicDto>(
                                                              future:
                                                                  userBasicDto,
                                                              builder: (BuildContext
                                                                      context,
                                                                  AsyncSnapshot<
                                                                          UserBasicDto>
                                                                      snapshot) {
                                                                switch (snapshot
                                                                    .connectionState) {
                                                                  case ConnectionState
                                                                      .waiting:
                                                                    return const Center(
                                                                      child:
                                                                          CircularProgressIndicator(),
                                                                    );
                                                                  default:
                                                                    if (snapshot
                                                                        .hasError) {
                                                                      return Text(
                                                                          'Error: ${snapshot.error}');
                                                                    } else {
                                                                      return Text(
                                                                        "${snapshot.data!.firstName} ${snapshot.data!.lastName}",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.black,
                                                                          fontFamily:
                                                                              "FiraCode",
                                                                        ),
                                                                      );
                                                                    }
                                                                }
                                                              })
                                                        ],
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                vertical: 15),
                                                        child: Text(
                                                          "Reviews are public and include your account info",
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontFamily:
                                                                "FiraCode",
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 10,
                                                            bottom: 20),
                                                        width: 280,
                                                        child:
                                                            FormBuilderRatingBar(
                                                          name: "rating",
                                                          key: _ratingKey,
                                                          initialRating: 0,
                                                          direction:
                                                              Axis.horizontal,
                                                          itemCount: 5,
                                                          itemSize: 25,
                                                          itemPadding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      15),
                                                          decoration:
                                                              InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                          ),
                                                          ratingWidget:
                                                              RatingWidget(
                                                            full: Icon(
                                                              Icons.star,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      95,
                                                                      135,
                                                                      161,
                                                                      0.9),
                                                            ),
                                                            half: Icon(
                                                              Icons.star_half,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      95,
                                                                      135,
                                                                      161,
                                                                      0.9),
                                                            ),
                                                            empty: Icon(
                                                              Icons.star_border,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      95,
                                                                      135,
                                                                      161,
                                                                      0.9),
                                                            ),
                                                          ),
                                                          validator:
                                                              FormBuilderValidators
                                                                  .required(),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            bottom: 15),
                                                        child:
                                                            FormBuilderTextField(
                                                          name: "payload",
                                                          key: _payloadKey,
                                                          maxLength: 255,
                                                          decoration:
                                                              InputDecoration(
                                                                  counterStyle:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontFamily:
                                                                        "FiraCode",
                                                                  ),
                                                                  enabledBorder: UnderlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                          color: Color.fromRGBO(
                                                                              140,
                                                                              201,
                                                                              238,
                                                                              0.6),
                                                                          width:
                                                                              2.0,
                                                                          style: BorderStyle
                                                                              .solid)),
                                                                  focusedBorder: OutlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                          color: Color.fromRGBO(
                                                                              140,
                                                                              201,
                                                                              238,
                                                                              0.6),
                                                                          width:
                                                                              2.0,
                                                                          style: BorderStyle
                                                                              .solid)),
                                                                  errorBorder: UnderlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                          color:
                                                                              Color.fromRGBO(243, 98, 98, 1.0),
                                                                          width: 2.0,
                                                                          style: BorderStyle.solid)),
                                                                  focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(243, 98, 98, 1.0), style: BorderStyle.solid)),
                                                                  hintText: "Describe your experience",
                                                                  hintStyle: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontFamily:
                                                                        "FiraCode",
                                                                  )),
                                                          validator:
                                                              FormBuilderValidators
                                                                  .required(),
                                                          autovalidateMode:
                                                              AutovalidateMode
                                                                  .onUserInteraction,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ); //whatever you're returning, does not have to be a Container
                                }),
                          ),
                          Container(
                            width: double.infinity,
                            decoration:
                                BoxDecoration(color: Colors.white, boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(1),
                                spreadRadius: 4,
                                blurRadius: 1,
                                offset: Offset(0, 3),
                              )
                            ]),
                            padding: EdgeInsets.all(10),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 15.0),
                                primary: Color.fromRGBO(95, 135, 161, 0.9),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.zero)),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  ShoesReviewCreateDto shoesReviewCreateDto =
                                      ShoesReviewCreateDto(
                                          shoesId: widget.shoesId,
                                          payload:
                                              _payloadKey.currentState!.value,
                                          rating: _ratingKey.currentState!.value
                                              .toInt());
                                  await ShoesReviewService.getInstance
                                      .createReview(
                                          shoesReviewCreateDto:
                                              shoesReviewCreateDto);
                                  if (!mounted) return;
                                  Navigator.of(context).pop();
                                  setState(() {
                                    shoesReviewsFuture = ShoesReviewService
                                        .getInstance
                                        .getShoesReview(
                                            shoesId: widget.shoesId);
                                  });
                                }
                              },
                              child: Text(
                                "Post",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: "FiraCode",
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      );
                    });
              },
              icon: Icon(
                Icons.add_comment,
                color: Colors.black,
              ))
        ],
      ),
      body: SafeArea(
          child: FutureBuilder<List<ShoesReviewDto>>(
              future: shoesReviewsFuture,
              builder: (BuildContext context,
                  AsyncSnapshot<List<ShoesReviewDto>> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      if (snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text(
                            "No Reviews",
                            style: TextStyle(
                                fontFamily: "FiraCode",
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                        );
                      }
                      return Column(
                        children: [
                          Expanded(
                            child: ListView(
                              children: snapshot.data!.map((e) {
                                return Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.black,
                                              width: 0.3,
                                              style: BorderStyle.solid))),
                                  child: Column(
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Row(
                                          children: [
                                            Container(
                                                margin:
                                                    EdgeInsets.only(right: 10),
                                                child:
                                                    Icon(Icons.account_circle)),
                                            Text(
                                              "${e.firstName} ${e.lastName}",
                                              style: TextStyle(
                                                  fontFamily: "FiraCode",
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Spacer(),
                                            Icon(Icons.more_vert)
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: AbsorbPointer(
                                              child: RatingBar(
                                                initialRating:
                                                    e.rating.toDouble(),
                                                direction: Axis.horizontal,
                                                allowHalfRating: false,
                                                itemCount: 5,
                                                itemSize: 14,
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
                                          ),
                                          Text(
                                            e.reviewDateTime,
                                            style: TextStyle(
                                                fontFamily: "FiraCode",
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "${e.payload}",
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontFamily: "FiraCode",
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      );
                    }
                }
              })),
    );
  }
}
