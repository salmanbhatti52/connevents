import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

final baseUrl="https://dev.eigix.com/connevents/api/Webservices/";
Widget container(Widget textField)

{
  return    Padding(
    padding: const EdgeInsets.all(4.0),
    child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              //  color:Colors.white
              BoxShadow(
                color:Colors.white,
                offset: Offset(0,0),
                blurRadius: 300,
                //   spreadRadius: 2
              )]
        ),
        child: textField
    ),
  );

}


openLoadingDialog(BuildContext context, String text) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            width: 120,
            height: 50,
            //padding: EdgeInsets.only(left:20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 1,valueColor: AlwaysStoppedAnimation(Colors.black))),
                  SizedBox(width: 15),
                  Text('loading',style:TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 14,decoration: TextDecoration.none),)
                ]),
          ),
        );
      }
  );
}


// openLoadingDialog(BuildContext context, String text) {
//   showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) {
//         return Center(
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10),
//               ),
//               width: MediaQuery.of(context).size.width/2,
//               height: 63,
//               padding: EdgeInsets.only(left:20),
//             child: Row(
//                 children: <Widget>[
//               SizedBox(
//                   height: 20,
//                   width: 20,
//                   child: CircularProgressIndicator(strokeWidth: 1, valueColor: AlwaysStoppedAnimation(Colors.black))),
//               SizedBox(width: 10),
//               Text(text,style: TextStyle(color: Colors.black54,fontSize: 14,decoration: TextDecoration.none,fontWeight: FontWeight.normal),)
//             ]),
//           ),
//         );
//
//
//
//
//   }
//   );
// }


openLoadingDialogProgressBar(BuildContext context, String text, double progress) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              ),
              width: MediaQuery.of(context).size.width/2,
              height: 63,
              padding: EdgeInsets.only(left:20),
            child: Center(
              child: Row(
                  children: <Widget>[
                SizedBox(
                    height: 20,
                    width: 20,
                    child: LinearProgressIndicator(value: progress, semanticsLabel: text)),
                SizedBox(width: 10),
               // Text(text,style: TextStyle(color: Colors.black54,fontSize: 14,decoration: TextDecoration.none,fontWeight: FontWeight.normal),)
              ]),
            ),
          ),
        );




  }
  );
}



openMessageDialog(BuildContext context, String text) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        content: Column(
          children: <Widget>[
            Text(text),
            Align(
              alignment: Alignment.topRight,
              child: MaterialButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.pop(context);
                },
                minWidth: 0,
              ),
            ),
          ],
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
        ),
      ));
}

showSuccessToast(String message){
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black87,
      textColor: Colors.white,timeInSecForIosWeb: 3);
}


showErrorToast(String message){
  Fluttertoast.showToast(msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black87,
      textColor: Colors.white,timeInSecForIosWeb: 4);
}

