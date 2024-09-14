import "dart:convert";

import "package:dio/dio.dart";
import "package:armywiki/utility/constant.dart";
import "package:armywiki/model/unit_model.dart";

class GetUnitsController {
  static String url = "$baseUrl/get_units/";
  static Dio dio = Dio();

  static Future<Response> requestGetUnits(
    List<String> unitIds,
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
          "unit_ids": unitIds,
        },
      ),
    );

    return response;
  }

  static Future<List<UnitModel>> getUnits(
    List<String> unitIds,
  ) async {
    Response response = await requestGetUnits(
      unitIds,
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
