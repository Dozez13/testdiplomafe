import 'package:test_val/enum/shoes_size.dart';

class RequestParamUtil {
  static const RequestParamUtil _instance = RequestParamUtil._internal();

  const RequestParamUtil._internal();

  static RequestParamUtil get getInstance => _instance;

  Map<String, dynamic> getQueryParams(
      Map<String, Map<String, dynamic>> filterFieldsMap) {
    String types = filterFieldsMap["category"]!
        .entries
        .where((element) => element.value)
        .map((e) => e.key)
        .join(",");
    String colors = filterFieldsMap["color"]!
        .entries
        .where((element) => element.value)
        .map((e) => e.key)
        .join(",");
    String? sort = filterFieldsMap["sort"]!["sort"];
    double? minPrice = filterFieldsMap["price"]!["minPrice"];
    double? maxPrice = filterFieldsMap["price"]!["maxPrice"];
    Map<String, Map<dynamic, dynamic>> sizes =
        filterFieldsMap["size"]!.cast<String, Map<dynamic, dynamic>>();
    List<String> sizesInValue = [];
    List<String> productCountrySizes = [];

    sizes[ShoesSize.eu.uiRepresentation]
        ?.entries
        .where((element) => element.value)
        .forEach((element) {
      sizesInValue.add(element.key);
      productCountrySizes.add(ShoesSize.eu.uiRepresentation);
    });
    sizes[ShoesSize.us.uiRepresentation]
        ?.entries
        .where((element) => element.value)
        .forEach((element) {
      sizesInValue.add(element.key);
      productCountrySizes.add(ShoesSize.us.uiRepresentation);
    });
    sizes[ShoesSize.uk.uiRepresentation]
        ?.entries
        .where((element) => element.value)
        .forEach((element) {
      sizesInValue.add(element.key);
      productCountrySizes.add(ShoesSize.uk.uiRepresentation);
    });
    return {
      "minPrice": minPrice,
      "maxPrice": maxPrice,
      "colors": colors,
      "sizes": sizesInValue.join(","),
      "sizeCountryTypes": productCountrySizes.join(","),
      "types": types,
      "sort":sort,
    };
  }
}
