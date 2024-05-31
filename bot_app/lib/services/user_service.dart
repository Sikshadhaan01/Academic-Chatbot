import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserService {
  Dio dio = Dio();
  var BASE_URL = dotenv.get("API_URL");
  
  signup(jsonObj) async {
    var url = BASE_URL + "/users/sign-up";
    var encode = jsonEncode(jsonObj);
    var response = await dio.post(url, data: encode);
    return response.data;
  }

  login(jsonObj) async {
    var url = BASE_URL + "/users/login-user";
    var encode = jsonEncode(jsonObj);
    var response = await dio.post(url, data: encode);
    return response.data;
  }
}
