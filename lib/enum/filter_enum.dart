import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:test_val/dto/shoes_model_price_dto.dart';
import 'package:test_val/dto/shoes_size_dto.dart';
import 'package:test_val/enum/color_type.dart';
import 'package:test_val/enum/shoes_size.dart';
import 'package:test_val/service/shoes_model_service.dart';
import 'package:test_val/service/shoes_model_type_service.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';

enum FilterOption {
  category(
    uiRepresentation: "Category",
  ),
  size(uiRepresentation: "Size"),
  price(uiRepresentation: "Price"),
  color(uiRepresentation: "Color");

  final String uiRepresentation;

  const FilterOption({required this.uiRepresentation});

  static FilterOption of({required String uiRepresentation}) {
    return values.firstWhere(
        (element) => element.uiRepresentation == uiRepresentation,
        orElse: () => FilterOption.category);
  }
}

extension FilterOptionExtension on FilterOption {
  ShowModalSheet? get modalSheet {
    switch (this) {
      case FilterOption.category:
        return (BuildContext context, GlobalKey<FormBuilderState> globalKey,
            Map<String, Map<String, dynamic>> filterFieldsMap) {
          showModalBottomSheet(
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              isDismissible: true,
              context: context,
              builder: (BuildContext context) {
                return DraggableScrollableSheet(
                    initialChildSize: 0.5,
                    maxChildSize: 0.5,
                    minChildSize: 0.5,
                    expand: true,
                    builder: (context, scrollController) {
                      return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Icon(
                                    Icons.keyboard_arrow_up,
                                  ),
                                  Text("Category",
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontFamily: "FiraCode",
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                              Expanded(
                                child: FutureBuilder<List<String>>(
                                  future: ShoesModelService.getInstance
                                      .getAllShoesModelTypes(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<List<String>> snapshot) {
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.waiting:
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      default:
                                        if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        } else {
                                          return FormBuilder(
                                            key: globalKey,
                                            child: ListView(
                                                children: snapshot.data!
                                                    .map(
                                                      (e) => Theme(
                                                        data: ThemeData(
                                                            checkboxTheme: CheckboxThemeData(
                                                                side: BorderSide(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            140,
                                                                            201,
                                                                            238,
                                                                            0.6),
                                                                    width: 2.0,
                                                                    style: BorderStyle
                                                                        .solid))),
                                                        child:
                                                            FormBuilderCheckbox(
                                                          name: e,
                                                          initialValue: filterFieldsMap[
                                                                      "category"]!
                                                                  .containsKey(
                                                                      e)
                                                              ? filterFieldsMap[
                                                                  "category"]![e]
                                                              : false,
                                                          title: Text(
                                                            e,
                                                            style: TextStyle(
                                                                fontSize: 14.0,
                                                                fontFamily:
                                                                    "FiraCode",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          activeColor:
                                                              Color.fromRGBO(
                                                                  140,
                                                                  201,
                                                                  238,
                                                                  0.6),
                                                          checkColor:
                                                              Color.fromRGBO(
                                                                  140,
                                                                  201,
                                                                  238,
                                                                  1.0),
                                                        ),
                                                      ),
                                                    )
                                                    .toList()),
                                          );
                                        }
                                    }
                                  },
                                ),
                              ),
                            ],
                          )); //whatever you're returning, does not have to be a Container
                    });
              }).whenComplete(() {
            globalKey.currentState!.save();
            globalKey.currentState!.value.forEach((key, value) {
              filterFieldsMap["category"]![key] = value;
            });
          });
        };
      case FilterOption.color:
        return (BuildContext context, GlobalKey<FormBuilderState> globalKey,
            Map<String, Map<String, dynamic>> filterFieldsMap) {
          showModalBottomSheet(
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              isDismissible: true,
              context: context,
              builder: (BuildContext context) {
                return DraggableScrollableSheet(
                    initialChildSize: 0.5,
                    maxChildSize: 0.5,
                    minChildSize: 0.5,
                    expand: true,
                    builder: (context, scrollController) {
                      return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Icon(
                                    Icons.keyboard_arrow_up,
                                  ),
                                  Text("Color",
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontFamily: "FiraCode",
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                              Expanded(
                                child: FutureBuilder<List<String>>(
                                  future: ShoesModelService.getInstance
                                      .getAllShoesModelColors(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<List<String>> snapshot) {
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.waiting:
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      default:
                                        if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        } else {
                                          return FormBuilder(
                                            key: globalKey,
                                            child: ListView(
                                                children: snapshot.data!
                                                    .map(
                                                      (e) => Theme(
                                                        data: ThemeData(
                                                            checkboxTheme: CheckboxThemeData(
                                                                side: BorderSide(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            140,
                                                                            201,
                                                                            238,
                                                                            0.6),
                                                                    width: 2.0,
                                                                    style: BorderStyle
                                                                        .solid))),
                                                        child:
                                                            FormBuilderCheckbox(
                                                          name: e,
                                                          initialValue: filterFieldsMap[
                                                                      "color"]!
                                                                  .containsKey(
                                                                      e)
                                                              ? filterFieldsMap[
                                                                  "color"]![e]
                                                              : false,
                                                          title: Row(
                                                            //mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              Container(
                                                                height: 20,
                                                                width: 20,
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            15),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: ColorType.of(
                                                                          uiRepresentation:
                                                                              e)
                                                                      .color,
                                                                ),
                                                              ),
                                                              Text(
                                                                e,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14.0,
                                                                    fontFamily:
                                                                        "FiraCode",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ],
                                                          ),
                                                          activeColor:
                                                              Color.fromRGBO(
                                                                  140,
                                                                  201,
                                                                  238,
                                                                  0.6),
                                                          checkColor:
                                                              Color.fromRGBO(
                                                                  140,
                                                                  201,
                                                                  238,
                                                                  1.0),
                                                        ),
                                                      ),
                                                    )
                                                    .toList()),
                                          );
                                        }
                                    }
                                  },
                                ),
                              ),
                            ],
                          )); //whatever you're returning, does not have to be a Container
                    });
              }).whenComplete(() {
            globalKey.currentState!.save();
            globalKey.currentState!.value.forEach((key, value) {
              filterFieldsMap["color"]![key] = value;
            });
          });
        };
      case FilterOption.price:
        return (BuildContext context, GlobalKey<FormBuilderState> globalKey,
            Map<String, Map<String, dynamic>> filterFieldsMap) {
          showModalBottomSheet(
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              isDismissible: true,
              context: context,
              builder: (BuildContext context) {
                return DraggableScrollableSheet(
                    initialChildSize: 0.5,
                    maxChildSize: 0.5,
                    minChildSize: 0.5,
                    expand: true,
                    builder: (context, scrollController) {
                      return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Icon(
                                    Icons.keyboard_arrow_up,
                                  ),
                                  Text("Price",
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontFamily: "FiraCode",
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                              Expanded(
                                  child: FutureBuilder<ShoesModelPriceDto>(
                                    future: ShoesModelService.getInstance
                                        .getAllShoesModelPrices(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<ShoesModelPriceDto> snapshot) {
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.waiting:
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        default:
                                          if (snapshot.hasError) {
                                            return Text(
                                                'Error: ${snapshot.error}');
                                          } else {
                                            return FormBuilder(
                                              key: globalKey,
                                              child: Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: ListView(children: [
                                                  FormBuilderSlider(
                                                    name: 'minPrice',
                                                    min: snapshot.data!.minPrice,
                                                    max: snapshot.data!.maxPrice,
                                                    initialValue: filterFieldsMap["price"]!
                                                        .containsKey("minPrice")
                                                        ? filterFieldsMap["price"]!["minPrice"]
                                                        : snapshot.data!.minPrice,
                                                    activeColor:
                                                    Color.fromRGBO(140, 201, 238, 1),
                                                    inactiveColor:
                                                    Color.fromRGBO(140, 201, 238, 0.6),
                                                    decoration: const InputDecoration(
                                                      enabledBorder: InputBorder.none,
                                                      labelText: 'Min Price',
                                                      labelStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18.0,
                                                          fontFamily:
                                                          "FiraCode",
                                                          fontWeight:
                                                          FontWeight
                                                              .bold),
                                                    ),
                                                  ),
                                                  FormBuilderSlider(
                                                    name: 'maxPrice',
                                                    min: snapshot.data!.minPrice,
                                                    max: snapshot.data!.maxPrice,
                                                    initialValue: filterFieldsMap["price"]!
                                                        .containsKey("maxPrice")
                                                        ? filterFieldsMap["price"]!["maxPrice"]
                                                        : snapshot.data!.maxPrice,
                                                    activeColor:
                                                    Color.fromRGBO(140, 201, 238, 1),
                                                    inactiveColor:
                                                    Color.fromRGBO(140, 201, 238, 0.6),
                                                    decoration: const InputDecoration(
                                                      enabledBorder: InputBorder.none,
                                                      labelText: 'Max Price',
                                                      labelStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18.0,
                                                          fontFamily:
                                                          "FiraCode",
                                                          fontWeight:
                                                          FontWeight
                                                              .bold),
                                                    ),
                                                  ),
                                                ]),
                                              ),
                                            );
                                          }
                                      }
                                    },
                                  ),),
                            ],
                          )); //whatever you're returning, does not have to be a Container
                    });
              }).whenComplete(() {
            globalKey.currentState!.save();
            globalKey.currentState!.value.forEach((key, value) {
              filterFieldsMap["price"]![key] = value;
            });
          });
        };
      case FilterOption.size:
        return (BuildContext context, GlobalKey<FormBuilderState> globalKey,
            Map<String, Map<String, dynamic>> filterFieldsMap) {
          showModalBottomSheet(
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              isDismissible: true,
              context: context,
              builder: (BuildContext context) {
                return DraggableScrollableSheet(
                    initialChildSize: 0.5,
                    maxChildSize: 0.5,
                    minChildSize: 0.5,
                    expand: true,
                    builder: (context, scrollController) {
                      return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(10)),
                          ),
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Icon(
                                    Icons.keyboard_arrow_up,
                                  ),
                                  Text("Size",
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontFamily: "FiraCode",
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                              Expanded(
                                child: FutureBuilder<List<ShoesSizeDto>>(
                                  future: ShoesModelService.getInstance
                                      .getAllShoesModelSizes(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<List<ShoesSizeDto>>
                                          snapshot) {
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.waiting:
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      default:
                                        if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        } else {
                                          Map<ListView, Text> forms =
                                              groupBy<ShoesSizeDto, ShoesSize>(
                                                  snapshot.data!,
                                                  (element) => ShoesSize.of(
                                                      uiRepresentation: element
                                                          .countryType)).map(
                                                  (key, value) {
                                            return MapEntry(
                                              ListView(
                                                  children: value.map(
                                                (e) {
                                                  return Theme(
                                                    data: ThemeData(
                                                        checkboxTheme: CheckboxThemeData(
                                                            side: BorderSide(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        140,
                                                                        201,
                                                                        238,
                                                                        0.6),
                                                                width: 2.0,
                                                                style: BorderStyle
                                                                    .solid))),
                                                    child:
                                                        FormBuilderCheckbox(
                                                      name:
                                                          "${key.uiRepresentation}${e.size}",
                                                      initialValue: filterFieldsMap[
                                                                      "size"]![
                                                                  key
                                                                      .uiRepresentation]
                                                              .containsKey(
                                                                  "${e.size}")
                                                          ? filterFieldsMap[
                                                                      "size"]![
                                                                  key.uiRepresentation]
                                                              ["${e.size}"]
                                                          : false,
                                                      title: Text(
                                                        "${e.size}",
                                                        style: TextStyle(
                                                            fontSize: 14.0,
                                                            fontFamily:
                                                                "FiraCode",
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      activeColor:
                                                          Color.fromRGBO(140,
                                                              201, 238, 0.6),
                                                      checkColor:
                                                          Color.fromRGBO(140,
                                                              201, 238, 1.0),
                                                    ),
                                                  );
                                                },
                                              ).toList()),
                                              Text(
                                                key.uiRepresentation,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontFamily: "FiraCode",
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            );
                                          });
                                          return FormBuilder(
                                            key: globalKey,
                                            child: ContainedTabBarView(
                                              tabBarProperties: TabBarProperties(
                                                position: TabBarPosition.top,
                                                indicator: BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            color: Color.fromRGBO(140, 201, 238, 0.6),
                                                            width: 2.0,
                                                            style: BorderStyle.solid))),
                                                unselectedLabelColor: Color.fromRGBO(180, 174, 174, 1.0),
                                                labelColor: Colors.black,
                                              ),
                                              tabs: forms.entries
                                                  .map((e) => e.value)
                                                  .toList(),
                                              views: forms.entries
                                                  .map((e) => e.key)
                                                  .toList(),
                                            ),
                                          );
                                        }
                                    }
                                  },
                                ),
                              ),
                            ],
                          ));
                    });
              }).whenComplete(() {
            globalKey.currentState!.save();
            globalKey.currentState!.value.forEach((key, value) {
              filterFieldsMap["size"]![key.substring(0, 2)][key.substring(2)] =
                  value;
            });
          });
        };
      default:
        return null;
    }
  }
}





typedef ShowModalSheet = void Function(
    BuildContext context,
    GlobalKey<FormBuilderState> globalKey,
    Map<String, Map<String, dynamic>> filterFieldsMap);
