class UnitRuleModel {
  UnitRuleModel(
    this.unitRules,
  );

  final List<TitleModel> unitRules;

  Map<String, dynamic> toJson() => {
        "unit_rule": List.generate(
          unitRules.length,
          (
            index,
          ) =>
              unitRules[index].toJson(),
        ),
      };

  factory UnitRuleModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      UnitRuleModel(
        List.generate(
          json["unit_rule"].length,
          (
            index,
          ) =>
              TitleModel.fromJson(
            json["unit_rule"][index],
          ),
        ),
      );
}

class TitleModel {
  TitleModel(
    this._title,
    this._body,
  );

  final String? _title;
  final String? _body;

  String get title => _title ?? "";
  String get body => _body ?? "";

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) {
    return other is TitleModel && title == other.title && body == other.body;
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
      };

  factory TitleModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      TitleModel(
        json["title"],
        json["body"],
      );
}
