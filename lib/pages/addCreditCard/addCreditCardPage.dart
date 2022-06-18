
import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/add-card.dart';
import 'package:connevents/pages/paymentMethods/paymentMethodsPage.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/services/stripe-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/lazy_task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:stripe_payment/stripe_payment.dart';

class AddCreditCardPage extends StatefulWidget {
  const AddCreditCardPage({Key? key}) : super(key: key);

  @override
  _AddCreditCardPageState createState() => _AddCreditCardPageState();
}

class _AddCreditCardPageState extends State<AddCreditCardPage> {

CardDetails cardDetails=CardDetails();

  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  TextEditingController zipCode=TextEditingController();
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: TextButton(
          onPressed: () =>Navigator.pop(context),
          child: Row(
            children: [
              Icon(Icons.chevron_left, color: globalGreen,),
              Text('Back', style: TextStyle(color: globalGreen, fontSize: 16,),),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top:10.0,left: 10.0,right: 10.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Add Card', style: TextStyle(color: globalBlack, fontWeight: FontWeight.bold, fontSize: 32,),),
              SizedBox(height: padding * 2,),
              Image.asset("assets/stripe.png",scale: 7,),
                CreditCardWidget(
                cardBgColor: Colors.green,
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
                cardNumberDecoration:  InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Card Number",
                  hintText: 'XXXX XXXX XXXX XXXX',
                ),
                expiryDateDecoration:  InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Expiry Date",
                  hintText: 'XX/XX',
                ),
                cvvCodeDecoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Security Code',
                  hintText: 'XXX',
                ),
                cardHolderDecoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Card Holder Name",
                ),
                onCreditCardModelChange: onCreditCardModelChange, cardHolderName: '', expiryDate: '', cvvCode: '', themeColor: Colors.grey, cardNumber: '',
              ),
                SizedBox(height: padding),
                Padding(
                  padding: const EdgeInsets.only(left:14.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child:  Container(
                            width: MediaQuery.of(context).size.width/2,
                          decoration: BoxDecoration(

                          ),
                          child: TextFormField(
                           controller: zipCode,
                            keyboardType: TextInputType.number,
                            style: TextStyle(color: globalBlack , height: 1.7 , fontSize: 14 , fontWeight: FontWeight.normal,),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:Colors.blue,
                                  width:2.0,
                                )),

                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:Colors.blue,
                                  width:2.0,
                                )
                              ),
                              labelText: 'ZIP CODE',
                              labelStyle: TextStyle(color: Colors.black),
                               hintStyle: TextStyle(color: globalBlack.withOpacity(0.5) , height: 1.7 , fontSize: 14 , fontWeight: FontWeight.normal,),
                            ),
                          ),
                        ),
                  ),
                ),
                Container(
                padding: EdgeInsets.all(padding),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () async{
                      if (formKey.currentState!.validate()) {
                        if(zipCode.text.isEmpty){
                          return showErrorToast('Please Input Zip Code');
                        } else {
                           var  res;
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
                                 'zipCode' :zipCode.text,
                                 "cvv": cvvCode,
                                 "cardHolderName": cardHolderName,
                                 "expiryMonths": int.tryParse(expiryDate.split('/').first),
                                 "expiryYears": int.tryParse(expiryDate.split('/').last),
                                 'token': token,

                               });
                             });

                             if (res['status'] == 'success') {
                               showSuccessToast("Your Card has been Added Successfully");
                               Navigator.of(context).pop(true);
                              // Navigator.of(context).pop(true);
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
                        }
                      } else {
                      print('invalid!');
                      }
                    //  CustomNavigator.navigateTo(context, PaymentMethodsPage());
                //      Navigator.pushNamed(context, '/paymentMethods');
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: globalGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text('SAVE', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold,),),
                  ),
                ),
              ),
            ],
          ),
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
