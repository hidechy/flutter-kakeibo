import 'package:flutter/material.dart';
import 'package:kakeibo/data/_utility.dart';
import 'package:kakeibo/data/sameday_item_data.dart';
import 'package:kakeibo/screens/bank_display_screen.dart';
import 'package:kakeibo/screens/koumoku_display_screen.dart';
import 'package:kakeibo/screens/monthly_display_screen.dart';
import 'package:kakeibo/screens/sameday_display_screen.dart';
import 'package:kakeibo/screens/score_display_screen.dart';
import 'package:kakeibo/screens/spend_display_screen.dart';
import 'package:kakeibo/screens/oneday_input_screen.dart';
import 'package:kakeibo/data/money_data.dart';
import 'package:intl/intl.dart';

class DetailDisplayScreen extends StatefulWidget {
  final String date;

  DetailDisplayScreen({@required this.date});

  @override
  _DetailDisplayScreenState createState() => _DetailDisplayScreenState();
}

class _DetailDisplayScreenState extends State<DetailDisplayScreen> {
  String date;
  String selecedDate = "";

  DateTime prevDate;
  DateTime nextDate;

  int total = 0;
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

  int bank_a = 0;
  int bank_b = 0;
  int bank_c = 0;
  int bank_d = 0;

  int pay_a = 0;
  int pay_b = 0;

  String spendItem = "";

  int hand = 0;

  final formatter = NumberFormat("#,###");

  List<List<String>> samedayItemData = List();

  int monthlySpendTotal = 0;
  int monthAverage = 0;
  int aveDay = 0;

  @override
  void initState() {
    super.initState();

    date = widget.date;
    List explodedDate = date.split(' ');
    selecedDate = explodedDate[0];

    _getMoneyData();
  }

