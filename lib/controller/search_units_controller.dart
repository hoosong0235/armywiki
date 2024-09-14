import "dart:convert";

import "package:dio/dio.dart";
import "package:armywiki/utility/constant.dart";
import "package:armywiki/model/unit_model.dart";

class SearchUnitsController {
  static String url = "$baseUrl/search_units/";
  static Dio dio = Dio();

  static Future<Response> requestSearchUnits(
    String keyword,
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
          "keyword": keyword,
        },
      ),
    );

    return response;
  }

  static Future<List<UnitModel>> searchUnits(
    String keyword,
  ) async {
    Response response = await requestSearchUnits(
      keyword,
    );

    return List.generate(
      response.data["units"].length,
      (
        index,
      ) =>
          UnitModel.fromJson(
        response.data["units"][index],
      ),
    );
  }
}
