import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'dart:convert';

class TrainDateItemData {
  final String date;

  String trainArticle;

  TrainDateItemData({@required this.date});

  Future<void> getData() async {
    Response response =
        await get('http://toyohide.work/BrainLog/article/${date}/traindataapi');

    if (response != null) {
      String responseBody =
          response.body.replaceAll('[', '').replaceAll(']', '');
      if (responseBody.length > 0) {
        Map data = jsonDecode(response.body);

        trainArticle = data['data'][0]['article'];
      }
    }
  }
}
