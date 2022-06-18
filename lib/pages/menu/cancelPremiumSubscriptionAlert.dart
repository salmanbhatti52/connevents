import 'package:connevents/mixins/data.dart';
import 'package:connevents/pages/tabs/tabsPage.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:flutter/material.dart';

class CancelPremiumSubscriptionAlert extends StatefulWidget {

  @override
  State<CancelPremiumSubscriptionAlert> createState() => _CancelPremiumSubscriptionAlertState();
}

class _CancelPremiumSubscriptionAlertState extends State<CancelPremiumSubscriptionAlert> {
  Future cancelSubscription() async {
    openLoadingDialog(context, 'cancelling');
    try{
      var response = await DioService.post('cancel_subscription', {"userId": AppData().userdetail!.users_id
      });
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      CustomNavigator.pushReplacement(context, TabsPage());
          showSuccessToast(response['data']);
    }
    catch(e){
      Navigator.of(context).pop();
      showSuccessToast(e.toString());
    }
  }

  Widget Buttons({text, color, void Function()? onTap}) {
    print(AppData().userdetail!.subscription_package_id);
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
              SizedBox(
                height: 60,
              ),
              Text("Are you sure you wants to", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 17)),
              Text("cancel your premium Subscription?", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 17)),
              SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Buttons(text: "NO",color:  Colors.red,onTap: ()=>Navigator.of(context).pop()),
                    SizedBox(
                      width: 10,
                    ),
                    Buttons(text: "PROCEED",color:  globalGreen,onTap: (){
                      cancelSubscription();
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
