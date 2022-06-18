

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateOnlyCompare on DateTime {
 bool isSameDate(DateTime other) {
  return this.year == other.year && this.month == other.month
      && this.day == other.day;
 }
}

 int daysBetween(DateTime from, DateTime to) {
     from = DateTime(from.year, from.month, from.day);
     to = DateTime(to.year, to.month, to.day);
   return (to.difference(from).inHours / 24).round();
  }

  int secondsBetween(DateTime from, DateTime to) {
  print(DateTime.now());
     from = DateTime(from.year, from.month, from.day,from.hour,from.minute,from.second);
     print(from);
     to = DateTime(to.year, to.month, to.day,to.hour,to.minute,to.second);
     print(to);
   return (to.difference(from).inSeconds);
  }



double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute/60.0;


TimeOfDay stringToTimeOfDay(String tod) {
  final format = DateFormat.jm(); //"6:00 AM"
  return TimeOfDay.fromDateTime(format.parse(tod));
}


