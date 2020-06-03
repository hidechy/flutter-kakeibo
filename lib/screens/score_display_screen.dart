import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kakeibo/data/score_data.dart';

class ScoreDisplayScreen extends StatefulWidget {
  @override
  _ScoreDisplayScreenState createState() => _ScoreDisplayScreenState();
}

class _ScoreDisplayScreenState extends State<ScoreDisplayScreen> {
  List<List<String>> scoreData = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getScoreData();
  }

  _getScoreData() async {
    ScoreData instance = ScoreData();
    await instance.getData();

    scoreData = instance.scoreData;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Score',
          style: TextStyle(fontFamily: "Yomogi"),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: _scoreList(),
        ),
      ),
    );
  }

  Widget _scoreList() {
    return ListView.builder(
      itemCount: scoreData.length,
      itemBuilder: (context, int position) => _listItem(position),
    );
  }

  Widget _listItem(int position) {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: (scoreData[position][2] == '1')
          ? Colors.grey[900]
          : Color(0xFF2e2e2e),
      child: ListTile(
          leading: _getLeading(scoreData[position][3]),
          title: Table(
            children: [
              TableRow(children: [
                Text('${scoreData[position][0]}'),
                Text('${scoreData[position][3]}'),
                Text(''),
              ]),
              TableRow(children: [
                Text(''),
                Text('${scoreData[position][1]}'),
                Text('${scoreData[position][2]}'),
              ]),
            ],
          )),
    );
  }

  Widget _getLeading(String scoreData) {
    if (scoreData == "") {
      return Icon(
        Icons.check_box_outline_blank,
        color: Color(0xFF2e2e2e),
      );
    } else {
      if (int.parse(scoreData) < 0) {
        return Icon(
          Icons.arrow_downward,
          color: Colors.red,
        );
      } else {
        return Icon(
          Icons.arrow_upward,
          color: Colors.greenAccent,
        );
      }
    }
  }
}
