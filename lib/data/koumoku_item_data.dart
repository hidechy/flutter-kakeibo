import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'dart:convert';

class KoumokuItemData {
  final String date;

  String total;

  List<List<String>> koumokuItemData = List();

  KoumokuItemData({@required this.date});

  Future<void> getData() async {
    Response response = await get(
        'http://toyohide.work/BrainLog/money/${date}-01/monthkoumokuapi');
    Map data = jsonDecode(response.body);

    total = data['total'];

    for (int i = 0; i < data['data'].length; i++) {
      koumokuItemData.add([
        data['data'][i]['item'],
        data['data'][i]['sum'].toString(),
        data['data'][i]['percentage']
      ]);
    }
  }
}
