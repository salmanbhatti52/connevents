import 'dart:io';
import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/add-card.dart';
import 'package:connevents/models/create-event-model.dart';
import 'package:connevents/models/transaction-detail-model.dart';
import 'package:connevents/models/user-concash-model.dart';
import 'package:connevents/pages/addCreditCard/addCreditCardPage.dart';
import 'package:connevents/pages/menu/menuPage.dart';
import 'package:connevents/pages/paymentConfirmation/paymentConfirmationPage.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/services/stripe-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/connevent-appbar.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:connevents/widgets/delete-card-alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pay/pay.dart';

class PaymentMethodsPage extends StatefulWidget {
  String regularController;
  bool fromMenu;
  String vipController;
  String earlyBirdController;
  String skippingLineController;
  double discountPercent;
  double amount;
  final  bool isTableFor10People;
  final  bool isTableFor4People;
  final bool isTableFor8People;
  final bool isTableFor6People;
  final bool isPay;
  final TransactionDetailModel? transactionDetailModel;
  final EventDetail?  event;
   PaymentMethodsPage({Key? key,this.amount=0, this.fromMenu=false,this.skippingLineController="",this.vipController="",this.discountPercent=0.0,this.regularController="",this.earlyBirdController="",this.isTableFor4People = false,this.isTableFor8People = false ,this.isTableFor6People=false,this.isTableFor10People=false,this.event, this.transactionDetailModel,required this.isPay}) : super(key: key);

  @override
  _PaymentMethodsPageState createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
 late TransactionDetailModel transactionDetailModel;
  List<CardDetails> userCardDetail=[];
  UserConCashDetail? userConCashDetail;

  bool isSelectedCard=false;
  String cardNumber='';
  String? cardId;
  String? stripeToken;
  bool isConnCashSelected=false;
  bool isGooglePaySelected=false;
  bool isSelected=false;
   final paymentItems=<PaymentItem>[];

  void getUserCards() async{
    try {
      var response = await DioService.post('get_card_details', {
        "userId": AppData().userdetail!.users_id
      });
      if (response['status'] == "success") {
        var card = response['data'] as List;
        if(this.mounted){
          userCardDetail = card.map<CardDetails>((e) => CardDetails.fromJson(e)).toList();
          setState(() {});
          print(userCardDetail.toList());
        }
        Navigator.of(context).pop();
      }
      else if (response['status'] == 'error') {
        Navigator.of(context).pop();
       // showErrorToast(response['message']);
      }
    }
    catch(e){
      Navigator.of(context).pop();
     // showErrorToast(e.toString());
    }
  }

