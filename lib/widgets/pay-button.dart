import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PayButton extends StatelessWidget {
  String image;
  String title;
  Color color;
  Color textColor;
  void Function() onTap;
   PayButton({Key? key,this.color=Colors.white,this.textColor=Colors.black,required this.image,required this.title,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,
      height: 57,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: EdgeInsets.zero,
        horizontalTitleGap: 0,
        leading:  SvgPicture.asset('assets/$image.svg',width: 50,height: 50,),
        title: Text(title,style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
