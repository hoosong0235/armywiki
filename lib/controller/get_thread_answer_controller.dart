import "dart:convert";

import "package:dio/dio.dart";
import "package:armywiki/model/chat_model.dart";
import "package:armywiki/utility/constant.dart";

class GetThreadAnswerController {
  static String url = "$baseUrl/get_thread_answer/";
  static Dio dio = Dio();

  static Future<Response> requestGetThreadId(
    String unitId,
    String threadId,
    String question,
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
          "thread_id": threadId,
          "question": question,
        },
      ),
    );

    return response;
  }

  static Future<ChatModel> getThreadAnswer(
    String unitId,
    String threadId,
    String question,
  ) async {
    Response response = await requestGetThreadId(
      unitId,
      threadId,
      question,
    );

    return ChatModel.fromJson(
      response.data,
    );
  }
}
