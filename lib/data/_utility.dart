import 'package:intl/intl.dart';

class Utility {
  int year;
  int month;
  int day;
  String youbi;
  String youbiStr;
  int youbiNo;
  makeYMDYData(String date, int noneDay) {
    List explodedSelectedDate = date.split('-');
    year = int.parse(explodedSelectedDate[0]).toInt();
    month = int.parse(explodedSelectedDate[1]).toInt();

    if (noneDay == 1) {
      day = 1;
    } else {
      day = int.parse(explodedSelectedDate[2]).toInt();
    }

    DateTime youbiDate = DateTime(year, month, day);
    youbi = DateFormat('EEEE').format(youbiDate);
    switch (youbi) {
      case "Sunday":
        youbiStr = "日";
        youbiNo = 0;
        break;
      case "Monday":
        youbiStr = "月";
        youbiNo = 1;
        break;
      case "Tuesday":
        youbiStr = "火";
        youbiNo = 2;
        break;
      case "Wednesday":
        youbiStr = "水";
        youbiNo = 3;
        break;
      case "Thursday":
        youbiStr = "木";
        youbiNo = 4;
        break;
      case "Friday":
        youbiStr = "金";
        youbiNo = 5;
        break;
      case "Saturday":
        youbiStr = "土";
        youbiNo = 6;
        break;
    }
  }

  int trainDate = 0;
  checkTrainDate(date, trainDateDate) {
    for (int i = 0; i < trainDateDate.length; i++) {
      if (trainDateDate[i][0] == date) {
        trainDate = 1;
      }
    }
    return trainDate;
  }
}
