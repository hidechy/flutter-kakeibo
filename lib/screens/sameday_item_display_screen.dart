import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kakeibo/data/_utility.dart';
import 'package:kakeibo/data/sameday_item_data.dart';
import 'package:kakeibo/data/train_date_data.dart';
import 'package:kakeibo/screens/spend_display_screen.dart';

class SamedayItemDisplayScreen extends StatefulWidget {
  final String date;

  SamedayItemDisplayScreen({@required this.date});

  @override
  _SamedayItemDisplayScreenState createState() =>
      _SamedayItemDisplayScreenState();
}

class _SamedayItemDisplayScreenState extends State<SamedayItemDisplayScreen> {
  String date;

  List<List<String>> samedayItemData = List();

  String prevMonth;
  String nextMonth;

  int youbiNo;

  List<List<String>> trainDateDate = List();

  @override
  void initState() {
    super.initState();

    _getSpendItemData();
  }

  _getSpendItemData() async {
    date = widget.date;

    SpendItemData _spendItemData = SpendItemData(date: date);
    await _spendItemData.getData();
    samedayItemData = _spendItemData.spendItemData;

    TrainDateData _trainDateData = TrainDateData();
    await _trainDateData.getData();
    trainDateDate = _trainDateData.trainDateDate;

    setState(() {
      Utility _utility = Utility();
      _utility.makeYMDYData(date, 0);
      int year = _utility.year;
      int month = _utility.month;
      int day = _utility.day;

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
          widget.date,
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
          child: _samedayItemList(),
        ),
      ),
    );
  }

  Widget _samedayItemList() {
    return ListView.builder(
      itemCount: samedayItemData.length,
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
        title: Text(
          "${samedayItemData[position][0]}(${_getYoubiStr(samedayItemData[position][0])})${samedayItemData[position][1]}",
          style: TextStyle(
              color: _getYoubiColor(samedayItemData[position][0]),
              fontFamily: 'Yomogi'),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SpendDisplayScreen(
                date: samedayItemData[position][0],
              ),
            ),
          );
        },
        leading: _getSamedayItemListIcon(samedayItemData, position),
      ),
    );
  }

  _getSamedayItemListIcon(List<List<String>> samedayItemData, int position) {
    Utility _utility = Utility();
    _utility.checkTrainDate(samedayItemData[position][0], trainDateDate);

    if (_utility.trainDate == 1) {
      return Icon(Icons.train, color: Colors.white);
    } else {
      return Icon(Icons.check_box_outline_blank, color: Color(0xFF2e2e2e));
    }
  }

  _getYoubiColor(String samedayItemDate) {
    //---------//ここで作成する必要あり
    Utility _utitily = Utility();
    _utitily.makeYMDYData(samedayItemDate, 0);
    //---------//
    switch (_utitily.youbiNo) {
      case 0:
      case 6:
        return Colors.red;
        break;
      default:
        return Colors.white;
        break;
    }
  }

  _getYoubiStr(String samedayItemDate) {
    //---------//ここで作成する必要あり
    Utility _utility = Utility();
    _utility.makeYMDYData(samedayItemDate, 0);
    return _utility.youbiStr;
    //---------//
  }

  _goPrevMonth() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => SamedayItemDisplayScreen(
                  date: prevMonth.toString(),
                )));
  }

  _goNextMonth() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => SamedayItemDisplayScreen(
                  date: nextMonth.toString(),
                )));
  }
}
