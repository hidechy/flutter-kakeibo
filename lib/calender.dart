import 'package:flutter/material.dart';
import 'package:kakeibo/screens/detail_display_screen.dart';
import 'package:toast/toast.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;

class Calender extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CalenderState();
  }
}

class _CalenderState extends State<Calender> {
  DateTime _currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("俺の家計簿"),
          centerTitle: true,
        ),
        body: Container(
          child: CalendarCarousel<Event>(
            locale: 'JA',
            onDayPressed: onDayPressed,
            thisMonthDayBorderColor: Colors.grey,
            weekFormat: false,
            selectedDateTime: _currentDate,
            daysHaveCircularBorder: false,
            customGridViewPhysics: NeverScrollableScrollPhysics(),
            daysTextStyle: TextStyle(
                fontSize: 16.0, color: Colors.white, fontFamily: 'Yomogi'),
            todayTextStyle: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
              fontFamily: 'Yomogi',
            ),
            todayBorderColor: Colors.amber[600],
            todayButtonColor: Colors.amber[900],
            selectedDayBorderColor: Colors.blue[600],
            selectedDayButtonColor: Colors.blue[900],
            weekendTextStyle: TextStyle(
                fontSize: 16.0, color: Colors.red, fontFamily: 'Yomogi'),
            weekdayTextStyle: TextStyle(color: Colors.grey),
            dayButtonColor: Colors.grey[900],

            headerTextStyle: TextStyle(fontSize: 18.0, fontFamily: 'Yomogi'),
            selectedDayTextStyle: TextStyle(fontFamily: 'Yomogi'),
            prevDaysTextStyle: TextStyle(fontFamily: 'Yomogi'),
            nextDaysTextStyle: TextStyle(fontFamily: 'Yomogi'),

//markedDateCustomTextStyle: TextStyle(fontFamily: 'Yomogi'),
//markedDateMoreCustomTextStyle: TextStyle(fontFamily: 'Yomogi'),

//inactiveDaysTextStyle: TextStyle(fontFamily: 'Yomogi'),
//inactiveWeekendTextStyle: TextStyle(fontFamily: 'Yomogi'),
          ),
        ));
  }

  void onDayPressed(DateTime date, List<Event> events) {
    this.setState(() => _currentDate = date);
    //Toast.show(date.toString(), context, duration: Toast.LENGTH_LONG);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailDisplayScreen(
                  date: date.toString(),
                )));
  }
}
