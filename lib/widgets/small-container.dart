
import 'package:connevents/variables/globalVariables.dart';
import 'package:flutter/material.dart';

Widget smallContainer(value, size) {
    return Container(
      width: size.width / 6,
      height: 20,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: globalLGray,
            blurRadius: 3,
          )
        ],
      ),
      child: Center(
        child: Text(
          value,
          style: TextStyle(fontSize: 12),
        ),
      ),
    );
  }
