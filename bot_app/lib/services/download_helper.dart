// import 'dart:ffi';
// import 'dart:html';
// import 'dart:html';

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

class DownloadHelper {
  Future<void> downloadFileOnMobile(String url, String fileName) async {
    try {
      Dio dio = Dio();
      var dir = await getApplicationDocumentsDirectory();
      String filePath = "${dir.path}/$fileName";

      await dio.download(url, filePath);

      print("File saved to $filePath");
    } catch (e) {
      print("Error downloading file: $e");
    }
  }

  void downloadFile(String url) async {
    final taskId = await FlutterDownloader.enqueue(
      url: url,
      savedDir: '/storage/emulated/0/Download/',
      saveInPublicStorage: true,
      showNotification:
          true, // show download progress in status bar (for Android)
      openFileFromNotification:
          true, // click on notification to open downloaded file (for Android)
    );
  }
}
