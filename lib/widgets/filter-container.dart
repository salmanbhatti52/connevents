import 'package:connevents/variables/globalVariables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget filterContainer(Widget child){
  return  Container(
           width: 22,
           height: 22,
           margin: EdgeInsets.only(bottom: padding / 2),
           decoration: BoxDecoration(
             boxShadow: [
               BoxShadow(
                 color: globalLGray,
                 blurRadius: 3,
               )
             ],
             color: Colors.white,
           ),
           child: child
         );
}