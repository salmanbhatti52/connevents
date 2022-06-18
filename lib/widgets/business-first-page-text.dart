import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/create-page-text.dart';
import 'package:flutter/material.dart';

Widget businessFirstPageText(String title){

  return  Padding(
          padding: const EdgeInsets.symmetric(vertical: padding / 1.2),
           child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              text(title:title,color: globalBlack, fontSize: 18,fontWeight: FontWeight.bold ),
              text(title:'*',color: Colors.red, fontSize: 18,fontWeight: FontWeight.bold ),
            ],
          ),
        );
}