import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kakeibo/data/_utility.dart';
import 'package:kakeibo/data/money_data.dart';
import 'package:kakeibo/data/train_date_data.dart';
import 'package:kakeibo/data/train_date_item_data.dart';

class SpendDisplayScreen extends StatefulWidget {
  final String date;

  SpendDisplayScreen({@required this.date});

  @override
  _SpendDisplayScreenState createState() => _SpendDisplayScreenState();
}

class _SpendDisplayScreenState extends State<SpendDisplayScreen> {
  String date = "";

  String spend;
  String spendItem = "";

  final formatter = NumberFormat("#,###");

  DateTime prevDate;
  DateTime nextDate;

  String youbiStr;
  int youbiNo;

  List<List<String>> trainDateDate = List();

  int trainDate = 0;
  String trainArticle;

  @override
  void initState() {
    super.initState();

    _getMoneyData();
  }

  void _getMoneyData() async {
    MoneyData instance = MoneyData(date: widget.date);
    await instance.getData();
    spend = instance.spend;
    spendItem = instance.spendItem;

    TrainDateData instance2 = TrainDateData();
    await instance2.getData();
    trainDateDate = instance2.trainDateDate;

    Utility _utility = Utility();
    _utility.makeYMDYData(widget.date, 0);

    int year = _utility.year;
    int month = _utility.month;
    int day = _utility.day;

    prevDate = new DateTime(year, month, day - 1);
    nextDate = new DateTime(year, month, day + 1);

    youbiStr = _utility.youbiStr;
    youbiNo = _utility.youbiNo;

    _utility.checkTrainDate(widget.date, trainDateDate);
    trainDate = _utility.trainDate;

    if (trainDate == 1) {
      TrainDateItemData instance3 = TrainDateItemData(date: widget.date);
      await instance3.getData();
      trainArticle = instance3.trainArticle;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    date = widget.date;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '内訳',
          style: TextStyle(fontFamily: "Yomogi"),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.skip_previous),
            tooltip: 'Prev Month',
            onPressed: () => _goPrevDate(),
          ),
          IconButton(
            icon: Icon(Icons.skip_next),
            tooltip: 'Next Month',
            onPressed: () => _goNextDate(),
          ),
        ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Text(
                '${date}（${youbiStr}）',
                style: TextStyle(fontSize: 16.0, color: _getYoubiColor()),
              ),
              Divider(
                color: Colors.indigo,
                height: 20.0,
                indent: 20.0,
                endIndent: 20.0,
              ),
              Table(
                children: [
                  TableRow(children: [
                    Center(
                        child: Text(
                      "消費：",
                      style: TextStyle(fontSize: 16.0),
                    )),
                    Center(
                        child: Text(
                      '$spend',
                      style: TextStyle(fontSize: 16.0),
                    )),
                    Center(),
                  ]),
                ],
              ),
              Divider(
                color: Colors.indigo,
                height: 20.0,
                indent: 20.0,
                endIndent: 20.0,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  spendItem,
                  style: TextStyle(fontSize: 16.0, fontFamily: 'Roboto'),
                ),
              ),
              _getTrainArticle(),
              Center(
                child: IconButton(
                  icon: Icon(Icons.close),
                  tooltip: 'close',
                  color: Colors.blue,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getTrainArticle() {
    switch (trainDate) {
      case 0:
        return Container();
        break;
      case 1:
        return Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Divider(
                color: Colors.indigo,
                height: 20.0,
                indent: 20.0,
                endIndent: 20.0,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '＜電車乗車＞\n${trainArticle}',
                style: TextStyle(fontSize: 16.0, fontFamily: 'Roboto'),
              ),
            ),
          ],
        );
        break;
    }
  }

  _getYoubiColor() {
    switch (youbiNo) {
      case 0:
      case 6:
        return Colors.red;
        break;
      default:
        return Colors.white;
        break;
    }
  }

  _goPrevDate() {
    List<String> explodedPrevDate = (prevDate.toString()).split(' ');

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => SpendDisplayScreen(
                  date: explodedPrevDate[0],
                )));
  }

  _goNextDate() {
    List<String> explodedNextDate = (nextDate.toString()).split(' ');

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => SpendDisplayScreen(
                  date: explodedNextDate[0],
                )));
  }
}
