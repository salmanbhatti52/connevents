import 'package:connevents/models/refund-request.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:flutter/material.dart';

class AcceptRefundAlert extends StatefulWidget {
 final RefundRequestList? refund;

AcceptRefundAlert({this.refund});


  @override
  State<AcceptRefundAlert> createState() => _AcceptRefundAlertState();
}

class _AcceptRefundAlertState extends State<AcceptRefundAlert> {

  Future acceptRefundRequest() async{
    openLoadingDialog(context, 'loading');
    try {
      var response = await DioService.post('accept_refund_request' , {
        "userId": widget.refund!.ticketBuyerId,
        "eventPostId": widget.refund!.eventPostId,
        "transactionId": widget.refund!.transactionId,
        "totalAmount": widget.refund!.totalAmount,
        "userTickets":widget.refund!.userTicket
      });
      if(response['status']=='success')
        {
          showSuccessToast(response['data']);
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        //  CustomNavigator.pushReplacement(context, TabsPage());
        }
      else if(response['status']=='error')
        {
          showSuccessToast(response['message']);
        }

    }
    catch(e){
  //    Navigator.of(context).pop();
      showErrorToast(e.toString());
    }
  }

  Widget Buttons(text, color,void Function() onTap) {
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
      onPressed: onTap,
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
              SizedBox(height: 60),
              Text("Are you sure you want to", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18)),
              Text("accept a refund?", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18)),
              SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Buttons("CANCEL", Colors.red,()=>Navigator.of(context).pop()),
                    SizedBox(width: 10),
                    Buttons("ACCEPT", globalGreen,(){
                      acceptRefundRequest();
                     // Navigator.of(context).pop();
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
              onTap: () =>Navigator.pop(context),
              child: Icon(Icons.close, size: 30, color: globalGreen),
            ),
          ),
        ],
      ),
    );
  }
}
