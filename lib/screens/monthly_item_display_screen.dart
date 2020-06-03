import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:kakeibo/data/_utility.dart';
import 'package:kakeibo/data/monthly_item_data.dart';
import 'package:kakeibo/data/train_date_data.dart';
import 'package:kakeibo/data/train_list_item_data.dart';

class MonthlyItemDisplayScreen extends StatefulWidget {
  final String date;

  MonthlyItemDisplayScreen({@required this.date});

  @override
  _MonthlyItemDisplayScreenState createState() =>
      _MonthlyItemDisplayScreenState();
}

class _MonthlyItemDisplayScreenState extends State<MonthlyItemDisplayScreen> {
  String date;
  String total;

  List<List<String>> monthlyItemData = List();

  String prevMonth;
  String nextMonth;

  List<List<String>> trainDateDate = List();

  Map<String, String> trainListItemData = Map();

  @override
  void initState() {
    super.initState();

    _getSpendItemData();
  }

  _getSpendItemData() async {
    date = widget.date;

    MonthlyItemData _monthlyItemData = MonthlyItemData(date: date);
    await _monthlyItemData.getData();
    monthlyItemData = _monthlyItemData.monthlyItemData;
    total = _monthlyItemData.total;

    TrainDateData _trainDateData = TrainDateData();
    await _trainDateData.getData();
    trainDateDate = _trainDateData.trainDateDate;

    TrainListItemData _trainListItemData = TrainListItemData(date: date);
    await _trainListItemData.getData();
    trainListItemData = _trainListItemData.trainListItemData;

    Utility _utility = Utility();
    _utility.makeYMDYData(date, 1);
    int year = _utility.year;
    int month = _utility.month;
    int day = _utility.day;

    DateTime _prevMonth = new DateTime(year, month - 1, day);
    DateTime _nextMonth = new DateTime(year, month + 1, day);

    List<String> explodePrevMonth = (_prevMonth.toString()).split(' ');
    List<String> explodeNextMonth = (_nextMonth.toString()).split(' ');

    prevMonth = explodePrevMonth[0];
    nextMonth = explodeNextMonth[0];

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List explodedSelectedDate = (date).split('-');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${explodedSelectedDate[0]}-${explodedSelectedDate[1]}',
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
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: _monthlyItemList(),
        ),
      ),
    );
  }

  Widget _monthlyItemList() {
    return ListView.builder(
      itemCount: monthlyItemData.length,
      itemBuilder: (context, int position) => _listItem(position),
    );
  }

  Widget _listItem(int position) {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Colors.grey[900],
      child: ListTile(
        title: _getMonthlyItemDisplayData(monthlyItemData, position),
      ),
    );
  }

  Widget _getMonthlyItemDisplayData(
      List<List<String>> monthlyItemData, int position) {
    Utility _utility = Utility();
    _utility.checkTrainDate(monthlyItemData[position][0], trainDateDate);

    switch (_utility.trainDate) {
      case 0:
        return Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${monthlyItemData[position][0]}（${_getYoubiStr(monthlyItemData[position][0])}）　${monthlyItemData[position][1]}\n${monthlyItemData[position][2]}',
                style: TextStyle(
                    color: _getYoubiColor(monthlyItemData[position][0]),
                    fontFamily: 'Roboto'),
              ),
            ),
          ],
        );
        break;
      case 1:
        return Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${monthlyItemData[position][0]}（${_getYoubiStr(monthlyItemData[position][0])}）　${monthlyItemData[position][1]}\n${monthlyItemData[position][2]}',
                style: TextStyle(
                    color: _getYoubiColor(monthlyItemData[position][0]),
                    fontFamily: 'Roboto'),
              ),
            ),
            Divider(
              color: Colors.indigo,
              height: 20.0,
              indent: 20.0,
              endIndent: 20.0,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: double.infinity,
                color: Color(0xFF2e2e2e),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '＜電車乗車＞\n${trainListItemData[monthlyItemData[position][0]]}',
                    style: TextStyle(
                        color: Color(0xFF999999), fontFamily: 'Roboto'),
                  ),
                ),
              ),
            ),
          ],
        );
        break;
    }
  }

  _getYoubiColor(String spendItemDate) {
    Utility _utility = Utility();
    _utility.makeYMDYData(spendItemDate, 0);
    switch (_utility.youbiNo) {
      case 0:
      case 6:
        return Colors.red;
        break;
      default:
        return Colors.white;
        break;
    }
  }

  _getYoubiStr(String spendItemDate) {
    Utility _utility = Utility();
    _utility.makeYMDYData(spendItemDate, 0);
    return _utility.youbiStr;
  }

  _goPrevMonth() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => MonthlyItemDisplayScreen(
                  date: prevMonth.toString(),
                )));
  }

  _goNextMonth() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => MonthlyItemDisplayScreen(
                  date: nextMonth.toString(),
                )));
  }
}
