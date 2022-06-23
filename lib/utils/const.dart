import 'package:connevents/variables/globalVariables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiUrl = 'https://connevents.com/app/api/';
const apiKey = 'AIzaSyDgU-FmmQj01yc5PZlX4ENRTouhX7CY-RI';
const spinKit =Center(
  child: SpinKitFadingCircle(color: globalGreen , size: 50.0)
);

const appId = "ff6f3b43c26441df8457f3645afd465a";
//const token = "006ff6f3b43c26441df8457f3645afd465aIAAQfdrDOTHpu+Sh2sE82UhElvHeOWR9LfXw+qvTcdxgqPC/154AAAAAIgD6A1gYhufwYQQAAQCF5/BhAgCF5/BhAwCF5/BhBACF5/Bh";

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return this.year == other.year && this.month == other.month
           && this.day == other.day;
  }
}


class TextConstants {
  static final headingStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
}



