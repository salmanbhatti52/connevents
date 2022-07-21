import 'package:connevents/mixins/data.dart';
import 'package:connevents/services/_config.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/bank-textfield.dart';
import 'package:flutter/material.dart';
import 'package:connevents/utils/const.dart';
import 'package:http_auth/http_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:dio/dio.dart';

class AddPaypalAccountPage extends StatefulWidget {
  String? email;
  int? amount;
  AddPaypalAccountPage({Key? key,this.amount,this.email}) : super(key: key);

  @override
  _AddPaypalAccountPageState createState() => _AddPaypalAccountPageState();
}

class _AddPaypalAccountPageState extends State<AddPaypalAccountPage> {

  var payPalBody;
  var _formKey = GlobalKey<FormState>();
  String? email;
  String? amount;
  TextEditingController emailController=TextEditingController();

  bool _autoValidate=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email=widget.email;
    emailController=TextEditingController(text: widget.email);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height:20),
            Text("Add Paypal Account",style:TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Padding(
                padding: const EdgeInsets.only(top:12.0,bottom: 12.0,left:20,right: 20),
                child: Column(
                  children: [
                    BankTextField(
                      controller: emailController,
                      hintText: "Account Email",
                      validator:(value)=> value!.isEmpty ? "Please Enter Your Name" : null,
                      keyBoardType: TextInputType.text,
                      onSaved: (value)=>setState(() =>   email =value),
                    ),
                    BankTextField(
                      hintText: "Amount",
                      validator:(value)=> value!.isEmpty ? "Please Enter Bank Name" : null,
                      keyBoardType: TextInputType.text,
                      onSaved: (value)=>setState(() =>   amount =value),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width/1.2,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: globalGreen,
                ),
                onPressed: () async{
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if(int.parse(amount!) > widget.amount!){
                      return showErrorToast("You don't have enough balance \n Current Amount : \$${widget.amount}");
                    }
                    FocusScope.of(context).requestFocus(FocusNode());
                    FocusScope.of(context).requestFocus(FocusNode());
                    await withdrawAmount();
                  } else
                    setState(() => _autoValidate = true);
                },
                // Navigator.pushNamed(context, '/purchaseEvent');
                child: Text('Submit', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold,
                ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future withdrawAmount() async{
    openLoadingDialog(context, "Loading");
    try{

      var payPalResponse = await http.get(Uri.parse('${apiUrl}get_paypal_config'));
      payPalBody = convert.jsonDecode(payPalResponse.body);
      print("PaPalBody");
      print(payPalBody['data']);
      print("PaPalBody");
      Map<String , dynamic> temp={
        "sender_batch_header": {
          "sender_batch_id": "Payouts_${DateTime.now().millisecondsSinceEpoch}",
          "email_subject": "You have a payout!",
          "email_message": "You have received a payout! Thanks for using our service!"
        },
        "items": [
          {
            "recipient_type": "EMAIL",
            "amount": {
              "value": amount.toString(),
              "currency": "USD"
            },
            "note": "Thanks for your patronage!",
            "sender_item_id": "201403140001",
            "receiver": "sb-wm4n719304507@personal.example.com",
            "notification_language": "en-US"
          }
        ]
      };
      var data = convert.jsonEncode(temp);

      if(payPalBody!=null){
        Response response = await Dio().post('https://api.sandbox.paypal.com/v1/payments/payouts', data: data, options: Options(
          headers: {
            "Content-Type": "application/json",
            "PayPal-Request-Id": "A v4 style guid",
            "Authorization": "Basic QVRrX2Jsd2N5eEFpM2x1UkN2SmRtWVl0dDlsdW1nZFA3emNOV3g3NXJUTjA0Q0hhbjJkZ3Y0X3ZEcF91cFJTYlB6clJ6RlVkRG9hakZvdDA6RUltZkNHYzZTbDA2REwycVZVbzVfT1B4UkR4S0xlNnV2QnpHVmFkaHdGZ29HXzg0b2JjVk9RdjJuZHRFOGhwSF8xMG1CdlhlYnZ1dm5zalc="
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 600;
          },
        ),
          onSendProgress: (int sent, int total) {
            print("${(sent * 100) / total}%");
          },
        );
          // var client= BasicAuthClient(payPalBody['data']['client_id'] , payPalBody['data']['secret']);
          // var response =await client.post(Uri.parse('https://api.sandbox.paypal.com/v1/payments/payouts'),body: {
          //
          // });
          if(response.statusCode==201){
            final body=response.data;
            var responses = await DioService.post('store_paypal_transaction_details', {
              "usersId":AppData().userdetail!.users_id,
              "withdrawType":"Paypal",
              "paypal_email":email,
              "amount": int.parse(amount!),
              "accHolderName":AppData().userdetail!.first_name!+AppData().userdetail!.last_name!,
              "payout_batch_id":body['batch_header']['payout_batch_id'],
              "batch_status":body['batch_header']['batch_status'],
              "sender_batch_id":body['batch_header']['sender_batch_header']['sender_batch_id'],
              "href":body['links'][0]['href'],
            });
            print(responses);
            showSuccessToast("Amount Successfully WithDraw");
            Navigator.pop(context);
          }
          else if(response.statusCode==400){
            showErrorToast("Bad State");
          }

      }
      else
        showErrorToast("Empty paypal config");
    }catch(e){
      Navigator.of(context).pop(true);
      print(e.toString());
      showErrorToast(e.toString());
      rethrow;
    }
    Navigator.of(context).pop(true);
  }
}
