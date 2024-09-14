import "dart:convert";

import "package:dio/dio.dart";
import "package:armywiki/model/unit_rule_model.dart";
import "package:armywiki/utility/constant.dart";

class GetUnitRuleController {
  static String url = "$baseUrl/get_unit_rule/";
  static Dio dio = Dio();

  static Future<Response> requestGetRule(
    String unitId,
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
        },
      ),
    );

    return response;
  }

  static Future<UnitRuleModel> getRule(
    String unitId,
  ) async {
    Response response = await requestGetRule(
      unitId,
    );

    return UnitRuleModel.fromJson(
      response.data,
    );
  }
}
