import 'package:http/http.dart';
import 'dart:convert';

class ScoreData {
  List<List<String>> scoreData = List();

  Future<void> getData() async {
    Response response =
        await get('http://toyohide.work/BrainLog/money/monthscoreapi');

    if (response != null) {
      String responseBody =
          response.body.replaceAll('[', '').replaceAll(']', '');
      if (responseBody.length > 0) {
        Map data = jsonDecode(response.body);

        for (int i = 0; i < data['data'].length; i++) {
          scoreData.add([
            data['data'][i]['ym'],
            data['data'][i]['start'].toString(),
            (data['data'][i]['end'] == "")
                ? data['data'][i]['end']
                : data['data'][i]['end'].toString(),
            (data['data'][i]['score'] == "")
                ? data['data'][i]['score']
                : data['data'][i]['score'].toString()
          ]);
        }
      }
    }
  }
}
