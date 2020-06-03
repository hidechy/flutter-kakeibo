import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'dart:convert';

class BankData {
  final String bank;

  List<List<String>> bankData = List();

  BankData({@required this.bank});

  Future<void> getData() async {
    Response response =
        await get('http://toyohide.work/BrainLog/money/${bank}/bankapi');

    if (response != null) {
      String responseBody =
          response.body.replaceAll('[', '').replaceAll(']', '');
      if (responseBody.length > 0) {
        Map data = jsonDecode(response.body);

        for (int i = 0; i < data['data'].length; i++) {
          bankData.add([
            data['data'][i]['date'],
            data['data'][i]['yen'],
            data['data'][i]['mark'].toString()
          ]);
        }
      }
    }
  }
}
