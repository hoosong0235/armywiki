import "dart:convert";

import "package:dio/dio.dart";
import "package:armywiki/utility/constant.dart";
import "package:armywiki/model/unit_model.dart";

class GetUnitController {
  static String url = "$baseUrl/get_unit/";
  static Dio dio = Dio();

  static Future<Response> requestGetUnits(
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

  static Future<UnitModel> getUnit(
    String unitId,
  ) async {
    Response response = await requestGetUnits(
      unitId,
    );

    return UnitModel.fromJson(
      response.data["unit"],
    );
  }

  static Future<UnitModel?> getUnitNullable(
    String unitId,
  ) async {
    try {
      return await GetUnitController.getUnit(
        unitId,
      );
    } catch (e) {
      return null;
    }
  }
}