  void _getMoneyData() async {
    MoneyData instance = MoneyData(date: selecedDate);
    await instance.getData();

    total = instance.total;
    spend = instance.spend;

    yen_10000 = instance.yen_10000;
    yen_5000 = instance.yen_5000;
    yen_2000 = instance.yen_2000;
    yen_1000 = instance.yen_1000;
    yen_500 = instance.yen_500;
    yen_100 = instance.yen_100;
    yen_50 = instance.yen_50;
    yen_10 = instance.yen_10;
    yen_5 = instance.yen_5;
    yen_1 = instance.yen_1;

    bank_a = instance.bank_a;
    bank_b = instance.bank_b;
    bank_c = instance.bank_c;
    bank_d = instance.bank_d;

    pay_a = instance.pay_a;
    pay_b = instance.pay_b;

    spendItem = instance.spendItem;

    hand = instance.hand;

    //----------------------------------//
    SpendItemData _spendItemData = SpendItemData(date: date);
    await _spendItemData.getData();
    samedayItemData = _spendItemData.spendItemData;
    for (int i = 0; i < samedayItemData.length; i++) {
      monthlySpendTotal += int.parse(samedayItemData[i][1].replaceAll(',', ''));
    }

    List explodedDate = selecedDate.split('-');
    int year = int.parse(explodedDate[0]).toInt();
    int month = int.parse(explodedDate[1]).toInt();
    aveDay = int.parse(explodedDate[2]).toInt();

    monthAverage = (monthlySpendTotal / aveDay).floor();
    //----------------------------------//

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Utility instance2 = Utility();
    instance2.makeYMDYData(selecedDate, 0);
    int year = instance2.year;
    int month = instance2.month;
    int day = instance2.day;
    String youbiStr = instance2.youbiStr;

    prevDate = new DateTime(year, month, day - 1);
    nextDate = new DateTime(year, month, day + 1);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '残額',
          style: TextStyle(fontFamily: "Yomogi"),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          DefaultTextStyle(
            style: TextStyle(fontSize: 16.0, fontFamily: "Yomogi"),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.skip_previous),
                      Text(
                        '前日',
                      ),
                    ],
                  ),
                  onPressed: () => _goPrevDate(context),
                ),
                Text(
                  '${selecedDate}（${youbiStr}）',
                  style: TextStyle(color: _getYoubiColor(selecedDate)),
                ),
                FlatButton(
                  child: Row(
                    children: <Widget>[
                      Text(
                        '翌日',
                      ),
                      Icon(Icons.skip_next),
                    ],
                  ),
                  onPressed: () => _goNextDate(context),
                )
              ],
            ),
          ),
          Divider(
            color: Colors.indigo,
            height: 20.0,
            indent: 20.0,
            endIndent: 20.0,
          ),
          SizedBox(
            height: 10.0,
          ),
          DefaultTextStyle(
            style: TextStyle(fontSize: 16.0, fontFamily: "Yomogi"),
            child: Column(
              children: <Widget>[
                //----------------//
                Table(
                  children: [
                    TableRow(children: [
                      _getTextDispWidget('total'),
                      _getTextDispWidget(formatter.format(total).toString()),
                      Align(),
                    ]),
                    TableRow(children: [
                      _getTextDispWidget('month average'),
                      _getTextDispWidget(
                          formatter.format(monthAverage).toString()),
                      _getTextDispWidget(
                          '(${formatter.format(monthlySpendTotal).toString()} / ${aveDay})'),
                    ]),
                    TableRow(children: [
                      _getTextDispWidget('day spend'),
                      _getTextDispWidget('$spend'),
                      Center(
                        child: IconButton(
                          icon: Icon(Icons.details),
                          tooltip: 'spend',
                          color: Colors.blue,
                          onPressed: () => _goSpendDisplayScreen(),
                        ),
                      ),
                    ]),
                  ],
                ),
                //----------------//

                Divider(
                  color: Colors.indigo,
                  height: 20.0,
                  indent: 20.0,
                  endIndent: 20.0,
                ),

                //----------------//
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Table(
                    children: [
                      TableRow(children: [
                        _getTextDispWidget('10000'),
                        _getTextDispWidget(yen_10000.toString()),
                        _getTextDispWidget('100'),
                        _getTextDispWidget(yen_100.toString()),
                      ]),
                      TableRow(children: [
                        _getTextDispWidget('5000'),
                        _getTextDispWidget(yen_5000.toString()),
                        _getTextDispWidget('50'),
                        _getTextDispWidget(yen_50.toString()),
                      ]),
                      TableRow(children: [
                        _getTextDispWidget('2000'),
                        _getTextDispWidget(yen_2000.toString()),
                        _getTextDispWidget('10'),
                        _getTextDispWidget(yen_10.toString()),
                      ]),
                      TableRow(children: [
                        _getTextDispWidget('1000'),
                        _getTextDispWidget(yen_1000.toString()),
                        _getTextDispWidget('5'),
                        _getTextDispWidget(yen_5.toString()),
                      ]),
                      TableRow(children: [
                        _getTextDispWidget('500'),
                        _getTextDispWidget(yen_500.toString()),
                        _getTextDispWidget('1'),
                        _getTextDispWidget(yen_1.toString()),
                      ]),
                    ],
                  ),
                ),
                //----------------//

                Divider(
                  color: Colors.indigo,
                  height: 20.0,
                  indent: 20.0,
                  endIndent: 20.0,
                ),

                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 50.0),
                    child: Text(
                      formatter.format(hand).toString(),
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ),

                /////////////////////////////////////////
                Table(
                  children: [
                    TableRow(children: [
                      _getTextDispWidget('bank_a'),
                      _getTextDispWidget(formatter.format(bank_a).toString()),
                      Align(),
                    ]),
                    TableRow(children: [
                      _getTextDispWidget('bank_b'),
                      _getTextDispWidget(formatter.format(bank_b).toString()),
                      Align(),
                    ]),
                    TableRow(children: [
                      _getTextDispWidget('bank_c'),
                      _getTextDispWidget(formatter.format(bank_c).toString()),
                      Align(),
                    ]),
                    TableRow(children: [
                      _getTextDispWidget('bank_d'),
                      _getTextDispWidget(formatter.format(bank_d).toString()),
                      Align(),
                    ]),
                  ],
                ),
                //>>>>>>>>>>>>>>>>>>>>>//

                Divider(
                  color: Colors.indigo,
                  height: 20.0,
                  indent: 20.0,
                  endIndent: 20.0,
                ),

                //>>>>>>>>>>>>>>>>>>>>>//
                Table(
                  children: [
                    TableRow(children: [
                      _getTextDispWidget('pay_a'),
                      _getTextDispWidget(formatter.format(pay_a).toString()),
                      Align(),
                    ]),
                    TableRow(children: [
                      _getTextDispWidget('pay_b'),
                      _getTextDispWidget(formatter.format(pay_b).toString()),
                      Align(),
                    ]),
                  ],
                ),
                /////////////////////////////////////////
              ],
            ),
          ),
          Divider(
            color: Colors.indigo,
            height: 20.0,
            indent: 20.0,
            endIndent: 20.0,
          ),
          Expanded(
            child: Center(
              child: IconButton(
                icon: Icon(Icons.keyboard_arrow_up),
                tooltip: 'menu',
                color: Colors.blue,
                onPressed: () => _showUnderMenu(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _getYoubiColor(String spendItemDate) {
    Utility instance3 = Utility();
    instance3.makeYMDYData(spendItemDate, 0);
    switch (instance3.youbiNo) {
      case 0:
      case 6:
        return Colors.red;
        break;
      default:
        return Colors.white;
        break;
    }
  }

  Widget _getTextDispWidget(String text) {
    return Center(
        child: Text(
      text,
    ));
  }

  _goPrevDate(BuildContext context) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => DetailDisplayScreen(
                  date: prevDate.toString(),
                )));
  }

  _goNextDate(BuildContext context) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => DetailDisplayScreen(
                  date: nextDate.toString(),
                )));
  }

  _goSpendDisplayScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SpendDisplayScreen(date: selecedDate)));
  }

  Future<Widget> _showUnderMenu() {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.trending_up),
              title: Text('Score'),
              onTap: () => _goScoreDisplayScreen(),
            ),

            ListTile(
              leading: Icon(Icons.compare),
              title: Text('Sameday'),
              onTap: () => _goSamedayDisplayScreen(),
            ),
            ListTile(
              leading: Icon(Icons.featured_play_list),
              title: Text('Monthly'),
              onTap: () => _goMonthlyDisplayScreen(),
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Koumoku'),
              onTap: () => _goKoumokuDisplayScreen(),
            ),

            ListTile(
              leading: Icon(Icons.business),
              title: Text('Bank'),
              onTap: () => _goBankDisplayScreen(),
            ),

//            ListTile(
//              leading: Icon(Icons.input),
//              title: Text('Oneday Input'),
//              onTap: () => _goOnedayInputScreen(),
//            ),
          ],
        );
      },
    );
  }

  _goSamedayDisplayScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SamedayDisplayScreen(date: selecedDate),
      ),
    );
  }

  _goMonthlyDisplayScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MonthlyDisplayScreen(date: selecedDate),
      ),
    );
  }

  _goKoumokuDisplayScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => KoumokuDisplayScreen(date: selecedDate),
      ),
    );
  }

  _goOnedayInputScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OnedayInputScreen(
                  date: selecedDate,
                )));
  }

  _goScoreDisplayScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScoreDisplayScreen(),
      ),
    );
  }

  _goBankDisplayScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BankDisplayScreen(
          bank: 'bank_a',
        ),
      ),
    );
  }

  Widget _getMonthSpendWidget() {
    return Container();
  }
}
