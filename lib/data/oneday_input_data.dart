import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class OnedayInputData {
  final String data;

  OnedayInputData({@required this.data});

  Future<void> getData() async {
    Response response =
        await get('http://toyohide.work/BrainLog/money/${data}/onedayinputapi');
  }
}
