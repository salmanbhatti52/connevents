import 'package:connevents/variables/globalVariables.dart';
import 'package:flutter/material.dart';

class CategoriesButton extends StatelessWidget {
 final Function()? onPressed;
 final Widget child;

   CategoriesButton({Key? key,this.onPressed,required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: globalLightButtonbg,
        padding: EdgeInsets.only(left:8,right: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        )),
        onPressed: onPressed,
        child: child);
  }
}
