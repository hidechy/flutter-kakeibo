import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'package:intl/intl.dart';

class MoneyData {
  final String date;

  int total;
  String spend;

  int yen_10000;
  int yen_5000;
  int yen_2000;
  int yen_1000;
  int yen_500;
  int yen_100;
  int yen_50;
  int yen_10;
  int yen_5;
  int yen_1;

  int bank_a;
  int bank_b;
  int bank_c;
  int bank_d;

  int pay_a;
  int pay_b;

  String spendItem = "";

  int hand;

  MoneyData({@required this.date});

  final formatter = NumberFormat("#,###");

  Future<void> getData() async {
    Response response =
        await get('http://toyohide.work/BrainLog/money/${date}/api');

    if (response != null) {
      String responseBody =
          response.body.replaceAll('[', '').replaceAll(']', '');
      if (responseBody.length > 0) {
        Map data = jsonDecode(response.body);

        total = (data['total'] != 0) ? int.parse(data['total']).toInt() : 0;

        if (data['spend'] == "0") {
          spend = data['spend'];
        } else {
          String _spend = (data['spend']).toString().replaceAll('-', '');
          if (_spend != data['spend']) {
            //マイナスの場合（お金が増えた）
            spend = data['spend'].toString();
          } else {
            int _spend = int.parse(data['spend']).toInt();
            spend = formatter.format(_spend);
          }
        }

        yen_10000 = (data['data']['yen_10000'] != 0)
            ? int.parse(data['data']['yen_10000']).toInt()
            : 0;
        yen_5000 = (data['data']['yen_5000'] != 0)
            ? int.parse(data['data']['yen_5000']).toInt()
            : 0;
        yen_2000 = (data['data']['yen_2000'] != 0)
            ? int.parse(data['data']['yen_2000']).toInt()
            : 0;
        yen_1000 = (data['data']['yen_1000'] != 0)
            ? int.parse(data['data']['yen_1000']).toInt()
            : 0;
        yen_500 = (data['data']['yen_500'] != 0)
            ? int.parse(data['data']['yen_500']).toInt()
            : 0;
        yen_100 = (data['data']['yen_100'] != 0)
            ? int.parse(data['data']['yen_100']).toInt()
            : 0;
        yen_50 = (data['data']['yen_50'] != 0)
            ? int.parse(data['data']['yen_50']).toInt()
            : 0;
        yen_10 = (data['data']['yen_10'] != 0)
            ? int.parse(data['data']['yen_10']).toInt()
            : 0;
        yen_5 = (data['data']['yen_5'] != 0)
            ? int.parse(data['data']['yen_5']).toInt()
            : 0;
        yen_1 = (data['data']['yen_1'] != 0)
            ? int.parse(data['data']['yen_1']).toInt()
            : 0;

        bank_a = (data['data']['bank_a'] != 0)
            ? int.parse(data['data']['bank_a']).toInt()
            : 0;
        bank_b = (data['data']['bank_b'] != 0)
            ? int.parse(data['data']['bank_b']).toInt()
            : 0;
        bank_c = (data['data']['bank_c'] != 0)
            ? int.parse(data['data']['bank_c']).toInt()
            : 0;
        bank_d = (data['data']['bank_d'] != 0)
            ? int.parse(data['data']['bank_d']).toInt()
            : 0;

        pay_a = (data['data']['pay_a'] != 0)
            ? int.parse(data['data']['pay_a']).toInt()
            : 0;
        pay_b = (data['data']['pay_b'] != 0)
            ? int.parse(data['data']['pay_b']).toInt()
            : 0;

        spendItem = data['items']
            .toString()
            .replaceAll('[', '')
            .replaceAll(']', '')
            .split(', ')
            .join('\n');

        hand = data['hand'];
      }
    }
  }
}
