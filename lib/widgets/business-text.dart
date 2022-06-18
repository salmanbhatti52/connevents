import 'package:connevents/variables/globalVariables.dart';
import 'package:flutter/cupertino.dart';

import 'create-page-text.dart';

Widget businessText(String title) {
  return  Padding(
          padding: const EdgeInsets.symmetric(vertical: padding / 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              text(title:title,color: globalBlack, fontSize: 16,fontWeight: FontWeight.bold ),
            ],
          ),
        );
}