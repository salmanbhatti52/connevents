import 'package:connevents/mixins/data.dart';
import 'package:connevents/paypal-Services/payPal-services.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class PayPalPayment extends StatefulWidget {
  final Function onFinish;


  const PayPalPayment({Key? key,required this.onFinish}) : super(key: key);

  @override
  State<PayPalPayment> createState() => _PayPalPaymentState();
}

class _PayPalPaymentState extends State<PayPalPayment> {
  GlobalKey<ScaffoldState> _scaffoldKey=  GlobalKey<ScaffoldState>();
  
  PayPalServices services= PayPalServices();
  var checkOutUrl='';   // this is approval Url
  var executeUrl='';
  var accessToken;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("i am here");
    Future.delayed(Duration.zero,()async{
      try{
        accessToken= await services.getAccessToken();
        print("hello Access Token");
        print(accessToken);
        print("hello Access Token");

        final transactions= getOrderParams();
        print("hello Transcation");
         print(transactions);
        print("hello Transcation");

        final res = await services.createPayPalPayment(transactions, accessToken);
         print("i am here");
         print(res);
        print("i am here");
         if(res!=null){
           setState(() {
             checkOutUrl=res['approvalUrl']!;
             executeUrl=res['executeUrl']!;

           });
         }

      }
      catch(e){
        print('exception:' + e.toString());
      }
    });
  }


  String returnUrl='https://example.com/return';
  String cancelUrl='https://example.com/cancel';


  Map<dynamic,dynamic> defaultCurrency ={
    "Symbol": "USD",
    "decimalDigints": 2,
    "symbolBeforeTheNumber" : true,
    "currency" : "USD"
  };

  bool isEnableShipping=false;
  bool isEnableAddress=false;
  String itemName= "iPhone";
  String itemPrice= '1.99';
  int quantity = 1;

  Map<String,dynamic> getOrderParams() {
    // List items =[
    //  {
    //    "name" : itemName,
    //    "quantity" : quantity,
    //    "price" :itemPrice,
    //    "currency" : defaultCurrency['currency']
    //  }
    // ];
    // // checkOut Invoice Details
    //
    // String totalAmount= '1.99';
    // String subTotalAmount= '1.99';
    // String shippingCost= '0';
    // int shippingDiscountCost= 0;
    // String userFirstName= 'Gulshan';
    // String userLastName= 'Yadav';
    // String addressCity= 'Delhi';
    // String addressStreet= 'Mathura Road';
    // String addressState= 'Multan';
    // String addressZipCode= '110014';
    // String addressCountry= 'Pakistan  ';
    // String addressPhoneNumber= '+919990119091';

    Map<String , dynamic> temp={
      "intent": "sale",
      "payer": {
        "payment_method": "paypal"
      },
      "transactions": [
        {
          "amount": {
            "total": "30.00",
            "currency": "USD",
            "details": {
              "subtotal": "30.00",
              // "tax": "0.07",
              // "shipping": "0.03",
              // "handling_fee": "1.00",
              // "shipping_discount": "-1.00",
              // "insurance": "0.01"
            }
          },
          "description": "The payment transaction description.",
          // "custom": "EBAY_EMS_9004863002444",
          // "invoice_number": "48787589674",
          "payment_options": {
            "allowed_payment_method": "INSTANT_FUNDING_SOURCE"
          },
          "soft_descriptor": "ECHI5786786"
        }
      ],
      "note_to_payer": "Contact us for any questions on your order.",
      "redirect_urls": {
        "return_url": "https://example.com/return",
        "cancel_url": "https://example.com/cancel"
      }
    };
    return temp;

  }









  @override
  Widget build(BuildContext context) {
   print("shahzaib");
    print(checkOutUrl);
   print("shahzaib");

    if(checkOutUrl.isNotEmpty)
     return Scaffold(
       appBar: AppBar(
         backgroundColor: Theme.of(context).backgroundColor,
         leading: GestureDetector(
             onTap: ()=>Navigator.of(context).pop(),
             child: Icon(Icons.arrow_back_ios)),
       ),
       body: WebView(
         initialUrl: checkOutUrl,
         javascriptMode: JavascriptMode.unrestricted,
         navigationDelegate: (NavigationRequest request) async {
           if(request.url.contains(returnUrl)){
             print("i am here");
             print(executeUrl);
             print(accessToken);
             print("i am here");
             print(request.url);
             print("heloooooooooooo");
             final uri = Uri.parse(request.url);
             print("shahzaib Ahmed Khan");
             final payerId = uri.queryParameters['PayerID'];
             print("Payer ID");
             print(payerId);
             print("Payer ID");
             if(payerId!=null){
                  services.executePayment(executeUrl, payerId, accessToken).then((id) {
                 widget.onFinish(id);
                 Navigator.of(context).pop();
               });
             }
             else{
               Navigator.of(context).pop();
             }
             Navigator.of(context).pop();
           }
           if(request.url.contains(cancelUrl)){
             Navigator.of(context).pop();
           }
           return NavigationDecision.navigate;

         },
       ),
     );
    else
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: (){
          Navigator.of(context).pop();
        }),
      ),
      body: Center(child: Container(child: CircularProgressIndicator())),
    );
  }
}
