import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SubjectService {
  Dio dio = Dio();
  var BASE_URL = dotenv.get("API_URL");

  getSubjects(department, semester) async {
    var url =
        BASE_URL + "/subjects/get-subjects/${department + '/' + semester}";
    var response = await dio.post(url);
    return response.data;
  }

  uploadNote(formData) async {
    var url = BASE_URL + "/subjects/upload-note";
    Response response = await dio.post(url, data: formData);
    return response.data;
  }

  uploadAnnouncement(formData) async {
    var url = BASE_URL + "/announcement/upload-announcement";
    Response response = await dio.post(url, data: formData);
    return response.data;
  }

  deleteAnnouncement(id) async {
    var url = BASE_URL + "/announcement/delete-announcement/$id";
    Response response = await dio.post(url);
    return response.data;
  }

  getAllAnnouncements() async {
    var url = BASE_URL + "/announcement/get-all-announcement";
    Response response = await dio.post(url);
    return response.data;
  }

  getNotes(department, semester, subject) async {
    var url = BASE_URL + "/subjects/fetch-all-notes/$department/$semester/$subject";
    Response response = await dio.post(url);
    return response.data;
  }

   deleteNote(department, semester, subject, filename) async {
    var url = BASE_URL + "/subjects/delete-note/$department/$semester/$subject/$filename";
    Response response = await dio.post(url);
    return response.data;
  }
}
