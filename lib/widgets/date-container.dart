 import 'package:connevents/variables/globalVariables.dart';
import 'package:flutter/material.dart';

Widget dateContainer(size, text, icon) {
    return Container(
      height: 40,
      width: size.width / 2.5,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: globalLGray,
            blurRadius: 3,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(icon, size: 12),
          Text(text, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300)),
          Icon(Icons.arrow_drop_down, size: 18),
        ],
      ),
    );
  }