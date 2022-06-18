import 'package:connevents/variables/globalVariables.dart';
import 'package:flutter/material.dart';

import 'create-page-text.dart';

class ConneventButton extends StatefulWidget {
  String title;
  final void Function()?  onPressed;
   ConneventButton({Key? key,this.onPressed,this.title=""}) : super(key: key);

  @override
  _ConneventButtonState createState() => _ConneventButtonState();
}

class _ConneventButtonState extends State<ConneventButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
              width: double.infinity,
              height: 50,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: globalGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: widget.onPressed! ,
                child: text(title:widget.title.toUpperCase(), color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold )
              ),
            );
  }
}
