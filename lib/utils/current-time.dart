import 'package:flutter/material.dart';

String currentTime(context) {
  final localizations = MaterialLocalizations.of(context);
   var formattedTimeOfDay = localizations.formatTimeOfDay(TimeOfDay.now());
  return formattedTimeOfDay;
}