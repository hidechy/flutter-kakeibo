import 'package:flutter/material.dart';
import 'package:kakeibo/data/bank_data.dart';

class BankDisplayScreen extends StatefulWidget {
  final String bank;

  BankDisplayScreen({this.bank});

  @override
  _BankDisplayScreenState createState() => _BankDisplayScreenState();
}

class _BankDisplayScreenState extends State<BankDisplayScreen> {
  List<List<String>> bankData = List();

  @override
  void initState() {
    super.initState();

    _getBankData();
  }

  _getBankData() async {
    BankData instance = BankData(bank: widget.bank);
    await instance.getData();

    bankData = instance.bankData;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.bank),
      ),
      body: Column(
        children: <Widget>[
          /////////////////////////////////////////
          Table(
            children: [
              TableRow(children: [
                _flatButton('bank_a'),
                _flatButton('bank_b'),
                _flatButton('bank_c'),
                _flatButton('bank_d'),
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

          /////////////////////////////////////////
          Table(
            children: [
              TableRow(children: [
                _flatButton('pay_a'),
                _flatButton('pay_b'),
                Align(),
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

          Expanded(
            child: ListView.builder(
              itemCount: bankData.length,
              itemBuilder: (context, int position) => _listItem(position),
            ),
          ),
        ],
      ),
    );
  }

  Widget _flatButton(String _bank) {
    return FlatButton(
      child: Text(
        _bank,
        style: TextStyle(
            color: (widget.bank == _bank) ? Colors.grey : Colors.blue),
      ),
      onPressed: () => (widget.bank == _bank) ? null : _goRefreshScreen(_bank),
    );
  }

  Widget _listItem(int position) {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        leading: _getLeading(bankData[position][2]),
        title: Text('${bankData[position][0]}　${bankData[position][1]}'),
      ),
      color: Color(0xFF2e2e2e),
    );
  }

  Widget _getLeading(String mark) {
    if (int.parse(mark) == 1) {
      return Icon(
        Icons.refresh,
        color: Colors.greenAccent,
      );
    } else {
      return Icon(
        Icons.check_box_outline_blank,
        color: Color(0xFF2e2e2e),
      );
    }
  }

  _goRefreshScreen(String _bank) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => BankDisplayScreen(
          bank: _bank,
        ),
      ),
    );
  }
}
