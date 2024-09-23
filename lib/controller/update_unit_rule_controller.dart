import "dart:convert";

import "package:dio/dio.dart";
import "package:armywiki/model/unit_rule_model.dart";
import "package:armywiki/utility/constant.dart";

class UpdateUnitRuleController {
  static String url = "$baseUrl/update_unit_rule/";
  static Dio dio = Dio();

  static Future<Response> requestUpdateRule(
    String unitId,
    UnitRuleModel unitRuleModel,
  ) async {
    Response response = await dio.post(
      url,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
      data: jsonEncode(
        {
          "unit_id": unitId,
          ...unitRuleModel.toJson(),
        },
      ),
    );

    return response;
  }

  static Future<void> updateRule(
    String unitId,
    UnitRuleModel unitRuleModel,
  ) async {
    // ignore: unused_local_variable
    Response response = await requestUpdateRule(
      unitId,
      unitRuleModel,
    );
  }
}
