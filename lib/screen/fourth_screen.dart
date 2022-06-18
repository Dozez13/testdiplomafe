import 'dart:convert';
import 'dart:typed_data';

import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:test_val/dto/shoes_similar_image_dto.dart';
import 'package:test_val/enum/filter_enum.dart';
import 'package:test_val/enum/sort_enum.dart';
import 'package:test_val/screen/shoes_creation_screen.dart';
import 'package:test_val/screen/fifth_screen.dart';
import 'package:test_val/screen/second_screen.dart';
import 'package:test_val/service/shoes_model_service.dart';
import 'package:test_val/widget/component/shop_element.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_val/dto/shoes_model_dto.dart';

class FourthScreen extends StatefulWidget {
  final Map<String, Map<String, dynamic>> filterFieldsMap;

  const FourthScreen({Key? key, required this.filterFieldsMap})
      : super(key: key);

  @override
  State<FourthScreen> createState() => _FourthScreenState();
}

class _FourthScreenState extends State<FourthScreen> {
  final List<GlobalKey<FormBuilderState>> globalKeys =
      List.generate(FilterOption.values.length, (index) => GlobalKey());
  final GlobalKey<FormBuilderState> sortForm = GlobalKey();
  late Future<List<ShoesModelDto>> gridShoes = ShoesModelService.getInstance
      .getFilteredShoesModel(widget.filterFieldsMap);
  int _pageIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(140, 201, 238, 0.6),
        automaticallyImplyLeading: false,
        title: Text(
          "Shoes",
          style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontFamily: "FiraCode",
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
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
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(10)),
                              ),
                              child: Wrap(
                                children: <Widget>[
                                  ListTile(
                                    leading: Icon(Icons.camera_enhance),
                                    title: Text("Camera",style: TextStyle(
                                        fontSize: 18.0,
                                        fontFamily: "FiraCode",
                                        fontWeight:
                                        FontWeight.bold),),
                                    onTap: () async {
                                      final ImagePicker _picker = ImagePicker();
                                      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
                                      if(photo!=null){
                                        Uint8List imageAsBytes = await photo.readAsBytes();
                                        String base64Image = base64Encode(imageAsBytes);
                                        ShoesSimilarImageDto shoesSimilarImageDto = ShoesSimilarImageDto(base64Image: base64Image);
                                        if (!mounted) return;
                                        Navigator.of(context).pop();
                                        setState(() {
                                          gridShoes = ShoesModelService.getInstance.getSimilarImages(shoesSimilarImageDto);
                                        });
                                      }
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.image),
                                    title: Text("Gallery",style: TextStyle(
                                        fontSize: 18.0,
                                        fontFamily: "FiraCode",
                                        fontWeight:
                                        FontWeight.bold),),
                                    onTap: () async {
                                      final ImagePicker _picker = ImagePicker();
                                      final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
                                      if(photo!=null){
                                        Uint8List imageAsBytes = await photo.readAsBytes();
                                        String base64Image = base64Encode(imageAsBytes);
                                        ShoesSimilarImageDto shoesSimilarImageDto = ShoesSimilarImageDto(base64Image: base64Image);
                                        if (!mounted) return;
                                        Navigator.of(context).pop();
                                        setState(() {
                                         gridShoes = ShoesModelService.getInstance.getSimilarImages(shoesSimilarImageDto);
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ),
                            );
                          });
                    });
              },
              icon: Icon(Icons.camera_alt_outlined)),
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Directionality(
                textDirection: TextDirection.rtl,
                child: ElevatedButton.icon(
                  onPressed: () {
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
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(10)),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.black
                                                        .withOpacity(0.2),
                                                    width: 2.0,
                                                    style: BorderStyle.solid))),
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.keyboard_arrow_up,
                                            ),
                                            Text("Sort",
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    fontFamily: "FiraCode",
                                                    fontWeight:
                                                        FontWeight.bold))
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: CustomScrollView(slivers: [
                                          SliverFillRemaining(
                                              hasScrollBody: false,
                                              child: FormBuilder(
                                                key: sortForm,
                                                child: FormBuilderRadioGroup(
                                                  name: 'sort',
                                                  decoration: InputDecoration(
                                                      enabledBorder:
                                                          InputBorder.none),
                                                  initialValue: widget
                                                          .filterFieldsMap[
                                                              "sort"]!
                                                          .containsKey("sort")
                                                      ? SortOption.ofRestRepresentation(
                                                              restRepresentation:
                                                                  widget.filterFieldsMap[
                                                                          "sort"]![
                                                                      "sort"])
                                                          .uiRepresentation
                                                      : SortOption.priceASC
                                                          .uiRepresentation,
                                                  orientation:
                                                      OptionsOrientation
                                                          .vertical,
                                                  validator:
                                                      FormBuilderValidators
                                                          .required(),
                                                  options: SortOption.values
                                                      .map((e) =>
                                                          e.uiRepresentation)
                                                      .map((uiRepresentation) =>
                                                          FormBuilderFieldOption(
                                                              value:
                                                                  uiRepresentation))
                                                      .toList(growable: false),
                                                ),
                                              ))
                                        ]),
                                      ),
                                    ],
                                  ),
                                ); //whatever you're returning, does not have to be a Container
                              });
                        }).whenComplete(() {
                      print("test");
                      sortForm.currentState!.save();
                      sortForm.currentState!.value.forEach((key, value) {
                        widget.filterFieldsMap["sort"]![key] =
                            SortOption.of(uiRepresentation: value)
                                .restRepresentation;
                      });
                      setState(() {
                        gridShoes = ShoesModelService.getInstance
                            .getFilteredShoesModel(widget.filterFieldsMap);
                      });
                    });
                  },
                  icon: Icon(
                    Icons.arrow_downward,
                    color: Colors.white,
                  ),
                  label: Text(
                    "SORT",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontFamily: "FiraCode",
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      primary: Color.fromRGBO(95, 135, 161, 0.9),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius
                              .zero)) //Color.fromRGBO(120, 184, 224, 0.9),
                      ),
                ),
              )),
              Expanded(
                  child: Directionality(
                textDirection: TextDirection.rtl,
                child: ElevatedButton.icon(
                  onPressed: () {
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        isDismissible: true,
                        context: context,
                        builder: (BuildContext context) {
                          return Column(children: [
                            Expanded(
                              child: DraggableScrollableSheet(
                                  initialChildSize: 0.5,
                                  maxChildSize: 0.5,
                                  minChildSize: 0.5,
                                  expand: true,
                                  builder: (context, scrollController) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(10)),
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: Colors.black
                                                            .withOpacity(0.2),
                                                        width: 2.0,
                                                        style: BorderStyle
                                                            .solid))),
                                            child: Column(
                                              children: [
                                                Icon(
                                                  Icons.keyboard_arrow_up,
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 15),
                                                  child: Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text("Filter",
                                                            style: TextStyle(
                                                                fontSize: 18.0,
                                                                fontFamily:
                                                                    "FiraCode",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Material(
                                                          child: InkWell(
                                                            onTap: () {
                                                              widget
                                                                  .filterFieldsMap
                                                                  .clear();
                                                              widget
                                                                  .filterFieldsMap
                                                                  .addAll({
                                                                "category": {},
                                                                "color": {},
                                                                "price": {},
                                                                "size": {
                                                                  "EU": {},
                                                                  "UK": {},
                                                                  "US": {},
                                                                },
                                                                "sort": {},
                                                              });
                                                              setState(() {});
                                                            },
                                                            child: Text(
                                                              "Clear",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      18.0,
                                                                  fontFamily:
                                                                      "FiraCode",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: ListView.builder(
                                                itemCount:
                                                    FilterOption.values.length,
                                                itemBuilder: (context, index) {
                                                  return ListTile(
                                                    onTap: () {
                                                      FilterOption.values[index]
                                                              .modalSheet!(
                                                          context,
                                                          globalKeys[index],
                                                          widget
                                                              .filterFieldsMap);
                                                    },
                                                    leading: Icon(Icons.check),
                                                    title: Text(
                                                        FilterOption
                                                            .values[index]
                                                            .uiRepresentation,
                                                        style: TextStyle(
                                                            fontSize: 14.0,
                                                            fontFamily:
                                                                "FiraCode",
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    subtitle: Text("(All)",
                                                        style: TextStyle(
                                                            fontSize: 14.0,
                                                            fontFamily:
                                                                "FiraCode",
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  );
                                                }),
                                          ),
                                        ],
                                      ),
                                    ); //whatever you're returning, does not have to be a Container
                                  }),
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
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
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "View items",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: "FiraCode",
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ]);
                        }).whenComplete(() {
                      setState(() {
                        gridShoes = ShoesModelService.getInstance
                            .getFilteredShoesModel(widget.filterFieldsMap);
                      });
                    });
                  },
                  icon: Icon(
                    Icons.arrow_downward,
                    color: Colors.white,
                  ),
                  label: Text(
                    "FILTER",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontFamily: "FiraCode",
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      primary: Color.fromRGBO(95, 135, 161, 0.9),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius
                              .zero)) //Color.fromRGBO(120, 184, 224, 0.9),
                      ),
                ),
              )),
            ],
          ),
          Expanded(
            child: FutureBuilder<List<ShoesModelDto>>(
              future: gridShoes,
              builder: (BuildContext context,
                  AsyncSnapshot<List<ShoesModelDto>> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10),
                          padding: EdgeInsets.all(5),
                          itemCount: snapshot.data!.length + 1,
                          itemBuilder: (BuildContext context, int index) {
                            if (index == 0) {
                              return ElevatedButton(
                                onPressed: () {
                                  showGeneralDialog(
                                    context: context,
                                    barrierColor:
                                        Colors.black12.withOpacity(0.6),
                                    barrierDismissible: false,
                                    transitionDuration:
                                        Duration(milliseconds: 400),
                                    pageBuilder: (_, __, ___) {
                                      return ShoesCreationScreen();
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 15.0),
                                    primary: Color.fromRGBO(140, 201, 238, 0.6),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius
                                            .zero)) //Color.fromRGBO(120, 184, 224, 0.9),
                                    ),
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: FittedBox(
                                            fit: BoxFit.fill,
                                            child: Icon(
                                              Icons.add,
                                            ))),
                                    Expanded(
                                        child: Image.asset(
                                      "images/logo_shoes_icon.png",
                                      color: Colors.white,
                                    )),
                                    Text(
                                      "Add shoes model",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "FiraCode",
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              );
                            }
                            ShoesModelDto shoesModelDto =
                                snapshot.data![index - 1];
                            return ShopElement(
                                image: Image.memory(
                                  base64Decode(shoesModelDto.image),
                                  filterQuality: FilterQuality.high,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return FifthScreen(
                                          shoesId: shoesModelDto.id);
                                    }),
                                  );
                                },
                                imageBackgroundColor:
                                    Color.fromRGBO(215, 215, 215, 1.0),
                                productName: Text(
                                  shoesModelDto.modelName,
                                  style: TextStyle(
                                    fontFamily: "FiraCode",
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(166, 165, 165, 1.0),
                                  ),
                                ),
                                productPrice: Text(
                                  "${shoesModelDto.productPrice}",
                                  style: TextStyle(
                                    fontFamily: "FiraCode",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ));
                          });
                    }
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BubbleBottomBar(
        opacity: 1,
        backgroundColor: Color.fromRGBO(140, 201, 238, 0.6),
        currentIndex: _pageIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const SecondScreen(
                    pagesIndex: 0,
                  );
                }),
              );
              break;
            case 1:
              Navigator.pop(context);
              break;
          }
        },
        //new, gives a cute ink effect
        inkColor: Colors.black12,
        //optional, uses theme color if not specified
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: Color.fromRGBO(95, 135, 161, 0.6),
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              activeIcon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              title: Text("Home", style: TextStyle(color: Colors.white))),
          BubbleBottomBarItem(
              backgroundColor: Color.fromRGBO(95, 135, 161, 0.6),
              icon: Icon(
                Icons.collections_bookmark,
                color: Colors.white,
              ),
              activeIcon: Icon(
                Icons.collections_bookmark,
                color: Colors.white,
              ),
              title: Text(
                "Categories",
                style: TextStyle(color: Colors.white),
              )),
        ],
      ),
    );
  }
}
