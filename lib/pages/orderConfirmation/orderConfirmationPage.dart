import 'package:connevents/mixins/data.dart';
import 'package:connevents/pages/orderConfirmation/orderConfirmationPageAlerts.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/services/stripe-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stripe_payment/stripe_payment.dart';

class OrderConfirmationPage extends StatefulWidget {
     String? planType;
     String? cardId;
     bool isCard;
     String stripeToken;
     OrderConfirmationPage({Key? key,this.planType,this.isCard=false,this.cardId,this.stripeToken=''}) : super(key: key);

  @override
  State<OrderConfirmationPage> createState() => _OrderConfirmationPageState();
}

class _OrderConfirmationPageState extends State<OrderConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    print(widget.planType);
    print(widget.cardId);
    print(widget.stripeToken);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            TextButton(
              onPressed: () =>Navigator.pop(context),
              child: Icon(Icons.arrow_back, color: Colors.white)),
            SizedBox(width: padding),
            Text('Order Confirmation', style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        padding: EdgeInsets.only(top: 120, right: padding * 2, left: padding * 2, bottom: padding),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Your Order:', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: padding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text( widget.planType=="premium" ?  'Premium Package' : "One Time Post Purchase", style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white.withOpacity(0.7))),
                        Text(widget.planType=="premium" ?  '\$100/mo' : '\$20/per', style: TextStyle(color: globalGreen, fontSize: 18, fontWeight: FontWeight.bold))
                      ],
                    ),
                    SizedBox(height: padding),
                    Container(
                      height: 54,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: padding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Amount:', style: TextStyle(color: globalBlack, fontSize: 16)),
                          Text(widget.planType=="premium" ? '\$ 100' :'\$ 20', style: TextStyle(color: globalGreen, fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: globalGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text('Proceed to confirm'.toUpperCase(), style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
                onPressed: () async{
                  var response;
                  if(widget.planType=="premium"){
                    if(widget.isCard){
                      openLoadingDialog(context, "loading");
                        response = await DioService.post('subscribe_to_premium', {
                        "userId": AppData().userdetail!.users_id,
                        "stripeToken": widget.stripeToken,
                        'paymentType':  'card'
                      });
                    } else{
                   Token token =   await StripeService.handleNativePayment(context, '0');
                     if(token!=null){
                       openLoadingDialog(context, "loading");
                       response = await DioService.post('subscribe_to_premium', {
                         "userId": AppData().userdetail!.users_id,
                         "stripeToken": widget.stripeToken,
                         'paymentType':  'Google'
                       });
                     }else
                       {
                         showErrorToast("Try Again After some");
                       }
                    }
                      Navigator.of(context).pop();
                    if(response['status']=='success'){
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return PaymentSuccessAlert(message:response['data']);
                        },
                      );
                    }else{
                      showErrorToast(response['status']);
                    }

                  }
                  else{
                    if(widget.isCard){
                      openLoadingDialog(context, "loading");
                      var response = await DioService.post('one_time_post_purchase', {
                        "userId": AppData().userdetail!.users_id,
                        "stripeToken": widget.stripeToken,
                        'paymentType':  'card'
                      });
                      AppData().userdetail!.one_time_post_count=response['one_time_post_count'];
                    }
                    else{
                      Token token =   await StripeService.handleNativePayment(context, '0');
                      if(token!=null){
                        openLoadingDialog(context, "loading");
                        var response = await DioService.post('one_time_post_purchase', {
                          "userId": AppData().userdetail!.users_id,
                          "stripeToken": widget.stripeToken,
                          'paymentType':  'Google'
                        });
                        AppData().userdetail!.one_time_post_count=response['one_time_post_count'];
                      }
                      else {
                        showErrorToast("Try Again After some");
                      }
                    }
                      Navigator.of(context).pop();

                     if(response['status']=='success'){
                       showDialog(
                         context: context,
                         barrierDismissible: false,
                         builder: (BuildContext context) {
                           return PaymentSuccessAlert(message:response['data']);
                         },
                       );
                     }else{
                       showErrorToast(response['status']);
                     }
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
