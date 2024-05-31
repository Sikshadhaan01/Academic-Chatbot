import 'package:flutter/material.dart';

class CommonService {
  bool handleResponseMessage(context, response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: response['statusCode']==200 ? Colors.green : Colors.red,
        content: Text(response['message']),
      ),
    );
    return response['statusCode']==200 ? true : false;
  }
}
