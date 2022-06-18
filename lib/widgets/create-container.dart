import 'package:connevents/variables/globalVariables.dart';
import 'package:flutter/material.dart';

class CreateContainer extends StatelessWidget {
   final  Widget child;
  const CreateContainer({Key? key,required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
       padding: EdgeInsets.all(padding * 2),
      decoration: BoxDecoration(
          color: globallightbg,
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
         child: child,
    );
  }
}
