import 'package:connevents/utils/fonts.dart';
import 'package:flutter/cupertino.dart';

Widget noResultAvailableMessage(String message,context){
  return Container(
       height: MediaQuery.of(context).size.height/2,
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           Padding(
             padding: const EdgeInsets.only(top:50.0),
             child: Text(message,style: gilroyBoldRed,textAlign: TextAlign.center),
           ),
         ],
       ),
  );
}