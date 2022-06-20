import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/user-model.dart';
import 'package:connevents/pages/verifyCode/verifyCodePage.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/const.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:dio/dio.dart';

import '../../variables/globalVariables.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  Dio dio= Dio();


  @override
  Widget build(BuildContext context) {
    Profile user= Profile();
//    var key=GlobalKey<SimpleFormState>();
    final regFormKey = GlobalKey<FormState>();

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
                  Text('Forget Password', style: TextStyle(color: globalLGray, fontSize: 36, fontWeight: FontWeight.bold,),),
                  Text('Enter the email associated with', style: TextStyle(color: globalGolden, fontSize: 16, fontWeight: FontWeight.w700,),),
                  Text('your account.', style: TextStyle(color: globalGolden, fontSize: 16, fontWeight: FontWeight.w700,),),
                ],
              ),
            ),
            Form(
              key: regFormKey,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Email',
                      style: TextStyle(color: globalGolden, fontSize: 14, fontWeight: FontWeight.w700,),),
                    TextFormField(
                      validator: (val) {
                        return RegExp(
                            r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                            .hasMatch(val!)
                            ? null
                            : "Please enter correct Email";
                      },
                      onSaved: (val) {
                        setState(() {
                          user.userEmail = val!;
                        });
                      },
                      style: TextStyle(
                        color: globalLGray,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      decoration: InputDecoration(
                        hintText: 'example@example.com',
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: globalLGray.withOpacity(0.5),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: globalLGray),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: padding * 4,
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: TextButton(
                child: Text('SEND CODE',
                  style: TextStyle(color: globalLGray, fontSize: 16, fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: ()async {
                  if (regFormKey.currentState!.validate()) {
                    regFormKey.currentState!.save();
                    openLoadingDialog(context, "Submitting...");
                    var token = await dio.get("${apiUrl}token",options:Options(
                      followRedirects: false,
                      validateStatus: (status) {
                        return status!  < 600;
                      },
                    ));

                    AppData().accessToken=token.data['token'];


                    var response= await DioService.post('forgot_password', {
                      "requestType":"forgot_password",
                      "email": user.userEmail
                    });
                    Navigator.pop(context);
                    if(response['status']=='Success')
                      {
                        showSuccessToast(response['message']);
                        CustomNavigator.navigateTo(context, VerifyCodePage(
                          email: user.userEmail,
                        ));
                      }
                    else if(response['status']=='error')
                      {
                         showErrorToast(response['message']);
                      }



                  } else {
                    print("error");
                    //print('Error Occured');
                  }                 // Navigator.pushNamed(context, '/verifyCode');
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
