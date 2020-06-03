import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'dart:convert';

class TrainListItemData {
  final String date;

  String trainArticle;

  Map<String, String> trainListItemData = Map();

  TrainListItemData({@required this.date});

  Future<void> getData() async {
    Response response = await get(
        'http://toyohide.work/BrainLog/article/${date}-01/trainmonthdataapi');

    if (response != null) {
      String responseBody =
          response.body.replaceAll('[', '').replaceAll(']', '');
      if (responseBody.length > 0) {
        Map data = jsonDecode(response.body);

        for (int i = 0; i < data['data'].length; i++) {
          trainListItemData[data['data'][i]['date']] =
              data['data'][i]['article'];
        }
      }
    }
  }
}
