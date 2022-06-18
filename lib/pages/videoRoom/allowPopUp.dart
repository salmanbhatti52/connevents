import 'package:connevents/variables/globalVariables.dart';
import 'package:flutter/material.dart';

class RaiseHandAlert extends StatelessWidget {
  Widget Buttons(text, color) {
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
      onPressed: () {},
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
              Text(
                "Are you sure you want to allow",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
              ),
              Text(
                "USERNAME to join the host room?",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Buttons("DECLINE", Colors.red),
                    SizedBox(width: 10),
                    Buttons("ACCEPT", globalGreen),
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
  //           children: [
  //             SizedBox(
  //               height: 60,
  //             ),
  //             Text(
  //               "Are you sure you want to allow",
  //               style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Text(
  //                   "username",
  //                   style: TextStyle(
  //                       color: globalGreen,
  //                       fontWeight: FontWeight.w300,
  //                       fontSize: 18),
  //                 ),
  //                 Text(' '),
  //                 Text(
  //                   "to join the host room?",
  //                   style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
  //                 ),
  //               ],
  //             ),
  //             SizedBox(
  //               height: 20,
  //             ),
  //             Center(
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Buttons("DECLINE", Colors.red),
  //                   SizedBox(
  //                     width: 10,
  //                   ),
  //                   Buttons("ACCEPT", globalGreen),
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
