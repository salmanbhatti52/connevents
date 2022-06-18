import 'package:connevents/variables/globalVariables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DateCategory extends StatelessWidget {
  String date;
final void Function() onTap;
   DateCategory({Key? key,required this.onTap,this.date=""}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
      Text(date.isNotEmpty? date : 'Date', style: TextStyle(color: Colors.black, fontSize: 10,),),
      Padding(
        padding: const EdgeInsets.only(left:4.0),
        child:date.isEmpty ? SvgPicture.asset('assets/icons/downArrow.svg', color: globalGreen, width: 10,):
      GestureDetector(
        onTap:onTap,
         child: Container(
          height: 20,
          width:20,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: globalGreen,
            borderRadius: BorderRadius.circular(20)
          ),
          child: SvgPicture.asset('assets/icons/cross.svg', color: Colors.white, width: 10)))),
            ],
          );
  }
}
