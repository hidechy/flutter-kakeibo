import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'dart:convert';

class MonthlyItemData {
  final String date;
  String total = '0';

  List<List<String>> monthlyItemData = List();

  MonthlyItemData({@required this.date});

  Future<void> getData() async {
    Response response = await get(
        'http://toyohide.work/BrainLog/money/${date}-01/monthitemapi');

    if (response != null) {
      String responseBody =
          response.body.replaceAll('[', '').replaceAll(']', '');
      if (responseBody.length > 0) {
        Map data = jsonDecode(response.body);

        if (data['data'] != "nodata") {
          total = data['total'];

          for (int i = 0; i < data['data'].length; i++) {
            monthlyItemData.add([
              data['data'][i]['date'],
              data['data'][i]['sum'],
              data['data'][i]['item']
            ]);
          }
        }
      }
    }
  }
}
