import 'package:flutter/material.dart';
import 'package:kakeibo/calender.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '俺の家計簿',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, fontFamily: "Yomogi"),
      home: Calender(),
    );
  }
}
