enum SortOption {
  priceASC(uiRepresentation: "Price Low to High",restRepresentation: "PRICE_ASC"),
  priceDESC(uiRepresentation: "Price High to Low",restRepresentation: "PRICE_DESC");

  final String uiRepresentation;

  final String restRepresentation;

  const SortOption({required this.uiRepresentation, required this.restRepresentation});

  static SortOption of({required String uiRepresentation}) {
    return values.firstWhere(
        (element) => element.uiRepresentation == uiRepresentation,
        orElse: () => SortOption.priceASC);
  }

  static SortOption ofRestRepresentation({required String restRepresentation}) {
    return values.firstWhere(
            (element) => element.restRepresentation == restRepresentation,
        orElse: () => SortOption.priceASC);
  }
}
