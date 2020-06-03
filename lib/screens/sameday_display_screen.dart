import 'package:flutter/material.dart';
import 'package:kakeibo/data/sameday_data.dart';
import 'package:kakeibo/screens/sameday_item_display_screen.dart';

class SamedayDisplayScreen extends StatefulWidget {
  final String date;

  SamedayDisplayScreen({@required this.date});

  @override
  _SamedayDisplayScreenState createState() => _SamedayDisplayScreenState();
}

class _SamedayDisplayScreenState extends State<SamedayDisplayScreen> {
  String date;

  List<List<String>> samedayData = List();

  @override
  void initState() {
    super.initState();

    _getSamedayData();
  }

  _getSamedayData() async {
    date = widget.date;

    SamedayData instance = SamedayData(date: date);
    await instance.getData();

    samedayData = instance.samedayData;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    date = widget.date;

    List explodedDate = date.split('-');
    int year = int.parse(explodedDate[0]).toInt();
    int month = int.parse(explodedDate[1]).toInt();
    int day = int.parse(explodedDate[2]).toInt();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '同日比較：$day日',
          style: TextStyle(fontFamily: "Yomogi"),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: _samedayList(),
        ),
      ),
    );
  }

  Widget _samedayList() {
    return ListView.builder(
      itemCount: samedayData.length,
      itemBuilder: (context, int position) => _listItem(position),
    );
  }

  Widget _listItem(int position) {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: (samedayData[position][2] == '1')
          ? Colors.grey[900]
          : Color(0xFF2e2e2e),
      child: ListTile(
        title: Text(
          "${samedayData[position][0]}　${samedayData[position][1]}",
          style: TextStyle(color: Colors.white, fontFamily: 'Yomogi'),
        ),
        onTap: () => _goSpendItemDisplayScreen(samedayData[position][0]),
      ),
    );
  }

  _goSpendItemDisplayScreen(String listData) {
    List<String> explodedListData1 = (listData).split('　');
    List<String> explodedDate = (widget.date).split('-');
    String selectedDate =
        "${(explodedListData1[0]).replaceAll(' ', '')}-${explodedDate[2]}";

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                SamedayItemDisplayScreen(date: selectedDate)));
  }
}
