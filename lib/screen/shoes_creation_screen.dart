import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:test_val/dto/shoes_creation_dto.dart';
import 'package:test_val/dto/shoes_model_creation_dto.dart';
import 'package:test_val/dto/shoes_model_type_creation_dto.dart';
import 'package:test_val/dto/shoes_size_dto.dart';
import 'package:test_val/service/shoes_model_service.dart';
import 'package:test_val/service/shoes_model_type_service.dart';
import 'package:test_val/widget/form/component/image_picker.dart';
import 'package:test_val/dto/shoes_creation_variation_dto.dart';

class ShoesCreationScreen extends StatefulWidget {
  const ShoesCreationScreen({Key? key}) : super(key: key);

  @override
  State<ShoesCreationScreen> createState() => _ShoesCreationScreenState();
}

class _ShoesCreationScreenState extends State<ShoesCreationScreen> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey();
  final GlobalKey<FormBuilderFieldState> _modelNameKey = GlobalKey();
  final GlobalKey<FormBuilderFieldState> _shoesType = GlobalKey();
  Future<List<ShoesModelTypeCreationDto>> shoesModelTypes =
      ShoesModelTypeService.getInstance.getAllShoesTypesWitId();
  Future<ShoesCreationVariationDto> createShoesVariation =
      ShoesModelService.getInstance.getShoesCreateInfo();
  int _itemCount = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Color.fromRGBO(140, 201, 238, 0.6),
          ),
          width: double.infinity,
          margin: EdgeInsets.all(20),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: CustomScrollView(slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(bottom: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(7)),
                              color: Color.fromRGBO(95, 135, 161, 0.6),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Text(
                              "Shoes Model",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "FiraCode",
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(95, 135, 161, 0.6),
                                borderRadius: BorderRadius.circular(7)),
                            padding: EdgeInsets.all(7),
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20.0),
                            child: Column(
                              children: [
                                FormBuilderTextField(
                                  name: "modelName",
                                  key: _modelNameKey,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "FiraCode",
                                  ),
                                  decoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  140, 201, 238, 0.6),
                                              width: 2.0,
                                              style: BorderStyle.solid)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  140, 201, 238, 0.6),
                                              width: 2.0,
                                              style: BorderStyle.solid)),
                                      errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  243, 98, 98, 1.0),
                                              width: 2.0,
                                              style: BorderStyle.solid)),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  243, 98, 98, 1.0),
                                              style: BorderStyle.solid)),
                                      labelText: "Model name",
                                      labelStyle: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "FiraCode",
                                      )),
                                  validator: FormBuilderValidators.required(),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                ),
                                FutureBuilder<List<ShoesModelTypeCreationDto>>(
                                    future: shoesModelTypes,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<
                                                List<ShoesModelTypeCreationDto>>
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
                                            return Theme(
                                              data: ThemeData(
                                                textTheme: TextTheme(
                                                    subtitle1: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontFamily: "FiraCode",
                                                )),
                                              ),
                                              child:
                                                  FormBuilderSearchableDropdown<
                                                      ShoesModelTypeCreationDto>(
                                                name: 'shoesType',
                                                key: _shoesType,
                                                items: snapshot.data!,
                                                itemAsString:
                                                    (shoesModelType) =>
                                                        shoesModelType.typeName,
                                                compareFn: (current, next) =>
                                                    current.id == next.id,
                                                dropdownButtonProps:
                                                    IconButtonProps(
                                                  icon: const Icon(
                                                    Icons.arrow_drop_down,
                                                    size: 24,
                                                    color: Color.fromRGBO(
                                                        140, 201, 238, 0.6),
                                                  ),
                                                ),
                                                popupProps:
                                                    PopupProps.bottomSheet(
                                                  bottomSheetProps:
                                                      BottomSheetProps(
                                                          constraints:
                                                              BoxConstraints(
                                                    maxHeight: 250,
                                                  )),
                                                ),
                                                decoration:
                                                    const InputDecoration(
                                                        enabledBorder: UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Color.fromRGBO(
                                                                    140, 201, 238, 0.6),
                                                                width: 2.0,
                                                                style: BorderStyle
                                                                    .solid)),
                                                        focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color:
                                                                    Color.fromRGBO(
                                                                        140,
                                                                        201,
                                                                        238,
                                                                        0.6),
                                                                width: 2.0,
                                                                style: BorderStyle
                                                                    .solid)),
                                                        errorBorder: UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Color.fromRGBO(
                                                                    243, 98, 98, 1.0),
                                                                width: 2.0,
                                                                style: BorderStyle.solid)),
                                                        focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(243, 98, 98, 1.0), style: BorderStyle.solid)),
                                                        labelText: 'Shoes type',
                                                        labelStyle: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontFamily:
                                                              "FiraCode",
                                                        )),
                                                validator: FormBuilderValidators
                                                    .required(),
                                              ),
                                            );
                                          }
                                      }
                                    }),
                              ],
                            ),
                          ),
                          Spacer(),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(7),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(95, 135, 161, 0.6),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Text(
                              "Shoes Variations",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "FiraCode",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _itemCount,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20.0),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(95, 135, 161, 0.6),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: Text(
                                "Model photos",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "FiraCode",
                                ),
                              ),
                            ),
                            FormBuilderImagePicker(
                              name: 'photos$index',
                              iconColor: Color.fromRGBO(95, 135, 161, 0.9),
                              backGroundColor:
                                  Color.fromRGBO(95, 135, 161, 0.6),
                              borderRadius: BorderRadius.circular(7),
                              previewMargin:
                                  EdgeInsets.symmetric(horizontal: 10),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                              maxImages: 4,
                              validator: FormBuilderValidators.required(),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(95, 135, 161, 0.6),
                                  borderRadius: BorderRadius.circular(7)),
                              padding: EdgeInsets.all(7),
                              child: Column(
                                children: [
                                  FutureBuilder<ShoesCreationVariationDto>(
                                    future: createShoesVariation,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<ShoesCreationVariationDto>
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
                                            return Row(
                                              children: [
                                                Expanded(
                                                  child: Theme(
                                                    data: ThemeData(
                                                      textTheme: TextTheme(
                                                          subtitle1: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontFamily: "FiraCode",
                                                      )),
                                                    ),
                                                    child:
                                                        FormBuilderSearchableDropdown(
                                                      name: 'color$index',
                                                      items:
                                                          snapshot.data!.colors,
                                                      dropdownButtonProps:
                                                          IconButtonProps(
                                                        icon: const Icon(
                                                          Icons.arrow_drop_down,
                                                          size: 24,
                                                          color: Color.fromRGBO(
                                                              140,
                                                              201,
                                                              238,
                                                              0.6),
                                                        ),
                                                      ),
                                                      popupProps: PopupProps<
                                                          String>.bottomSheet(
                                                        bottomSheetProps:
                                                            BottomSheetProps(
                                                                constraints:
                                                                    BoxConstraints(
                                                          maxHeight: 250,
                                                        )),
                                                      ),
                                                      decoration:
                                                          const InputDecoration(
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
                                                              labelText: 'Color',
                                                              labelStyle: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    "FiraCode",
                                                              )),
                                                      validator:
                                                          FormBuilderValidators
                                                              .required(),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: 30,
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  child: VerticalDivider(
                                                    width: 0.5,
                                                    color: Color.fromRGBO(
                                                        140, 201, 238, 0.6),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Theme(
                                                    data: ThemeData(
                                                      textTheme: TextTheme(
                                                          subtitle1: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontFamily: "FiraCode",
                                                      )),
                                                    ),
                                                    child:
                                                        FormBuilderSearchableDropdown(
                                                      name: 'sizeType$index',
                                                      items: snapshot.data!
                                                          .productCountryTypes,
                                                      dropdownButtonProps:
                                                          IconButtonProps(
                                                        icon: const Icon(
                                                          Icons.arrow_drop_down,
                                                          size: 24,
                                                          color: Color.fromRGBO(
                                                              140,
                                                              201,
                                                              238,
                                                              0.6),
                                                        ),
                                                      ),
                                                      popupProps: PopupProps<
                                                              String>.bottomSheet(
                                                          bottomSheetProps:
                                                              BottomSheetProps(
                                                                  constraints:
                                                                      BoxConstraints(
                                                        maxHeight: 250,
                                                      ))),
                                                      decoration:
                                                          const InputDecoration(
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
                                                              labelText: 'Size type',
                                                              labelStyle: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    "FiraCode",
                                                              )),
                                                      validator:
                                                          FormBuilderValidators
                                                              .required(),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }
                                      }
                                    },
                                  ),
                                  FormBuilderTextField(
                                    name: "size$index",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "FiraCode",
                                    ),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromRGBO(
                                                    140, 201, 238, 0.6),
                                                width: 2.0,
                                                style: BorderStyle.solid)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromRGBO(
                                                    140, 201, 238, 0.6),
                                                width: 2.0,
                                                style: BorderStyle.solid)),
                                        errorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromRGBO(
                                                    243, 98, 98, 1.0),
                                                width: 2.0,
                                                style: BorderStyle.solid)),
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromRGBO(
                                                    243, 98, 98, 1.0),
                                                style: BorderStyle.solid)),
                                        labelText: "Size",
                                        labelStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontFamily: "FiraCode",
                                        )),
                                    validator: FormBuilderValidators.required(),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                  ),
                                  FormBuilderTextField(
                                    name: "price$index",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "FiraCode",
                                    ),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromRGBO(
                                                    140, 201, 238, 0.6),
                                                width: 2.0,
                                                style: BorderStyle.solid)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromRGBO(
                                                    140, 201, 238, 0.6),
                                                width: 2.0,
                                                style: BorderStyle.solid)),
                                        errorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromRGBO(
                                                    243, 98, 98, 1.0),
                                                width: 2.0,
                                                style: BorderStyle.solid)),
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromRGBO(
                                                    243, 98, 98, 1.0),
                                                style: BorderStyle.solid)),
                                        labelText: "Price",
                                        labelStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontFamily: "FiraCode",
                                        )),
                                    validator: FormBuilderValidators.required(),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(7)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      primary: Color.fromRGBO(95, 135, 161, 0.9),
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(7)),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _itemCount += 1;
                      });
                    },
                    child: Text(
                      "Add variation",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: "FiraCode",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(7)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      primary: Color.fromRGBO(95, 135, 161, 0.9),
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(7)),
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        String modelName = _modelNameKey.currentState!.value;
                        ShoesModelTypeCreationDto shoesModelType =
                            _shoesType.currentState!.value;
                        List<ShoesCreationDto> shoesCreationDtos = [];
                        for (int i = 0; i < _itemCount; i++) {
                          List<XFile> images = _formKey
                              .currentState!.fields["photos$i"]!.value
                              .cast<XFile>();
                          String color =
                              _formKey.currentState!.fields["color$i"]!.value;
                          double price = double.parse(
                              _formKey.currentState!.fields["price$i"]!.value);
                          String productCountrySize = _formKey
                              .currentState!.fields["sizeType$i"]!.value;
                          double size = double.parse(
                              _formKey.currentState!.fields["size$i"]!.value);
                          ShoesSizeDto shoesSizeDto = ShoesSizeDto(
                              size: size, countryType: productCountrySize);
                          List<Uint8List> imagesInBytes = await Future.wait(
                              images.map((e) async => await e.readAsBytes()));
                          List<String> base64Images = imagesInBytes
                              .map((e) => base64Encode(e))
                              .toList();
                          ShoesCreationDto shoesCreationDto = ShoesCreationDto(
                              images: base64Images,
                              size: shoesSizeDto,
                              price: price,
                              color: color);
                          shoesCreationDtos.add(shoesCreationDto);
                        }
                        ShoesModelCreationDto shoesModelCreationDto =
                            ShoesModelCreationDto(
                                modelName: modelName,
                                type: shoesModelType,
                                products: shoesCreationDtos);
                        await ShoesModelService.getInstance.createShoesModel(shoesModelCreationDto: shoesModelCreationDto);
                        if (!mounted) return;
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text(
                      "Save shoes",
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
        ),
      ),
    );
  }
}
