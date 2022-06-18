import 'package:connevents/variables/globalVariables.dart';
import 'package:flutter/material.dart';

class BookRoomPageAlerts extends StatelessWidget {
  String message="";
  BookRoomPageAlerts({required this.message});
  Widget Buttons(text, color,void Function() onTap) {
    // ignore: deprecated_member_use
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
      onPressed:onTap,
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
      child: contentBox(context, size,message),
    );
  }

  contentBox(context, size, message) {
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
              SizedBox(
                height: 60,
              ),
              Text(message, style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18)),
              SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Buttons("CANCEL", Colors.red),
                    SizedBox(width: 10),
                    Buttons("OK", globalGreen, (){
                       Navigator.of(context).pop();
                       Navigator.of(context).pop();

                    }),
                  ],
                ),
              )
            ],
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

  // contentBox(context, size) {
  //   return Container(
  //     height: 200,
  //     width: 300,
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(20),
  //     ),
  //     child: Stack(
  //       children: [
  //         Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             SizedBox(
  //               height: 60,
  //             ),
  //             Text(
  //               "Select ticket to Redeem",
  //               style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
  //             ),
  //             Text(
  //               " ConnCash Automatically",
  //               style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
  //             ),
  //             SizedBox(
  //               height: 20,
  //             ),
  //             Center(
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Buttons("YES", globalGreen),
  //                   SizedBox(
  //                     width: 10,
  //                   ),
  //                   //Buttons("NO", Colors.red),
  //                 ],
  //               ),
  //             )
  //           ],
  //         ),
  //         Positioned(
  //           top: 10,
  //           right: 10,
  //           child: GestureDetector(
  //             onTap: () {
  //               Navigator.pop(context);
  //             },
  //             child: Icon(
  //               Icons.close,
  //               size: 30,
  //               color: globalGreen,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
