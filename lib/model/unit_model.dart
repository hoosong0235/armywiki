class UnitModel {
  UnitModel(
    this.unitId,
    this.firstName,
    this.lastName,
    this._imageUrl,
  );

  final String unitId;
  final String firstName;
  final String lastName;
  final String? _imageUrl;

  String get imageUrl => _imageUrl ?? "https://placehold.co/56";

  factory UnitModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      UnitModel(
        json["unit_id"],
        json["first_name"],
        json["last_name"],
        json["image_url"],
      );
}
