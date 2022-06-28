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
        borderRadius: BorderRadius.circular(5),
      ),
      child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
              primary: color,
              textStyle: TextStyle(fontSize: 20)),
          onPressed: onTap,
          icon: SvgPicture.asset('assets/$image.svg',width: 30,height: 30),
          label: Text(title,style: TextStyle(color:textColor),)),
    );
  }
}
