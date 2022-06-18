import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/create-event-model.dart';
import 'package:connevents/models/event-guest-list-model.dart';
import 'package:connevents/models/purchased-ticket.dart';
import 'package:connevents/pages/tabs/tabsPage.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:flutter/material.dart';

class RequestRefundAlert extends StatefulWidget {
  final EventGuestList? eventGuest;
   final PurchasedTicket? purchasedData;
   final EventDetail? event;
   final String? totalAmount;
   final  List<int>?  listOfIds;
   RequestRefundAlert({this.totalAmount,this.eventGuest,this.listOfIds,this.event,this.purchasedData});


  @override
  State<RequestRefundAlert> createState() => _RequestRefundAlertState();
}

class _RequestRefundAlertState extends State<RequestRefundAlert> {
  Widget Buttons(text, color,void  Function()? onTap) {
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
                "Are you sure you want to",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
              ),
              Text("request a refund?", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18)),
              SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Buttons("CANCEL", Colors.red,(){
                      Navigator.of(context).pop();
                    }),
                    SizedBox(width: 10),
                    Buttons("CONTINUE", globalGreen,() async{
                   openLoadingDialog(context, "loading");
                   var response =await DioService.post('request_refund', {
                     'transactionId':widget.purchasedData?.data?.first.transactionId ?? widget.eventGuest!.transactionId,
                      "ticketBuyerId": AppData().userdetail!.users_id,
                      "eventPostId":widget.event?.eventPostId ?? widget.eventGuest!.eventPostId,
                      "totalAmount": widget.totalAmount ?? widget.eventGuest!.totalAmount,
                      "userTickets": widget.listOfIds ?? widget.eventGuest!.listOfId
                    });
                  //  Navigator.of(context).pop();
                    print(response);
                   if(response['status']=='success'){
                    Navigator.of(context).pop();
                    print(response);
                    showSuccessToast(response['data']);
                    CustomNavigator.pushReplacement(context, TabsPage());
                  }
                   else{
                //    CustomNavigator.pushReplacement(context, TabsPage());
                    Navigator.of(context).pop();
                    showErrorToast(response['message']);
                  }



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
}

//  SECOND ALERT

class CheckInAlert extends StatelessWidget {
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
                "Are you sure you want to",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
              ),
              Text(
                "check in?",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Buttons("YES", globalGreen),
                    SizedBox(
                      width: 10,
                    ),
                    Buttons("NO", Colors.red),
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
