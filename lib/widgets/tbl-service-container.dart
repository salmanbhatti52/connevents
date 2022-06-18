import 'package:connevents/variables/globalVariables.dart';
import 'package:flutter/material.dart';

Widget tblServiceContainer(String text,String cost){
  return Container(
          padding: EdgeInsets.symmetric(vertical: padding / 2),
          child: Row(children: [
            Expanded(
              child: Row(
                children: [
                  Text(text, style: TextStyle(color: globalBlack, fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Text('\$$cost', style: TextStyle(color: globalGreen, fontSize: 14, fontWeight: FontWeight.bold,
              ),
            )
          ]),
        );
}