import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stripe_payment/stripe_payment.dart';


class StripeTransactionResponse{
  String? message;
  bool? success;
  StripeTransactionResponse({ this.message,required this.success});
}


class StripeService {
  static String apiBase = 'https://api.stripe.com/v1';
  static String paymentApiUrl = '$apiBase/payment_intents';
  // Todo: Test
  static String secret = 'sk_test_51JY9vkEfkXLPApKvck7DWJIC8gMHRPWKu86ePWkEGC6BjPyBHV2hgOHFUjRGw7JoSoch1XotMgVvXmcyNkE4wpNT00qNlOaO6L';
  ///Live Key
  // static String secret = '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';
  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeService.secret}',
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  static init() {
    StripePayment.setOptions(
        StripeOptions(
          ///test key
           publishableKey: "pk_test_51JY9vkEfkXLPApKvmWeEhcJaeIU1V4OvKD57NNmb8FkMKDPQM0M7U2QFYOxcASsdHVfBMQSyZ8stEUaCHqGdjXmZ00869vn7PH",
           merchantId: "Test",
          androidPayMode: 'test'
          /// Live Key
          //   publishableKey: "pk_live_51JY9vkEfkXLPApKv59UQfzRQq9JJ4hopRBXg5NYpp61yYsRRezQSpH11G2vkImgBTcgXCWUgXX6HK3Cxt2ldjLwm00E4r6IsTX",
          //   merchantId: "acct_1JY9vkEfkXLPApKv",
          //   androidPayMode: 'production'
        ));
  }

  static Future<StripeTransactionResponse> payWithCard({required String amount, required String currency}) async {
    try {
      var paymentMethod = await StripePayment.paymentRequestWithCardForm(
          CardFormPaymentRequest(
          )
      );
      print(" Id Here");
      print(paymentMethod.id);
      print("Id Here");
      var   paymentIntent= await StripeService.createPaymentIntent(amount, currency);
      print("Secret Id Here");
      print(paymentIntent!['client_secret']);
      print("Secret Id Here");
      var response= await StripePayment.confirmPaymentIntent(
          PaymentIntent(
              clientSecret: paymentIntent['client_secret'],
              paymentMethodId:paymentMethod.id
          ));
      return StripeTransactionResponse(
          message: "Transaction Successful",
          success: true
      );
    }
    catch(e){
      return StripeTransactionResponse(
          message: "Transaction Failed ${e.toString()}",
          success: true
      );
    }
  }

  static Future<Map<String,dynamic>?> createPaymentIntent(String amount, String currency)async{

    try{
      Map<String,dynamic> body={
        'amount':amount,
        'currency':currency,
        'payment_method_types[]':'card'
      };
      var response =await http.post(Uri.parse(StripeService.paymentApiUrl),body: body,headers: StripeService.headers);
      return jsonDecode(response.body);
    }catch(e){
      print('err charring user ${e.toString()} ');
    }

    return null;

  }


 static Future<Token> handleNativePayment(BuildContext context, String amountInStr) async {

   Token token;
   // I used environment configurations for ANDROID_PAY_MODE, use "test" in test mode
   // and uses "production" in production mode

   // Live Key
   // StripePayment.setOptions(StripeOptions(
   //     publishableKey: "pk_live_51JY9vkEfkXLPApKv59UQfzRQq9JJ4hopRBXg5NYpp61yYsRRezQSpH11G2vkImgBTcgXCWUgXX6HK3Cxt2ldjLwm00E4r6IsTX",
   //     merchantId: "test",
   //     androidPayMode: 'test'
   //  ));
   //test key
   StripePayment.setOptions(StripeOptions(
      publishableKey: "pk_test_51JY9vkEfkXLPApKvmWeEhcJaeIU1V4OvKD57NNmb8FkMKDPQM0M7U2QFYOxcASsdHVfBMQSyZ8stEUaCHqGdjXmZ00869vn7PH",
      merchantId: "test",
     androidPayMode: 'test'
   ));

     token = await StripePayment.paymentRequestWithNativePay(
      androidPayOptions: AndroidPayPaymentRequest(
        totalPrice: amountInStr,
        currencyCode: 'USD',
      ),
      applePayOptions: ApplePayPaymentOptions(
        countryCode: 'USA',
        currencyCode: 'USD',
        items: [
          ApplePayItem(
            type: 'final',
            label: 'one time',
            amount: amountInStr,
          )
        ],
      ),
    );

   // await StripePayment.completeNativePayRequest();
   return token;
  }

  // _buildSnackBar(BuildContext context, String content, Color color) {
  //   final snackBar = SnackBar(
  //     content: Text(content),
  //     backgroundColor: color,
  //   );
  //   Scaffold.of(context).showSnackBar(snackBar);
  // }





}