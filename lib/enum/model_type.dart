enum ModelType{
  allShoes(uiRepresentation: "All Shoes"), boots(uiRepresentation: "Boots"), flats(uiRepresentation: "Flats"), sandals(uiRepresentation: "Sandals"), slippers(uiRepresentation: "Slippers"), sneakers(uiRepresentation: "Sneakers"), wedges(uiRepresentation: "Wedges");
  final String uiRepresentation;

  const ModelType({required this.uiRepresentation});

  static ModelType of({required String uiRepresentation}) {
    return values.firstWhere(
            (element) => element.uiRepresentation == uiRepresentation,
        orElse: () => ModelType.allShoes);
  }
}