class RuleModel {
  RuleModel(
    this.headline,
    this.label,
    this.displays,
  );

  final String headline;
  final String label;
  final List<DisplayModel> displays;

  factory RuleModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      RuleModel(
        json["headline"],
        json["label"],
        List.generate(
          json["displays"].length,
          (
            index,
          ) =>
              DisplayModel.fromJson(
            json["displays"][index],
          ),
        ),
      );
}

class DisplayModel {
  DisplayModel(
    this._display,
    this.headlines,
  );

  final String? _display;
  final List<HeadlineModel> headlines;

  String get display => _display ?? "";

  factory DisplayModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      DisplayModel(
        json["display"],
        List.generate(
          json["headlines"].length,
          (
            index,
          ) =>
              HeadlineModel.fromJson(
            json["headlines"][index],
          ),
        ),
      );
}

class HeadlineModel {
  HeadlineModel(
    this._headline,
    this.titles,
  );

  final String? _headline;
  final List<TitleModel> titles;

  String get headline => _headline ?? "";

  factory HeadlineModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      HeadlineModel(
        json["headline"],
        List.generate(
          json["titles"].length,
          (
            index,
          ) =>
              TitleModel.fromJson(
            json["titles"][index],
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
