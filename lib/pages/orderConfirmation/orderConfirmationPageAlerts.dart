import 'package:connevents/pages/chosePlan/chosePlanPage.dart';
import 'package:connevents/pages/tabs/tabsPage.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:flutter/material.dart';

class PaymentSuccessAlert extends StatelessWidget {
 final String? message;
  PaymentSuccessAlert({this.message});
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
      height: 290,
      width: 300,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Stack(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Text("Payment Successful", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                Container(
                  height: 130,
                  width: 170,
                  child: FittedBox(
                      fit: BoxFit.cover,
                      child: Image.asset("assets/imgs/Done.png")),
                ),
                Text(this.message??"",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14)),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: (){
                      CustomNavigator.pushReplacement(context, TabsPage());

                    }, child: Text("Back To Home Page"))

              ],
            ),
          ),
          // Positioned(
          //   top: 10,
          //   right: 10,
          //   child: GestureDetector(
          //     onTap: () {
          //       Navigator.pop(context);
          //     },
          //     child: Icon(
          //       Icons.close,
          //       size: 30,
          //       color: globalGreen,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
