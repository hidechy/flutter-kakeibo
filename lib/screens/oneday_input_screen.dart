import 'package:flutter/material.dart';
import 'package:kakeibo/data/oneday_input_data.dart';

class OnedayInputScreen extends StatefulWidget {
  final String date;

  OnedayInputScreen({@required this.date});

  @override
  _OnedayInputScreenState createState() => _OnedayInputScreenState();
}

class _OnedayInputScreenState extends State<OnedayInputScreen> {
  TextEditingController _teCont10000 = TextEditingController();
  TextEditingController _teCont5000 = TextEditingController();
  TextEditingController _teCont2000 = TextEditingController();
  TextEditingController _teCont1000 = TextEditingController();
  TextEditingController _teCont500 = TextEditingController();
  TextEditingController _teCont100 = TextEditingController();
  TextEditingController _teCont50 = TextEditingController();
  TextEditingController _teCont10 = TextEditingController();
  TextEditingController _teCont5 = TextEditingController();
  TextEditingController _teCont1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.date}',
          style: TextStyle(fontFamily: "Yomogi"),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: 20.0,
              right: 40.0,
            ),
            child: DefaultTextStyle(
              style: TextStyle(fontSize: 16.0, fontFamily: "Yomogi"),
              child: Table(
                children: [
                  //-----------------------//
                  TableRow(children: [
                    _getDisplayYen('10000'),
                    _getTextField(_teCont10000),
                    _getDisplayYen('100'),
                    _getTextField(_teCont100),
                  ]),
                  //-----------------------//
                  //-----------------------//
                  TableRow(children: [
                    _getDisplayYen('5000'),
                    _getTextField(_teCont5000),
                    _getDisplayYen('50'),
                    _getTextField(_teCont50),
                  ]),
                  //-----------------------//
                  //-----------------------//
                  TableRow(children: [
                    _getDisplayYen('2000'),
                    _getTextField(_teCont2000),
                    _getDisplayYen('10'),
                    _getTextField(_teCont10),
                  ]),
                  //-----------------------//
                  //-----------------------//
                  TableRow(children: [
                    _getDisplayYen('1000'),
                    _getTextField(_teCont1000),
                    _getDisplayYen('5'),
                    _getTextField(_teCont5),
                  ]),
                  //-----------------------//
                  //-----------------------//
                  TableRow(children: [
                    _getDisplayYen('500'),
                    _getTextField(_teCont500),
                    _getDisplayYen('1'),
                    _getTextField(_teCont1),
                  ]),
                  //-----------------------//
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: IconButton(
              icon: Icon(Icons.send),
              color: Colors.blue,
              onPressed: () => _getYenInfo(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getDisplayYen(String yen) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20.0,
        left: 30.0,
      ),
      child: Text(
        yen,
      ),
    );
  }

  Widget _getTextField(TextEditingController con) {
    return TextField(
      keyboardType: TextInputType.number,
      style: TextStyle(fontSize: 30.0),
      controller: con,
    );
  }

  _getYenInfo() async {
    List<String> _yenCount = List();

    _yenCount.add(_teCont10000.text != "" ? _teCont10000.text : '0');
    _yenCount.add(_teCont5000.text != "" ? _teCont5000.text : '0');
    _yenCount.add(_teCont2000.text != "" ? _teCont2000.text : '0');
    _yenCount.add(_teCont1000.text != "" ? _teCont1000.text : '0');
    _yenCount.add(_teCont500.text != "" ? _teCont500.text : '0');
    _yenCount.add(_teCont100.text != "" ? _teCont100.text : '0');
    _yenCount.add(_teCont50.text != "" ? _teCont50.text : '0');
    _yenCount.add(_teCont10.text != "" ? _teCont10.text : '0');
    _yenCount.add(_teCont5.text != "" ? _teCont5.text : '0');
    _yenCount.add(_teCont1.text != "" ? _teCont1.text : '0');

    String sendText = widget.date + ":" + _yenCount.join('|');

    print(sendText);

//    OnedayInputData(data: sendText);

//    await Navigator.pop(context);
  }
}
