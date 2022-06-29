import 'dart:async';
import 'dart:io';

import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/add-card.dart';
import 'package:connevents/models/purchase-api.dart';
import 'package:connevents/pages/addCard/addCardPage.dart';
import 'package:connevents/pages/orderConfirmation/orderConfirmationPage.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:pay/pay.dart';

class PaymentCardsPage extends StatefulWidget {
 final String? planType;
  const PaymentCardsPage({Key? key,this.planType}) : super(key: key);

  @override
  State<PaymentCardsPage> createState() => _PaymentCardsPageState();
}

class _PaymentCardsPageState extends State<PaymentCardsPage> {

   CardDetails cardDetails=CardDetails();
    final InAppPurchase _connection = InAppPurchase.instance;
    bool  available=true;
    bool  isGooglePaySelected=false;
    bool  isCard=false;
    StreamSubscription?  subscription;
    final String myProductId= "monthlySubscription";
    bool isPurchased=false;

  final paymentItems=<PaymentItem>[];
  String cardNumber='';
  String stripeToken='';
  List<CardDetails> userCardDetail=[];

  get onGooglePayResult => null;
  Future getUserCards() async{

    try {
      var response = await DioService.post('get_card_details', {
        "userId": AppData().userdetail!.users_id
      });

      if (response['status'] == "success") {
        var card = response['data'] as List;
        userCardDetail = card.map<CardDetails>((e) => CardDetails.fromJson(e)).toList();
        setState(() {});
        print(userCardDetail.toList());
        Navigator.of(context).pop();
      }
      else if (response['status'] == 'error') {
        Navigator.of(context).pop();
       // showErrorToast(response['message']);
      }
    }
    catch(e){
      Navigator.of(context).pop();
      //showErrorToast(e.toString());
    }
  }

  void buyProduct(ProductDetails product){
     final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);
    _connection.buyNonConsumable(purchaseParam: purchaseParam);
  }



 @override
  void initState() {
    super.initState();
   paymentItems.add(PaymentItem(amount: '200',label: "One Time Post",status: PaymentItemStatus.final_price));
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      openLoadingDialog(context, "loading...");
      getUserCards();
    });

 }

  @override
  Widget build(BuildContext context) {
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
              child: Icon(Icons.arrow_back, color: Colors.white),
            ),
            SizedBox(width: padding),
            Text('Add Payment Method', style: TextStyle(color: Colors.white, fontSize: 18)),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(color: Colors.black),
          padding: EdgeInsets.only(right: padding * 2, left: padding * 2, bottom: padding),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                child: Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: userCardDetail.length,
                      itemBuilder: (context,index){
                      var  userCard =userCardDetail[index];
                      return InkWell(
                        onTap: (){
                          isGooglePaySelected=false;
                          isCard=true;
                          cardNumber=userCard.cardNumber;
                          stripeToken=userCard.token!;
                          print(stripeToken);
                          setState(() {});
                        },
                        child: Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color:cardNumber==userCard.cardNumber && isCard ? globalGreen : globalGolden
                            ),
                            borderRadius: BorderRadius.circular(16),
                            color: globalGolden,
                          ),
                          padding: EdgeInsets.all(padding * 1.5),
                          margin: EdgeInsets.symmetric(vertical: padding / 2),
                          child: Column(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: SvgPicture.asset('assets/icons/masterCard.svg',width: 48,
                                  ),
                                ),
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(userCard.cardNumber, style: TextStyle(color: globalBlack, fontSize: 16, fontWeight: FontWeight.w600)),
                                    SizedBox(height: padding),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text('Card Holder', style: TextStyle(color: globalBlack.withOpacity(0.5), fontSize: 12, fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text('Expires', style: TextStyle(color: globalBlack.withOpacity(0.5), fontSize: 12, fontWeight: FontWeight.w600,)),)
                                      ],
                                    ),
                                    SizedBox(height: padding / 2),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(userCard.cardHolderName, style: TextStyle(color: globalBlack, fontSize: 16, fontWeight: FontWeight.w600)),
                                        ),
                                        Expanded(
                                          child: Text("${userCard.expiryMonths}/${userCard.expiryYears}", style: TextStyle(color: globalBlack, fontSize: 16, fontWeight: FontWeight.w600)),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                        }),
                    GestureDetector(
                      onTap: () {
                        CustomNavigator.navigateTo(context, AddCardPage());
                        // Navigator.pushNamed(context, '/addCard');
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: padding / 2),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                          color: globalBlack,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.add, color: Colors.white),
                            SizedBox(height: padding / 2),
                            Text('Add Card', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                      SizedBox(height:15),

                        if(Platform.isAndroid)
                          Container(
                            height: 57,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border:isGooglePaySelected ? Border.all(
                                    width: 2,
                                    color: globalGreen
                                ): Border.all()
                            ),
                            child: ListTile(
                              leading:  SvgPicture.asset('assets/google-pay-mark.svg',width: 50,height: 50,),
                              title: Text('Google Pay'),
                            )



                            // ElevatedButton.icon(
                            //     style: ElevatedButton.styleFrom(
                            //         primary: Colors.white,
                            //         textStyle: TextStyle(
                            //           fontSize: 20,
                            //         )),
                            //     onPressed: (){
                            //       isGooglePaySelected=true;
                            //       isCard=false;
                            //       setState(() {});
                            //       //StripeService.handleNativePayment(context, '50');
                            //     },
                            //     icon: SvgPicture.asset('assets/google-pay-mark.svg'),
                            //     label: Text('Google Pay',style: TextStyle(color:Colors.black),)),
                          ),
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
                                      primary: Colors.white,
                                      textStyle: TextStyle(
                                        fontSize: 20,
                                      )),
                                  onPressed: (){
                                    isGooglePaySelected=true;
                                    isCard=false;
                                    setState(() {});
                                    //StripeService.handleNativePayment(context, '50');
                                  },
                                  icon: SvgPicture.asset('assets/apple.svg',width: 30,height: 30),
                                  label: Text('Apple Pay',style: TextStyle(color:Colors.black),)),
                            )

                      ],
                    ),
                  ),
                ),
              ),
              // ElevatedButton.icon(
              //   onPressed:(){
              //   buyProduct(PurchaseApi.products.first);
              // }, icon: Icon(Icons.golf_course), label: Text("InApp Purchase")),


              SizedBox(height: padding),
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
                  child: Text('Continue'.toUpperCase(), style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold,)),
                  onPressed: () {
                    if(!isCard && !isGooglePaySelected) return showErrorToast('You have to select atleast one payment method');


                    CustomNavigator.navigateTo(context, OrderConfirmationPage(
                      isCard: isCard? true : false,
                      planType: widget.planType,
                      cardId: cardNumber,
                      stripeToken: stripeToken,
                    ));
                    // Navigator.pushNamed(context, '/orderConfirmation');
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }




}
