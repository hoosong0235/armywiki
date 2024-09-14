import "package:dio/dio.dart";
import "package:armywiki/model/rule_model.dart";
import "package:armywiki/utility/constant.dart";

class GetRuleController {
  static String url = "$baseUrl/get_rule/";
  static Dio dio = Dio();

  static Future<Response> requestGetRule() async {
    Response response = await dio.post(
      url,
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );

    return response;
  }

  static Future<RuleModel> getRule() async {
    Response response = await requestGetRule();

    return RuleModel.fromJson(
      response.data,
    );
  }
}
