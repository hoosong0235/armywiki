class UnitRuleModel {
  UnitRuleModel(
    this.unitRules,
  );

  final List<TitleModel> unitRules;

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

  factory TitleModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      TitleModel(
        json["title"],
        json["body"],
      );
}
