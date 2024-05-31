import 'dart:convert';

import 'package:dio/dio.dart';

class BotService {
  final BOT_BASE_URL = "http://127.0.0.1:8000/";
  Dio get dio => Dio();
  sendQuery(jsonObj) async {
    var url = BOT_BASE_URL + "bot/get-data?format=json";
    var encode = jsonEncode(jsonObj);
    var response = await dio.post(url, data: encode);
    return response.data;
  }
}
