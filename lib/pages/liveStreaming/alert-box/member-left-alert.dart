import 'package:connevents/models/create-event-model.dart';
import 'package:connevents/pages/tabs/tabsPage.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:flutter/material.dart';

class MemberLeftAlert extends StatefulWidget {
 final EventDetail?  event;
  MemberLeftAlert({this.event});


  @override
  State<MemberLeftAlert> createState() => _MemberLeftAlertState();
}

class _MemberLeftAlertState extends State<MemberLeftAlert> {

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


   Widget yesButton(text, color) {
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
      onPressed: ()async{
       CustomNavigator.pushReplacement(context, TabsPage(index: 0));
      },
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0),
      ),
    );
  }


   Widget noButton(text, color) {
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
      onPressed: (){
        Navigator.of(context).pop();
      },
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0),
      ),
    );
  }



  contentBox(context, size) {
    return Container(
      height: 200,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 60),
              Text("The Host Meeting is Ended", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),),
              SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    yesButton("Ok", globalGreen),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
