import 'package:connevents/pages/resetPassword/resetPasswordPage.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/widgets/custom-navigator.dart';

import '../../variables/globalVariables.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyCodePage extends StatefulWidget {
  String? email;
   VerifyCodePage({Key? key,this.email}) : super(key: key);

  @override
  _VerifyCodePageState createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {
  TextEditingController pinText=TextEditingController();
  final regFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(padding * 2),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/imgs/handsbg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: padding * 3),
              child: Column(
                children: [
                  Text(
                    'Verification',
                    style: TextStyle(
                      color: globalLGray,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Please enter the 4 digit code we',
                    style: TextStyle(
                      color: globalGolden,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'sent to ',
                        style: TextStyle(
                          color: globalGolden,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'abc@example.com',
                        style: TextStyle(
                          color: globalLGray,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Form(
              key: regFormKey,
              child: SizedBox(
                width: 242,
                child: PinCodeTextField(
                  appContext: context,
                  length: 4,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.underline,
                    borderRadius: BorderRadius.circular(5),
                    borderWidth: 2,
                    fieldHeight: 29,
                    fieldWidth: 50,
                    activeFillColor: Colors.transparent,
                    activeColor: globalLGray,
                    selectedColor: globalGreen,
                    inactiveColor: globalLGray,
                  ),
                  textStyle: TextStyle(color: globalLGray),
                  animationDuration: Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  keyboardType: TextInputType.number,
                  enableActiveFill: false,
                  // errorAnimationController: errorController,
                  controller: pinText,
                  validator: (v) {
                  if (v!.length < 3) {
                          return "Please Input a Code";
                  } else {
                          return null;
                  } },
                  onCompleted: (v) {
                    pinText.text=v;
                    print(pinText.text);
                  },
                  onChanged: (value) {
                    print(value);
                    setState(() {
                      pinText.text = value;
                      print(pinText.text);
                    });
                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                ),
              ),
            ),
            SizedBox(
              height: padding * 3,
            ),
            Column(
              children: [
                Text(
                  'Didn’t recieve code?',
                  style: TextStyle(
                    color: globalGolden,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Resend in 59s',
                  style: TextStyle(
                    color: globalLGray,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
            SizedBox(
              height: padding * 3,
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: TextButton(
                child: Text('VERIFY',
                  style: TextStyle(color: globalLGray, fontSize: 16, fontWeight: FontWeight.bold,),),
                onPressed: () async{
                  print(widget.email);
            if (regFormKey.currentState!.validate()) {
                    regFormKey.currentState!.save();
                    openLoadingDialog(context, "Verifying");
                    var response = await DioService.post('forgot_password',
                        {
                          "requestType":"match_code",
                          "email": widget.email,
                          "code": pinText.text
                        });
                    Navigator.pop(context);
                    if(response['status']=='Success')
                    {
                      showSuccessToast(response['message']);
                      CustomNavigator.navigateTo(context, ResetPasswordPage(
                        email: widget.email,

                      ));
                    }
                    else if(response['status']=='error')
                    {
                      showErrorToast(response['message']);
                    }

             }
                else{
               print("error");
               }//  Navigator.pushNamed(context, '/resetPassword');
                },
                style: TextButton.styleFrom(
                  backgroundColor: globalGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
