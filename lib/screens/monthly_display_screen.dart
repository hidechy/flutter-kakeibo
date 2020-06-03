import 'package:flutter/material.dart';
import 'package:kakeibo/data/monthly_data.dart';
import 'package:kakeibo/screens/monthly_item_display_screen.dart';

class MonthlyDisplayScreen extends StatefulWidget {
  final String date;

  MonthlyDisplayScreen({@required this.date});

  @override
  _MonthlyDisplayScreenState createState() => _MonthlyDisplayScreenState();
}

class _MonthlyDisplayScreenState extends State<MonthlyDisplayScreen> {
  String date;

  List<List<String>> monthlyData = List();

  @override
  void initState() {
    super.initState();

    _getSamedayData();
  }

  _getSamedayData() async {
    date = widget.date;

    MonthlyData instance = MonthlyData(date: date);
    await instance.getData();

    monthlyData = instance.monthlyData;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '各月比較（日別）',
          style: TextStyle(fontFamily: "Yomogi"),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: _monthlyList(),
        ),
      ),
    );
  }

  Widget _monthlyList() {
    return ListView.builder(
      itemCount: monthlyData.length,
      itemBuilder: (context, int position) => _listItem(position),
    );
  }

  Widget _listItem(int position) {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: (monthlyData[position][2] == '1')
          ? Colors.grey[900]
          : Color(0xFF2e2e2e),
      child: ListTile(
        title: Text(
          "${monthlyData[position][0]}　${monthlyData[position][1]}",
          style: TextStyle(color: Colors.white, fontFamily: 'Yomogi'),
        ),
        onTap: () => _goMonthlyItemDisplayScreen(monthlyData[position][0]),
      ),
    );
  }

  _goMonthlyItemDisplayScreen(String monthlyData) {
    List<String> explodedListData = (monthlyData).split('　');
    String selectedDate = explodedListData[0].replaceAll(' ', '');

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                MonthlyItemDisplayScreen(date: selectedDate)));
  }
}
