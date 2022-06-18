import 'package:connevents/mixins/data.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:flutter/material.dart';

class RedeemAlert extends StatefulWidget {
  void Function(bool isRedeem)? isRedeemed;

  RedeemAlert({this.isRedeemed});
  @override
  State<RedeemAlert> createState() => _RedeemAlertState();
}

class _RedeemAlertState extends State<RedeemAlert> {
  Widget Buttons(text, color, void Function()? onTap) {
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
      onPressed: onTap,
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0),
      ),
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
          openLoadingDialog(context, "loading");
        try{
          var response = await DioService.post('redeem_conncash_points', {
            "usersId": AppData().userdetail!.users_id,
          });
         if(response['status']=='success'){
            widget.isRedeemed!(true);
           Navigator.of(context).pop();
           Navigator.of(context).pop();
          setState(() {});
      } else if(response['status']=='error'){
          Navigator.of(context).pop();
          showErrorToast(response['message']);
      }
    }
    catch(e){
      Navigator.of(context).pop();
    }


      },
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0),
      ),
    );
  }

   Widget noButton(text, color,) {
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
              SizedBox(height: 60,),
              Text("Are you sure you want to", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),),
              Text("Redeem?", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),),
              SizedBox(height: 20,),
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
              child: Icon(Icons.close, size: 30, color: globalGreen,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
