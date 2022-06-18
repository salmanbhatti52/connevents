import 'dart:ui';

import 'package:connevents/mixins/data.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/services/stripe-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/lazy_task.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:stripe_payment/stripe_payment.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({Key? key}) : super(key: key);

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {



  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    StripeService.init();
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
              child: Icon(Icons.arrow_back, color: Colors.white)),
            SizedBox(width: padding),
            Text('Add Card', style: TextStyle(color: Colors.white, fontSize: 18)),
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
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/stripe.png",scale: 7,),
                        CreditCardWidget(
                          cardBgColor: globalGolden,
                          cardNumber: cardNumber,
                          expiryDate: expiryDate,
                          cardHolderName: cardHolderName,
                          cvvCode: cvvCode,
                          showBackView: isCvvFocused,
                          isHolderNameVisible: true,
                          obscureCardNumber: true,
                          obscureCardCvv: true, onCreditCardWidgetChange: (CreditCardBrand ) {  },
                        ),
                        CreditCardForm(
                          formKey: formKey,
                          obscureCvv: true,
                          obscureNumber: true,
                          dateValidationMessage: "Expiry Date",
                          cvvValidationMessage: "CVV",
                          numberValidationMessage: "Card Number",
                          isHolderNameVisible: true,
                          textColor: globalGolden,
                          cardNumberDecoration:  InputDecoration(
                            labelStyle: TextStyle(color:globalGolden),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(width: 1,color: globalGolden),
                            ),
                            helperStyle: TextStyle(color:globalGolden),
                            hintStyle: TextStyle(color: globalGolden),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(width: 1,color: globalGolden),
                            ),
                            border: new OutlineInputBorder(),
                            labelText: "Card Number",
                            hintText: 'XXXX XXXX XXXX XXXX',
                          ),
                          expiryDateDecoration:  InputDecoration(
                            labelStyle: TextStyle(color:globalGolden),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(width: 1,color: globalGolden),
                            ),
                            helperStyle: TextStyle(color:globalGolden),
                            hintStyle: TextStyle(color: globalGolden),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(width: 1,color: globalGolden),
                            ),
                            border: OutlineInputBorder(),
                            labelText: "Expiry Date",
                            hintText: 'XX/XX',
                          ),
                          cvvCodeDecoration: const InputDecoration(
                            labelStyle: TextStyle(color:globalGolden),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(width: 1,color: globalGolden),
                            ),
                            helperStyle: TextStyle(color:globalGolden),
                            hintStyle: TextStyle(color: globalGolden),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(width: 1,color: globalGolden),
                            ),
                            border: OutlineInputBorder(),
                            labelText: 'Security Code',
                            hintText: 'XXX',
                          ),
                          cardHolderDecoration: InputDecoration(
                            labelStyle: TextStyle(color:globalGolden),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(width: 1,color: globalGolden),
                            ),
                            helperStyle: TextStyle(color:globalGolden),
                            hintStyle: TextStyle(color: globalGolden),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(width: 1,color: globalGolden),
                            ),
                            border: OutlineInputBorder(),
                            labelText: "Card Holder Name",
                          ),
                          onCreditCardModelChange: onCreditCardModelChange, cardHolderName: '', expiryDate: '', cvvCode: '', themeColor: Colors.grey, cardNumber: '',
                        ),
                      ],
                    ),


                    // Container(
                    //   width: double.infinity,
                    //   height: MediaQuery.of(context).size.width / 2,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(16),
                    //     color: globalGolden,
                    //   ),
                    //   padding: EdgeInsets.all(padding * 1.5),
                    //   margin: EdgeInsets.symmetric(vertical: padding / 2),
                    //   child: Column(
                    //     children: [
                    //       Expanded(
                    //         child: Align(
                    //           alignment: Alignment.topLeft,
                    //           child: SvgPicture.asset('assets/icons/masterCard.svg', width: 48)),
                    //       ),
                    //       Container(
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Text(
                    //               '1244 1234 1345 3255',
                    //               style: TextStyle(
                    //                 color: globalBlack,
                    //                 fontSize: 16,
                    //                 fontWeight: FontWeight.w600,
                    //               ),
                    //             ),
                    //             SizedBox(
                    //               height: padding,
                    //             ),
                    //             Row(
                    //               children: [
                    //                 Expanded(
                    //                   child: Text(
                    //                     'Card Holder',
                    //                     style: TextStyle(
                    //                       color: globalBlack.withOpacity(0.5),
                    //                       fontSize: 12,
                    //                       fontWeight: FontWeight.w600,
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 Expanded(
                    //                   child: Text(
                    //                     'Expires',
                    //                     style: TextStyle(
                    //                       color: globalBlack.withOpacity(0.5),
                    //                       fontSize: 12,
                    //                       fontWeight: FontWeight.w600,
                    //                     ),
                    //                   ),
                    //                 )
                    //               ],
                    //             ),
                    //             SizedBox(
                    //               height: padding / 2,
                    //             ),
                    //             Row(
                    //               children: [
                    //                 Expanded(
                    //                   child: Text(
                    //                     'Joseph',
                    //                     style: TextStyle(
                    //                       color: globalBlack,
                    //                       fontSize: 16,
                    //                       fontWeight: FontWeight.w600,
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 Expanded(
                    //                   child: Text(
                    //                     '08/23',
                    //                     style: TextStyle(
                    //                       color: globalBlack,
                    //                       fontSize: 16,
                    //                       fontWeight: FontWeight.w600,
                    //                     ),
                    //                   ),
                    //                 )
                    //               ],
                    //             )
                    //           ],
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // Container(
                    //   padding: EdgeInsets.symmetric(vertical: padding),
                    //   child: Column(
                    //     children: [
                    //       Container(
                    //         margin: EdgeInsets.only(top: padding),
                    //         child: Column(
                    //           children: [
                    //             Container(
                    //               child: Row(
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.start,
                    //                 children: [
                    //                   Container(
                    //                     child: SvgPicture.asset(
                    //                       'assets/icons/user.svg',
                    //                       width: 18,
                    //                       height: 18,
                    //                     ),
                    //                   ),
                    //                   SizedBox(
                    //                     width: padding,
                    //                   ),
                    //                   Expanded(
                    //                     child: Column(
                    //                       crossAxisAlignment:
                    //                           CrossAxisAlignment.start,
                    //                       children: [
                    //                         Text(
                    //                           'Card Holder',
                    //                           style: TextStyle(
                    //                             color: globalGolden,
                    //                             fontSize: 14,
                    //                             fontWeight: FontWeight.w700,
                    //                           ),
                    //                         ),
                    //                         TextField(
                    //                           style: TextStyle(
                    //                             color: globalLGray,
                    //                             fontSize: 14,
                    //                             fontWeight: FontWeight.w700,
                    //                           ),
                    //                           decoration: InputDecoration(
                    //                             hintText: 'Card Holder',
                    //                             hintStyle: TextStyle(
                    //                               color: globalLGray
                    //                                   .withOpacity(0.5),
                    //                               fontSize: 14,
                    //                               fontWeight: FontWeight.w700,
                    //                             ),
                    //                             enabledBorder:
                    //                                 UnderlineInputBorder(
                    //                               borderSide: BorderSide(
                    //                                 color: globalLGray,
                    //                               ),
                    //                             ),
                    //                           ),
                    //                         )
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       Container(
                    //         margin: EdgeInsets.only(top: padding),
                    //         child: Column(
                    //           children: [
                    //             Container(
                    //               child: Row(
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.start,
                    //                 children: [
                    //                   Container(
                    //                     child: SvgPicture.asset(
                    //                       'assets/icons/card.svg',
                    //                       width: 18,
                    //                       height: 18,
                    //                     ),
                    //                   ),
                    //                   SizedBox(
                    //                     width: padding,
                    //                   ),
                    //                   Expanded(
                    //                     child: Column(
                    //                       crossAxisAlignment:
                    //                           CrossAxisAlignment.start,
                    //                       children: [
                    //                         Text(
                    //                           'Account Number',
                    //                           style: TextStyle(
                    //                             color: globalGolden,
                    //                             fontSize: 14,
                    //                             fontWeight: FontWeight.w700,
                    //                           ),
                    //                         ),
                    //                         TextField(
                    //                           style: TextStyle(
                    //                             color: globalLGray,
                    //                             fontSize: 14,
                    //                             fontWeight: FontWeight.w700,
                    //                           ),
                    //                           decoration: InputDecoration(
                    //                             hintText: 'Account Number ',
                    //                             hintStyle: TextStyle(
                    //                               color: globalLGray
                    //                                   .withOpacity(0.5),
                    //                               fontSize: 14,
                    //                               fontWeight: FontWeight.w700,
                    //                             ),
                    //                             enabledBorder:
                    //                                 UnderlineInputBorder(
                    //                               borderSide: BorderSide(
                    //                                 color: globalLGray,
                    //                               ),
                    //                             ),
                    //                           ),
                    //                         )
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       Container(
                    //         margin: EdgeInsets.only(top: padding),
                    //         child: Column(
                    //           children: [
                    //             Container(
                    //               child: Row(
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.start,
                    //                 children: [
                    //                   Container(
                    //                     child: SvgPicture.asset(
                    //                       'assets/icons/date.svg',
                    //                       width: 18,
                    //                       height: 18,
                    //                     ),
                    //                   ),
                    //                   SizedBox(
                    //                     width: padding,
                    //                   ),
                    //                   Expanded(
                    //                     child: Column(
                    //                       crossAxisAlignment:
                    //                           CrossAxisAlignment.start,
                    //                       children: [
                    //                         Text(
                    //                           'Expiry Date',
                    //                           style: TextStyle(
                    //                             color: globalGolden,
                    //                             fontSize: 14,
                    //                             fontWeight: FontWeight.w700,
                    //                           ),
                    //                         ),
                    //                         TextField(
                    //                           style: TextStyle(
                    //                             color: globalLGray,
                    //                             fontSize: 14,
                    //                             fontWeight: FontWeight.w700,
                    //                           ),
                    //                           decoration: InputDecoration(
                    //                             hintText: 'Expiry Date',
                    //                             hintStyle: TextStyle(
                    //                               color: globalLGray
                    //                                   .withOpacity(0.5),
                    //                               fontSize: 14,
                    //                               fontWeight: FontWeight.w700,
                    //                             ),
                    //                             enabledBorder:
                    //                                 UnderlineInputBorder(
                    //                               borderSide: BorderSide(
                    //                                 color: globalLGray,
                    //                               ),
                    //                             ),
                    //                           ),
                    //                         )
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       Container(
                    //         margin: EdgeInsets.only(top: padding),
                    //         child: Column(
                    //           children: [
                    //             Container(
                    //               child: Row(
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.start,
                    //                 children: [
                    //                   Container(
                    //                     child: SvgPicture.asset(
                    //                       'assets/icons/cvc.svg',
                    //                       width: 18,
                    //                       height: 18,
                    //                     ),
                    //                   ),
                    //                   SizedBox(
                    //                     width: padding,
                    //                   ),
                    //                   Expanded(
                    //                     child: Column(
                    //                       crossAxisAlignment:
                    //                           CrossAxisAlignment.start,
                    //                       children: [
                    //                         Text(
                    //                           'CVC Code',
                    //                           style: TextStyle(
                    //                             color: globalGolden,
                    //                             fontSize: 14,
                    //                             fontWeight: FontWeight.w700,
                    //                           ),
                    //                         ),
                    //                         TextField(
                    //                           style: TextStyle(
                    //                             color: globalLGray,
                    //                             fontSize: 14,
                    //                             fontWeight: FontWeight.w700,
                    //                           ),
                    //                           decoration: InputDecoration(
                    //                             hintText: 'CVC Code',
                    //                             hintStyle: TextStyle(
                    //                               color: globalLGray
                    //                                   .withOpacity(0.5),
                    //                               fontSize: 14,
                    //                               fontWeight: FontWeight.w700,
                    //                             ),
                    //                             enabledBorder:
                    //                                 UnderlineInputBorder(
                    //                               borderSide: BorderSide(
                    //                                 color: globalLGray,
                    //                               ),
                    //                             ),
                    //                           ),
                    //                         )
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
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
                child: Text('ADD', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
                onPressed: () async{

                  if (formKey.currentState!.validate()) {
                     var  res ;
                     var token;
                    try {
                      await performLazyTask(context, () async {
                          token = (await StripePayment.createTokenWithCard(
                           CreditCard(
                        cvc: cvvCode,
                        number: cardNumber,
                        name: cardHolderName,
                        expMonth: int.tryParse(expiryDate.split('/').first),
                       expYear: int.tryParse(expiryDate.split('/').last),
                  ))).tokenId;
                      print(token);
                      if (token == null) return;
                      res = await DioService.post('store_card_details', {
                           "userId": AppData().userdetail!.users_id,
                            "cardNumber": cardNumber,
                              "cvv": cvvCode,
                              "cardHolderName": cardHolderName,
                              "expiryMonths": int.tryParse(expiryDate.split('/').first),
                              "expiryYears": int.tryParse(expiryDate.split('/').last),
                              'token': token
                                    });
                              });

                        if (res['status'] == 'success') {
                        showSuccessToast("Your Card has been Added Successfully");
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                       }
                          else if (res['status'] == "error") {
                          showErrorToast(res['message']);
                            }
                  print("shahzaib");
                  print(token);
                  }
                  catch(e){
                  Navigator.of(context).pop();
                  showErrorToast("Your Card NUmber is Incorrect");
                     }

                  } else {
                  print('invalid!');
                     }


                  // showDialog(
                  //     context: context,
                  //     builder: (BuildContext context) {
                  //       return CardVerifiedAlert();
                  //     });
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
