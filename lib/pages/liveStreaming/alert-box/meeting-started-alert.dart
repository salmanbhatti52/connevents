import 'package:connevents/variables/globalVariables.dart';
import 'package:flutter/material.dart';

class MeetingStartedAlert extends StatefulWidget {
  String message;

  MeetingStartedAlert({this.message=""});

  @override
  State<MeetingStartedAlert> createState() => _MeetingStartedAlertState();
}

class _MeetingStartedAlertState extends State<MeetingStartedAlert> {




  Widget yesButtons(text, color,void Function()? onPressed) {
    return RaisedButton(
      textColor: Colors.white,
      color: color,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
        child: Text(
          text,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
        ),
      ),
      onPressed:onPressed,
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0),
      ),
    );
  }

  Widget cancelButtons(text, color,void Function()? onPressed) {
    return RaisedButton(
      textColor: Colors.white,
      color: color,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
        child: Text(
          text,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
        ),
      ),
      onPressed: onPressed,
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      // elevation: 3,
      backgroundColor: Colors.transparent,
      child: contentBox(context, size),
    );
  }

  contentBox(context, size) {
    return Container(
      height: 110,
      width: 300,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child:   Padding(
        padding: const EdgeInsets.only(top:12.0,left:12.0,right: 12.0),
        child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                    Text("The Host is Offline . Please wait..", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                    SizedBox(height: 10),
                     yesButtons("OK", globalGreen,()async{
                            Navigator.of(context).pop();
                          }),
                  ],
            ),
      ),
    );
  }
}
