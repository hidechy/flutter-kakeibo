import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kakeibo/data/_utility.dart';
import 'package:kakeibo/data/koumoku_item_data.dart';

class KoumokuItemDisplayScreen extends StatefulWidget {
  final String date;

  KoumokuItemDisplayScreen({@required this.date});

  @override
  _KoumokuItemDisplayScreenState createState() =>
      _KoumokuItemDisplayScreenState();
}

class _KoumokuItemDisplayScreenState extends State<KoumokuItemDisplayScreen> {
  String date;
  String total;

  List<List<String>> koumokuItemData = List();

  String prevMonth;
  String nextMonth;

  final formatter = NumberFormat("#,###");

  @override
  void initState() {
    super.initState();

    _getKoumokuData();
  }

  _getKoumokuData() async {
    date = widget.date;

    KoumokuItemData instance = KoumokuItemData(date: date);
    await instance.getData();

    total = instance.total;

    koumokuItemData = instance.koumokuItemData;

    setState(() {
      Utility instance2 = Utility();
      instance2.makeYMDYData(date, 1);
      int year = instance2.year;
      int month = instance2.month;
      int day = instance2.day;

      DateTime _prevMonth = new DateTime(year, month - 1, day);
      DateTime _nextMonth = new DateTime(year, month + 1, day);

      List<String> explodePrevMonth = (_prevMonth.toString()).split(' ');
      List<String> explodeNextMonth = (_nextMonth.toString()).split(' ');

      prevMonth = explodePrevMonth[0];
      nextMonth = explodeNextMonth[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.date}',
          style: TextStyle(fontFamily: "Yomogi"),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.skip_previous),
            tooltip: 'Prev Month',
            onPressed: () => _goPrevMonth(),
          ),
          IconButton(
            icon: Icon(Icons.skip_next),
            tooltip: 'Next Month',
            onPressed: () => _goNextMonth(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: _koumokuDisplay(),
      ),
    );
  }

  Widget _koumokuDisplay() {
    if (koumokuItemData == null) {
      return Container();
    }

    List<Widget> _returnWidget = List();
    for (int i = 0; i < koumokuItemData.length; i++) {
      if (koumokuItemData[i] != "nodata") {
        _returnWidget.add(_makeKoumokuDisplayRow(koumokuItemData[i]));
      }
    }

    return Column(
      children: _returnWidget,
    );
  }

  Widget _makeKoumokuDisplayRow(List koumoku) {
    return DefaultTextStyle(
      style: TextStyle(fontSize: 16.0, fontFamily: "Roboto"),
      child: Row(
        children: <Widget>[
          Expanded(flex: 2, child: Text(koumoku[0].replaceAll(' ', ''))),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.topRight,
              child: Text(koumoku[1]),
            ),
          ),
          Expanded(flex: 1, child: Text(koumoku[2])),
        ],
      ),
    );
  }

  _goPrevMonth() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => KoumokuItemDisplayScreen(
                  date: prevMonth.toString(),
                )));
  }

  _goNextMonth() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => KoumokuItemDisplayScreen(
                  date: nextMonth.toString(),
                )));
  }
}
