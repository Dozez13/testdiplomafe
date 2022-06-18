enum ModelCategory {
  shoes(uiRepresentation: "Shoes");

  final String uiRepresentation;

  const ModelCategory({required this.uiRepresentation});

  static ModelCategory of({required String uiRepresentation}) {
    return values.firstWhere(
        (element) => element.uiRepresentation == uiRepresentation,
        orElse: () => ModelCategory.shoes);
  }
}
