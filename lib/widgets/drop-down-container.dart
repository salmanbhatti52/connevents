 import 'package:connevents/variables/globalVariables.dart';
import 'package:flutter/material.dart';

Widget dropDownContainer({required Widget child}) {
    return Container(
      height: 60,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: globalLGray,
            blurRadius: 3,
          )
        ],
      ),
      child: child,
    );
  }