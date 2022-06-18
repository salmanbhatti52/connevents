import 'dart:convert';

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
  static String secret = 'sk_test_51Jd7p8KKitfWkXX41zlXpUTZtirbsrmDo9NK16jhNb0xDWxwYHu9wI184X950hYpCDxePdERvoUvtC1GhE38nvgh004wfNZ1QK';
  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeService.secret}',
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  static init() {
    StripePayment.setOptions(
        StripeOptions(
        publishableKey: "pk_test_51Jd7p8KKitfWkXX45bQUGt47Aw7vsNTBrBufqCjci6Fm4VDy4f1RDnddDERJUNJqzPCwNfcyeTqkKPL4vAYI33WV00GepwDG5a",
            merchantId: "Test",
            androidPayMode: 'test'
        )
    );
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



}