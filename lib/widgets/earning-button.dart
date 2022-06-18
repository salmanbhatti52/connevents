import 'package:connevents/variables/globalVariables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'create-page-text.dart';

class EarningButton extends StatefulWidget {
  String title;
  String subTitle;
  String image;
  final void Function()?  onPressed;
   EarningButton({Key? key,this.subTitle="",this.onPressed,this.title="",this.image=""}) : super(key: key);

  @override
  _EarningButtonState createState() => _EarningButtonState();
}

class _EarningButtonState extends State<EarningButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
                width: double.infinity,
                height: 60,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.green),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: widget.onPressed! ,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/${widget.image}'),
                      SizedBox(width: 12),
                      RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold),
                            text: widget.title.toUpperCase(),
                            children: [
                              TextSpan(
                              style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w300),
                                text: "${widget.subTitle.toUpperCase()}",
                              )
                            ]
                          ))
                    ],
                  )
                ),
              ),
    );
  }
}








class EarningButtonPayoneer extends StatefulWidget {
  String title;
  String subTitle;
  String image;
  final void Function()?  onPressed;
   EarningButtonPayoneer({Key? key,this.subTitle="",this.onPressed,this.title="",this.image=""}) : super(key: key);

  @override
  _EarningButtonPayoneerState createState() => _EarningButtonPayoneerState();
}

class _EarningButtonPayoneerState extends State<EarningButtonPayoneer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
                width: double.infinity,
                height: 60,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.green),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: widget.onPressed! ,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/${widget.image}'),
                      SizedBox(width: 12),
                      RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold),
                            text: widget.title.toUpperCase(),
                            children: [
                              TextSpan(
                              style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w300),
                                text: "${widget.subTitle.toUpperCase()}",
                              )
                            ]
                          ))
                    ],
                  )
                ),
              ),
    );
  }
}