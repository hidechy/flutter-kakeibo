import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'dart:convert';

class SpendItemData {
  final String date;

  List<List<String>> spendItemData = List();

  SpendItemData({@required this.date});

  Future<void> getData() async {
    Response response =
        await get('http://toyohide.work/BrainLog/money/${date}/spenditemapi');

    if (response != null) {
      String responseBody =
          response.body.replaceAll('[', '').replaceAll(']', '');
      if (responseBody.length > 0) {
        Map data = jsonDecode(response.body);

        for (int i = 0; i < data['data'].length; i++) {
          spendItemData.add([
            data['data'][i]['date'],
            data['data'][i]['sum'],
            data['data'][i]['item']
          ]);
        }
      }
    }
  }
}
