import 'package:http/http.dart';
import 'dart:convert';

class TrainDateData {
  List<List<String>> trainDateDate = List();

  Future<void> getData() async {
    Response response =
        await get('http://toyohide.work/BrainLog/article/traindateapi');

    if (response != null) {
      String responseBody =
          response.body.replaceAll('[', '').replaceAll(']', '');
      if (responseBody.length > 0) {
        Map data = jsonDecode(response.body);

        for (int i = 0; i < data['data'].length; i++) {
          trainDateDate.add([data['data'][i]['date']]);
        }
      }
    }
  }
}
