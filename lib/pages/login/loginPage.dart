import 'dart:convert';

import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/user-model.dart';
import 'package:connevents/pages/forgotPassword/forgotPasswordPage.dart';
import 'package:connevents/pages/landing/landingPage.dart';
import 'package:connevents/pages/registerType/registerTypePage.dart';
import 'package:connevents/pages/selectCategories/selectCategoriesPage.dart';
import 'package:connevents/pages/tabs/tabsPage.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/const.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final key = GlobalKey<FormState>();
  Dio dio = Dio();
  Profile profile = Profile();
  bool isPasswordObscure = true;
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future facebookLogin() async {
    final status = await OneSignal.shared.getDeviceState();
    profile.oneSignalId=status?.userId;
    openLoadingDialog(context, "loading");
    try {
      final loginResult = await FacebookAuth.instance.login();
      print(loginResult.status);
      // final userData = await FacebookAuth.instance.getUserData();
      switch (loginResult.status) {
        case LoginStatus.success :
          final facebookAuthCredential = FacebookAuthProvider.credential(
              loginResult.accessToken!.token);
          print(facebookAuthCredential.accessToken);
          final graphResponse = await dio.get('https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email & access_token=${facebookAuthCredential
                  .accessToken}');
          final prof = json.decode(graphResponse.data);
          var token = await dio.get("${apiUrl}token", options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! < 600;
            },
          ));
          AppData().accessToken = token.data['token'];

          try {
            var response = await DioService.post('signup_with_acc', {
              if(prof['name'] != null) "userName": prof['name'],
              if(prof['first_name'] !=
                  null) "firstName": prof['first_name'],
              if(prof['last_name'] != null) "lastName": prof['last_name'],
              if(prof['email'] != null) "userEmail": prof['email'],
              "accountType": 'facebook',
              "facebookId": prof['id'],
              "userType": '1',
              "oneSignalId": profile.oneSignalId
            });
            print(response);
            Profile profiles = Profile.fromJson(response);
            var userData = response['data']['user'] as List;
            AppData().profile = profiles;
            print(AppData().profile!.hint_flag);
            List<UserDetail> userDetail = userData.map<UserDetail>((e) => UserDetail.fromJson(e)).toList();
            print(userDetail.first.toJson());
            AppData().userdetail = userDetail.first;
            showSuccessToast(
                "You are signed In as  ${AppData().userdetail!.user_name}");
            CustomNavigator.pushReplacement(context, SelectCategoriesPage());
          }
          catch (e) {
            Navigator.of(context).pop();
            print(e.toString());
          }
          break;
        case LoginStatus.cancelled:
          Navigator.of(context).pop();
          break;
        default:
          return null;
      //}
      }
    }catch(e){
      Navigator.of(context).pop();
      showErrorToast("Something happened");
    }

  }

  Future signInWithGoogle() async {
    final status = await OneSignal.shared.getDeviceState();
    profile.oneSignalId=status?.userId;
    openLoadingDialog(context, "loading");
    try {
      var token = await dio.get("${apiUrl}token", options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 600;
        },
      ));
      AppData().accessToken = token.data['token'];
      try {
        GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email'],
        );
        print(_googleSignIn.currentUser);
        var res = await _googleSignIn.signIn();
        var data = await res!.authentication;
        try {
          var response = await DioService.post('signup_with_acc', {
            "userName": res.displayName,
            "userEmail": res.email,
            "googleAccessToken": data.accessToken,
            "accountType": 'google',
            "userType": '1',
            'oneSignalId':profile.oneSignalId
          });
          print(response);
          Profile prof = Profile.fromJson(response);
          print(prof.toJson());
          var userData = response['data']['user'] as List;
          List<UserDetail> userDetail = userData.map<UserDetail>((e) => UserDetail.fromJson(e)).toList();
          print(userDetail.first.toJson());
          AppData().profile = prof;
          print(AppData().profile!.hint_flag);
          AppData().userdetail = userDetail.first;
          print(AppData().userdetail!.toJson());
          showSuccessToast("You are signed In as  ${AppData().userdetail!.user_name}");
          CustomNavigator.pushReplacement(context, SelectCategoriesPage());
        }
        catch (e) {
          Navigator.pop(context);
          print(e.toString());
        }
      } catch (e) {
        Navigator.of(context).pop();
        print(e.toString());
      }

    }
    catch(e){
      Navigator.of(context).pop();
      showErrorToast("Something happened");
    }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/imgs/handsbg.png'), fit: BoxFit.cover,),
        ),
        child: Column(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(padding * 2),
                    child: Form(
                      key: key,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Column(
                              children: [
                                Text(
                                  'Sign In',
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                    color: globalLGray,
                                  ),
                                ),
                                SizedBox(
                                  height: padding,
                                ),
                                Text(
                                  'Enter your User name & password',
                                  style: TextStyle(
                                    color: globalGolden,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: padding * 4,),
                          Text('Username', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: globalGolden,),),
                          Container(
                            child: TextFormField(
                              validator: (val) => val!.isEmpty ? "Please Enter your userName" : null,
                              onSaved: (val) =>setState(() =>profile.userName = val!),
                              keyboardType: TextInputType.visiblePassword,
                              style: TextStyle(color: globalLGray),
                              decoration: InputDecoration(
                                hintText: 'Username',
                                hintStyle: TextStyle(color: globalLGray.withOpacity(0.5),),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: globalLGray,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: padding * 2,),
                          Text('Password', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: globalGolden,),),
                          Container(
                            child: TextFormField(
                              validator: (val) => val!.isEmpty ? "Please Enter your Password" : null,
                              onSaved: (val) =>setState(() =>profile.userPassword = val!),
                              obscureText: isPasswordObscure,
                              keyboardType: TextInputType.visiblePassword,
                              style: TextStyle(color: globalLGray,),
                              decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: TextStyle(color: globalLGray.withOpacity(0.5),),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: globalLGray,
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () =>setState(() =>isPasswordObscure = !isPasswordObscure ),
                                  icon: SvgPicture.asset(isPasswordObscure ? 'assets/icons/eye.svg' : 'assets/icons/noeye.svg', width: 18,),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                CustomNavigator.navigateTo(context, ForgotPasswordPage());

                                // Navigator.pushNamed(context, '/forgotPassword');
                              },
                              child: Text('Forget Password?', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: globalLGray,),),
                            ),
                          ),
                          SizedBox(height: padding * 2,),
                          SizedBox(width: double.infinity,height: 50,
                            child: TextButton(
                              onPressed: () async {
                                final status = await OneSignal.shared.getDeviceState();
                                profile.oneSignalId=status?.userId;
                                if (key.currentState!.validate()) {
                                  key.currentState!.save();
                                  openLoadingDialog(context, "Signing In");
                                  print("${apiUrl}token");
                                  var token = await dio.get("${apiUrl}token",
                                      options: Options(
                                        followRedirects: false,
                                        validateStatus: (status) {
                                          return status! < 600;
                                        },
                                      ));
                                  print("Shahzaib");
                                  print(token);
                                  print("Shahzaib");

                                  AppData().accessToken = token.data['token'];
                                  // print(AppData().accessToken);
                                  var response= await DioService.post('login', {
                                    "userName": profile.userName,
                                    "userPassword": profile.userPassword,
                                    "oneSignalId": profile.oneSignalId
                                  });
                                  Navigator.pop(context);
                                    print("haha");
                                    if(response['status']=='success') {
                                    var userData = response['data']['user'] as List;
                                    Profile profile=Profile.fromJson(response);
                                    List<UserDetail> userDetail = userData.map<UserDetail>((e) => UserDetail.fromJson(e)).toList();
                                    AppData().profile=profile;
                                    AppData().userdetail=userDetail.first;
                                    showSuccessToast("You are signed as ${AppData().userdetail!.user_name}");
                                    CustomNavigator.pushReplacement(context, TabsPage());
                                  }
                                  else if(response['status']=='error')
                                    {
                                      showErrorToast(response['message']);
                                    }
                                } else{
                                  showErrorToast("Something happened wrong");
                                }
                              },
                              child: Text('SIGN IN', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),),
                              style: TextButton.styleFrom(
                                backgroundColor: globalGreen,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: padding * 2,),
                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: Divider(color: globalLGray,),
                              ),
                              SizedBox(width: 10,),
                              Text('Or', style: TextStyle(color: globalLGray, fontSize: 14, fontWeight: FontWeight.w300,),),
                              SizedBox(width: 10,),
                              Flexible(
                                flex: 1,
                                child: Divider(color: globalLGray,),
                              ),
                            ],
                          ),
                          SizedBox(height: padding * 2),
                          if(isSocial=='1')
                          SizedBox(
                            width: double.infinity, height: 50,
                            child: TextButton(
                              onPressed: () =>facebookLogin(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('assets/icons/facebook.svg'),
                                  SizedBox(width: padding,),
                                  Text('Sign In with Facebook', style: TextStyle(color: globalGreen, fontSize: 16, fontWeight: FontWeight.w700),),
                                ],
                              ),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: padding),
                          if(isSocial=='1')
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: TextButton(
                              onPressed: () =>signInWithGoogle(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('assets/icons/google.svg'),
                                  SizedBox(width: padding,),
                                  Text('Sign In with Google    ', style: TextStyle(color: globalGreen, fontSize: 16, fontWeight: FontWeight.w700),),
                                ],
                              ),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don’t have an account?', style: TextStyle(color: globalLGray, fontSize: 14, fontWeight: FontWeight.w700),),
                  SizedBox(width: 6,),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(14, 14,),
                    ),
                    onPressed: () {
                      CustomNavigator.pushReplacement(context, RegisterTypePage());
                   //   Navigator.pushReplacementNamed(context, '/registerType');
                    },
                    child: Text('SIGN UP', style: TextStyle(color: globalGolden, fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
