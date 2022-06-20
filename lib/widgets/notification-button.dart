import 'package:connevents/variables/globalVariables.dart';
import 'package:flutter/material.dart';

Widget notificationButton(int badgeCount){

  return SizedBox(
        width: 15,
        height: 15,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: globalGolden,
            padding: EdgeInsets.zero,
          ),
          onPressed: () {},
          child: Text(badgeCount.toString(), style: TextStyle(color: Colors.white, fontSize: 8),
          ),
        ),
      );
}