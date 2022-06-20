import 'package:connevents/variables/globalVariables.dart';
import 'package:flutter/material.dart';

class LiveStreamingScheduledAlert extends StatelessWidget {
  String? liveDate;
  String? liveTime;
  LiveStreamingScheduledAlert({this.liveDate,this.liveTime});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateTime _date = DateTime.now();
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
      height: 290,
      width: 300,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top:8.0,left:8.0),
                child: Icon(
                  Icons.close,
                  size: 30,
                  color: globalGreen,
                ),
              ),
            ),
          ),
            SizedBox(height: 20),
            Container(
              height: 80,
              width: 80,
              child: FittedBox(
                  fit: BoxFit.cover,
                  child: Image.asset("assets/imgs/happy.png"))),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text("Your Meeting Scheduled Time is $liveDate $liveTime", textAlign: TextAlign.center,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                ),

        ],
      ),
    );
  }
}