import 'package:connevents/variables/globalVariables.dart';
import 'package:flutter/material.dart';

class LessRewardMoneyAlert extends StatelessWidget {
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
      height: 280,
      width: 300,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 50),
                  Container(
                      height: 80,
                      width: 80,
                      child: FittedBox(
                          fit: BoxFit.cover,
                          child: Image.asset("assets/imgs/sad.png"))),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Reward Money is less than", style: TextStyle(fontSize: 18),),
                  Text("required amount!", style: TextStyle(fontSize: 18),),
                  SizedBox(height: 20,),
                  RaisedButton(
                    textColor: Colors.white,
                    color: globalGreen,
                    child: Text(
                      "Pay remaining using card",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                    ),
                    onPressed: () {},
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.close,
                size: 32,
                color: globalGreen,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//  SECOND ALERT

class PaymentSuccessfulAlert extends StatelessWidget {
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
      child: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 50),
                  Container(
                      height: 80,
                      width: 80,
                      child: FittedBox(
                          fit: BoxFit.cover,
                          child: Image.asset("assets/imgs/happy.png"))),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Payment Successful",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "You’ve completed your",
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  Text(
                    "payment successfully",
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton(
                    textColor: Colors.white,
                    color: globalGreen,
                    child: Padding(
                      padding:
                          const EdgeInsets.fromLTRB(30.0, 12.0, 30.0, 12.0),
                      child: Text(
                        "Show ticket",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w800),
                      ),
                    ),
                    onPressed: () {},
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.close,
                size: 30,
                color: globalGreen,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
