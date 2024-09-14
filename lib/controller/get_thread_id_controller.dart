import "dart:convert";

import "package:dio/dio.dart";
import "package:armywiki/model/thread_model.dart";
import "package:armywiki/utility/constant.dart";

class GetThreadIdController {
  static String url = "$baseUrl/get_thread_id/";
  static Dio dio = Dio();

  static Future<Response> requestGetThreadId(
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

  static Future<ThreadModel> getThreadId(
    String unitId,
  ) async {
    Response response = await requestGetThreadId(
      unitId,
    );

    return ThreadModel.fromJson(
      response.data,
    );
  }
}
