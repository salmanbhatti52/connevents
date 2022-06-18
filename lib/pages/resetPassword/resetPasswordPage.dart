import 'package:connevents/models/user-model.dart';
import 'package:connevents/pages/login/loginPage.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../variables/globalVariables.dart';
import 'package:flutter/material.dart';

class ResetPasswordPage extends StatefulWidget {
  final  String? email;
  const ResetPasswordPage({Key? key,this.email}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  Profile profile=Profile();
  bool isPasswordObscure = true;
  bool isConfirmPasswordObscure = true;
  final GlobalKey<FormState> regFormKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          right: padding * 2,
          left: padding * 2,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/imgs/handsbg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: regFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(bottom: padding * 3),
                    child: Column(
                      children: [
                        Text('Reset Password', style: TextStyle(color: globalLGray, fontSize: 36, fontWeight: FontWeight.bold,),),
                        Text('Enter new Password', style: TextStyle(color: globalGolden, fontSize: 16, fontWeight: FontWeight.w700,),),
                      ],
                    ),
                  ),
                  SizedBox(height: padding * 2),
                  Container(
                    margin: EdgeInsets.only(bottom: padding * 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Password', style: TextStyle(color: globalGolden, fontSize: 14, fontWeight: FontWeight.w700,),),
                        TextFormField(
                          validator: (val) => val!.isEmpty ? "Enter Confirm Password" : null,
                          onSaved: (val) => setState(() =>profile.userPassword = val!),
                          obscureText: isPasswordObscure,
                          style: TextStyle(
                            color: globalLGray,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () => setState(() =>isPasswordObscure = !isPasswordObscure),
                              icon: isPasswordObscure
                                  ? SvgPicture.asset('assets/icons/eye.svg')
                                  : SvgPicture.asset('assets/icons/noeye.svg'),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: globalLGray,
                              ),
                            ),
                            hintText: 'Password',
                            hintStyle: TextStyle(
                              color: globalLGray.withOpacity(0.5),
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: padding * 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Confirm Password',
                          style: TextStyle(color: globalGolden, fontSize: 14, fontWeight: FontWeight.w700,),),
                        TextFormField(
                          validator: (val) => val!.isEmpty ? "Enter Confirm Password" : null,
                          onSaved: (val) => setState(() => profile.confirmPassword = val!),
                          obscureText: isConfirmPasswordObscure,
                          style: TextStyle(color: globalLGray, fontSize: 14, fontWeight: FontWeight.w700,
                          ),
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () => setState(() => isConfirmPasswordObscure = !isConfirmPasswordObscure),
                              icon: isConfirmPasswordObscure
                                  ? SvgPicture.asset('assets/icons/eye.svg')
                                  : SvgPicture.asset('assets/icons/noeye.svg'),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: globalLGray,
                              ),
                            ),
                            hintText: 'Confirm Password',
                            hintStyle: TextStyle(
                              color: globalLGray.withOpacity(0.5),
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: padding,),
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
                        child: Text('SAVE', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold,),),
                        onPressed: () async{
                          print(widget.email);
                          if (regFormKey.currentState!.validate()) {
                            regFormKey.currentState!.save();
                            print(profile.userPassword);
                            print(profile.confirmPassword);
                            openLoadingDialog(context, "reseting password...");
                            var response = await DioService.post('forgot_password',
                                {
                                  "requestType":"reset_password",
                                  "email":widget.email,
                                  "password": profile.userPassword.toString(),
                                  "c_password":profile.confirmPassword.toString()
                                });
                            Navigator.pop(context);
                            if(response['status']=='Success')
                            {
                              showSuccessToast(response['message']);
                              CustomNavigator.pushReplacement(context, LoginPage());
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

                        ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
