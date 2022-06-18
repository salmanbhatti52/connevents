import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/bank-detail-model.dart';
import 'package:connevents/models/my-earning-model.dart';
import 'package:connevents/models/user-concash-model.dart';
import 'package:connevents/pages/wallet/Add-Bank-Account-Page.dart';
import 'package:connevents/paypal-Services/paypal-payment.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:connevents/widgets/earning-button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {

  TextEditingController stripeEmail=TextEditingController();
  UserConCashDetail? userConCashDetail;
  MyEarning myEarnings = MyEarning();

   void getUserConCash() async{
    try {
      var response = await DioService.post('get_organizer_earning', {
        "usersId": AppData().userdetail!.users_id
      });
      if (response['status'] == "success") {
        var  json = response['data'];
        myEarnings  = MyEarning.fromJson(json);
        print(myEarnings.toJson());

          setState(() {});
      }
      else if (response['status'] == 'error') {
        showErrorToast(response['message']);
      }
    }
    catch(e){
      //showErrorToast(e.toString());
    }
  }

  //  void withdrawEarning() async{
  //  openLoadingDialog(context, "loading");
  //   try {
  //     var response = await DioService.post('withdraw_earning', {
  //       "usersId": AppData().userdetail!.users_id,
  //       "earning" : myEarning,
  //       "stripeWithdrawEmail": stripeEmail.text
  //     });
  //     Navigator.of(context).pop();
  //     if (response['status'] == "success") {
  //         getUserConCash();
  //         showSuccessToast(response['data']);
  //     }
  //     else if (response['status'] == 'error') {
  //       showErrorToast(response['message']);
  //     }
  //   }
  //   catch(e){
  //     showErrorToast(e.toString());
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        getUserConCash();
         });
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: TextButton(
          onPressed: () => Navigator.pop(context),
          child: Row(
            children: [
              Icon(Icons.chevron_left, color: globalGreen),
              Text('Back', style: TextStyle(color: globalGreen, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left:padding * 2,right:padding * 2,bottom: padding * 2,top:20),
        decoration: BoxDecoration(color: globallightbg),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('My Earnings', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: globalBlack),),
                          SizedBox(height: padding / 2),
                          Container(
                            padding: EdgeInsets.all(padding / 2),
                            margin: EdgeInsets.symmetric(vertical: padding / 2),
                            height:myEarnings.pendingFlag ? 90 : 71,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: globalGreen,
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(color: globalLGray, blurRadius: 5),
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          SvgPicture.asset('assets/icons/money.svg', width: 53),
                                          SizedBox(width: padding),
                                          Text('Total Amount', style: TextStyle(color: globalBlack.withOpacity(0.8), fontSize: 16, fontWeight: FontWeight.bold,),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: padding),
                                    myEarnings.earning!=null ?
                                    Text('\$${myEarnings.earning}', style: TextStyle(color: globalGreen, fontSize: 18, fontWeight: FontWeight.w700,)):
                                        SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                                  ],
                                ),
                                if(myEarnings.pendingFlag)
                                Text("Pending Withdraw: \$${myEarnings.pendingWithdraw}",style: TextStyle(fontWeight: FontWeight.bold,color: globalGreen))
                              ],
                            ),
                          ),
                          SizedBox(height: padding),
                          EarningButton(image: 'paypal.svg',title: 'ADD PAYPAL',onPressed: ()async{
                            CustomNavigator.navigateTo(context, PayPalPayment(onFinish: (number)async{
                              print("order id"+ number);
                            },));
                          }),
                          SizedBox(height: padding),
                          EarningButtonPayoneer(image: 'payoneer.png',title: 'ADD PAYONEER',onPressed: (){}),
                          SizedBox(height: padding),
                          EarningButton(title: 'ADD BANK ACCOUNT ',subTitle: '(USA ONLY)',onPressed: () async {
                         bool   isWithDraw = await CustomNavigator.navigateTo(context, AddBankAccountPage(amount: myEarnings.earning));
                          if(isWithDraw)
                            getUserConCash();
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(padding),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    // if(myEarning! > 0 && stripeEmail.text.isNotEmpty)
                    //   {
                    //        bool validEmail   = isEmail(stripeEmail.text);
                    //        if(validEmail)  withdrawEarning();
                    //        else showErrorToast("Please Add Valid Email");
                    //   }
                    // else if(stripeEmail.text.isEmpty){
                    // showErrorToast("Please Input Stripe Email");
                    // }
                    // else {
                    //   showErrorToast("You don't have enough balance for withdraw");
                    // }
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: globalGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text('Withdraw'.toUpperCase(),
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }






}
