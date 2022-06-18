enum ShoesSize {
  eu(uiRepresentation: "EU"),
  us(uiRepresentation: "US"),
  uk(uiRepresentation: "UK");

  final String uiRepresentation;

  const ShoesSize({required this.uiRepresentation});

  static ShoesSize of({required String uiRepresentation}) {
    return values.firstWhere(
        (element) => element.uiRepresentation == uiRepresentation,
        orElse: () => ShoesSize.eu);
  }
}
