import 'package:connevents/models/business-create-model.dart';
import 'package:connevents/models/create-event-model.dart';
import 'package:connevents/pages/tabs/tabsPage.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:flutter/material.dart';

class CancelEventAlert extends StatefulWidget {
 final EventDetail?  event;
  CancelEventAlert({this.event});


  @override
  State<CancelEventAlert> createState() => _CancelEventAlertState();
}

class _CancelEventAlertState extends State<CancelEventAlert> {

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
        openLoadingDialog(context, "Canceling");
        try {
          var res =await DioService.post('cancel_event_post', {
            "eventPostId": widget.event!.eventPostId
          });
          CustomNavigator.pushReplacement(context, TabsPage(index: 4));
          showSuccessToast(res['data']);
        }
        catch(e){
          showErrorToast(e.toString());
        }
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
              Text("Are you sure you want to", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),),
              Text("Cancel?", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),),
              SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    yesButton("YES", globalGreen),
                    SizedBox(width: 10),
                    noButton("NO", Colors.red),
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
}




class CancelBusinessAlert extends StatefulWidget {
  final Business?  business;
  CancelBusinessAlert({this.business});


  @override
  State<CancelBusinessAlert> createState() => _CancelBusinessAlertState();
}

class _CancelBusinessAlertState extends State<CancelBusinessAlert> {

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
        openLoadingDialog(context, "Canceling");
        try {
          var res =await DioService.post('delete_business', {
            "businessId": widget.business!.businessId
          });
          CustomNavigator.pushReplacement(context, TabsPage(index: 4));
          showSuccessToast(res['data']);
        }
        catch(e){
          showErrorToast(e.toString());
        }
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
              Text("Are you sure you want to", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),),
              Text("Cancel?", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),),
              SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    yesButton("YES", globalGreen),
                    SizedBox(width: 10),
                    noButton("NO", Colors.red),
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
}
