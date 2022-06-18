import 'package:connevents/variables/globalVariables.dart';
import 'package:flutter/material.dart';

Widget imageContainer({child}){
    return  Container(
      alignment: Alignment.center,
      height: 160,
       width: double.infinity,
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