  void getUserConCash() async{
    try {
      var response = await DioService.post('get_conncash_details', {
        "userId": AppData().userdetail!.users_id
      });
      if (response['status'] == "success") {
        var card = response['data'];
         userConCashDetail   =  UserConCashDetail.fromJson(card);
        setState(() {});
      }
      else if (response['status'] == 'error') {
        Navigator.of(context).pop();
       // showErrorToast(response['message']);
      }
    }
    catch(e){
     // Navigator.of(context).pop();
     // showErrorToast(e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
       super.initState();
        WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        openLoadingDialog(context, "loading...");
         getUserCards();
         getUserConCash();
         if(widget.isPay){
           transactionDetailModel=widget.transactionDetailModel!;
           paymentItems.add(PaymentItem(amount: transactionDetailModel.amount.toString(),label: "One Time Post",status: PaymentItemStatus.final_price));
         }
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
      backgroundColor: globallightbg,
      appBar: ConneventAppBar(),
      body: Container(
          padding: EdgeInsets.only(left:padding * 2,right: padding * 2,bottom: padding * 2,top:padding),
          decoration: BoxDecoration(color: globallightbg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Payment Method', style: TextStyle(color: globalBlack, fontWeight: FontWeight.bold, fontSize: 32,),),
                    SizedBox(height: padding),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Cards', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: globalBlack,),),
                          IconButton(
                            onPressed: () {
                            bool  isCardAdded  =CustomNavigator.navigateTo(context, AddCreditCardPage());
                               if(isCardAdded) getUserCards();
                            },
                            icon: Icon(Icons.add, color: globalBlack,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: padding),
                    if(userCardDetail.isNotEmpty)
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: userCardDetail.length,
                        itemBuilder: (context,index){
                          return  InkWell(
                            onTap: (){
                              setState(() {
                                isSelected=true;
                                cardNumber = userCardDetail[index].cardNumber;
                                cardId=userCardDetail[index].cardId.toString();
                                stripeToken=userCardDetail[index].token.toString();
                                isConnCashSelected=false;
                                isGooglePaySelected=false;

                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(padding / 2),
                              margin: EdgeInsets.symmetric(vertical: padding / 2),
                              height: 60,
                              decoration: BoxDecoration(
                                border:cardNumber==userCardDetail[index].cardNumber && !isConnCashSelected && !isGooglePaySelected ? Border.all(  color: Colors.green):Border.all(),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(color: globalLGray, blurRadius: 5),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        SvgPicture.asset('assets/icons/visa.svg', width: 53),
                                        SizedBox(width: padding),
                                        Text('${userCardDetail[index].cardNumber}', style: TextStyle(color: globalBlack.withOpacity(0.5), fontSize: 12)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: padding),
                                  TextButton(
                                    onPressed: () async{
                                      bool isDelete=false;
                                 await  showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return DeleteCardAlert(
                                              userCardDetail: userCardDetail[index],
                                              isDeleted: (isDeleted)=>setState(()=> isDelete=isDeleted),
                                            );
                                          });
                                         if(isDelete){
                                           print("sh");
                                          // getUserCards();
                                            userCardDetail.removeAt(index);
                                          // Navigator.of(context).pop();
                                         }
                                  },
                                    child: Text('Delete', style: TextStyle(color: globalGreen, fontSize: 12, fontWeight: FontWeight.w300,),),
                                  ),
                                ],
                                ),
                            ),
                          );
                        }),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: padding * 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Wallet', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: globalBlack,),),
                          SizedBox(height: padding / 2),
                          GestureDetector(
                                onTap: (){
                                  setState(() {
                                    isSelected=true;
                                    isConnCashSelected=true;
                                    isGooglePaySelected=false;

                                  });
                                },
                            child: Container(
                              padding: EdgeInsets.all(padding / 2),
                              margin: EdgeInsets.symmetric(vertical: padding / 2),
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border:isConnCashSelected && !isGooglePaySelected ? Border.all(color: globalGreen, width: 1): Border.all() ,
                                boxShadow: [
                                  BoxShadow(color: globalLGray, blurRadius: 5),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        SvgPicture.asset('assets/icons/money.svg', width: 53),
                                        SizedBox(width: padding),
                                        Text('ConnCash', style: TextStyle(color: globalBlack.withOpacity(0.8), fontSize: 16, fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: padding),
                                  userConCashDetail!=null ?
                                  Text('\$${userConCashDetail!=null ? userConCashDetail!.concashDollars!.toStringAsFixed(2) : 0}', style: TextStyle(color: globalGreen, fontSize: 18, fontWeight: FontWeight.w700,
                                    ),
                                   ):SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if(!widget.fromMenu)
                  if(Platform.isAndroid)
                  Container(
                    width: double.infinity,
                    height: 57,
                    decoration: BoxDecoration(
                      color:Colors.black,
                      borderRadius: BorderRadius.circular(5),
                      border:isGooglePaySelected ? Border.all(
                        width: 2,
                        color: globalGreen
                      ): Border.all()
                    ),
                    child: ListTile(
                      onTap: (){
                            isSelected=true;
                            isConnCashSelected=false;
                            isGooglePaySelected=true;
                            setState(() {});
                            },
                      contentPadding: EdgeInsets.zero,
                      horizontalTitleGap: 0,
                      leading:  SvgPicture.asset('assets/google-pay-mark.svg',width: 50,height: 50,),
                      title: Text('Google Pay',style: TextStyle(fontWeight: FontWeight.bold,color:Colors.white)),
                    ),
                  ),
                  if(!widget.fromMenu)
                  if(Platform.isIOS)
                  Container(
                      width: double.infinity,
                      height: 57,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border:isGooglePaySelected ? Border.all(
                              width: 2,
                              color: globalGreen
                          ): Border.all()
                      ),
                      child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                              textStyle: TextStyle(
                                  fontSize: 20,
                              )),
                          onPressed: (){
                            isSelected=true;
                            isConnCashSelected=false;
                            isGooglePaySelected=true;
                            setState(() {});
                            //StripeService.handleNativePayment(context, '50');
                          },
                          icon: SvgPicture.asset('assets/apple.svg',width: 30,height: 30),
                          label: Text('Apple Pay')),
                    )
                  //     if(Platform.isAndroid)
                  //   GooglePayButton(
                  //     paymentConfigurationAsset: 'gpay.json',
                  //     paymentItems: paymentItems,
                  //     style: GooglePayButtonStyle.black,
                  //     type: GooglePayButtonType.pay,
                  //     width: MediaQuery.of(context).size.width,
                  //     height: 60,
                  //     margin: const EdgeInsets.only(top: 15.0),
                  //     onPaymentResult: (value){
                  //       print(value);
                  //    }  ,
                  //     loadingIndicator: const Center(
                  //       child: CircularProgressIndicator(),
                  //     ),
                  // ),

                  ],
                ),
              ),
              widget.isPay     ?
              Container(
                padding: EdgeInsets.all(padding),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      if(!isSelected) return showErrorToast('You have to select one Payment Method');
                      if(isConnCashSelected && !isConnCashSelected) return showErrorToast("You have to select One Payment Method");
                      if(isConnCashSelected){
                        if(userConCashDetail!.concashDollars! < num.parse(transactionDetailModel.totalAmount!))  return showErrorToast("Your total amount is more than conncash. You have to use card For Payment");
                        transactionDetailModel.paymentType="Conncash";
                        print(transactionDetailModel.paymentType);
                      CustomNavigator.navigateTo(context, PaymentConfirmationPage(
                        amount:widget.amount,
                        discountPercent: widget.discountPercent,
                        earlyBirdController: widget.earlyBirdController,
                        regularController: widget.regularController,
                        vipController: widget.vipController,
                       //  isTableFor10People: widget.isTableFor10People,
                       //  isTableFor4People: widget.isTableFor4People,
                       // isTableFor6People: widget.isTableFor6People,
                       // isTableFor8People: widget.isTableFor8People,
                       transactionDetailModel: transactionDetailModel,
                        skippingLineController: widget.skippingLineController,
                        event: widget.event!,
                      ));
                       }
                      else if(isGooglePaySelected){
                        transactionDetailModel.paymentType="Google";
                        CustomNavigator.navigateTo(context, PaymentConfirmationPage(
                          amount:widget.amount,
                          discountPercent: widget.discountPercent,
                          earlyBirdController: widget.earlyBirdController,
                          regularController: widget.regularController,
                          vipController: widget.vipController,
                          skippingLineController: widget.skippingLineController,
                          // isTableFor10People: widget.isTableFor10People,
                          // isTableFor4People: widget.isTableFor4People,
                          // isTableFor6People: widget.isTableFor6People,
                          // isTableFor8People: widget.isTableFor8People,
                          transactionDetailModel: transactionDetailModel,
                          event: widget.event!,
                        ));

                      }
                      else{
                        transactionDetailModel.paymentType="Card";
                        transactionDetailModel.cardId=cardId;
                        transactionDetailModel.stripeToken=stripeToken;
                        CustomNavigator.navigateTo(context, PaymentConfirmationPage(
                             amount:widget.amount,
                             discountPercent: widget.discountPercent,
                             earlyBirdController: widget.earlyBirdController,
                              regularController: widget.regularController,
                              vipController: widget.vipController,
                            skippingLineController: widget.skippingLineController,
                             // isTableFor10People: widget.isTableFor10People,
                             // isTableFor4People: widget.isTableFor4People,
                             // isTableFor6People: widget.isTableFor6People,
                             // isTableFor8People: widget.isTableFor8People,
                             transactionDetailModel: transactionDetailModel,
                             event: widget.event!,
                      ));

                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: globalGreen,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
                    ),
                    child: Text('Pay Now'.toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ) :
              Container(
                padding: EdgeInsets.all(padding),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      CustomNavigator.navigateTo(context, MenuPage());
                      // Navigator.pushNamed(context, '/menu');
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: globalGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text('Close'.toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold,
                      ),
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
