import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'dart:convert';

class MonthlyData {
  final String date;

  List<List<String>> monthlyData = List();

  MonthlyData({@required this.date});

  Future<void> getData() async {
    Response response =
        await get('http://toyohide.work/BrainLog/money/${date}/monthlistapi');

    if (response != null) {
      String responseBody =
          response.body.replaceAll('[', '').replaceAll(']', '');
      if (responseBody.length > 0) {
        Map data = jsonDecode(response.body);

        for (int i = 0; i < data['data'].length; i++) {
          monthlyData.add([
            data['data'][i]['date'],
            data['data'][i]['sum'],
            data['data'][i]['bg'].toString()
          ]);
        }
      }
    }
  }
}
