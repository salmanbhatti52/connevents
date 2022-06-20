import 'dart:convert';

import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/user-model.dart';
import 'package:connevents/pages/landing/landingPage.dart';
import 'package:connevents/pages/login/loginPage.dart';
import 'package:connevents/pages/register/registerPage.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/const.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../variables/globalVariables.dart';
import 'package:flutter/material.dart';

class RegisterTypePage extends StatefulWidget {
  const RegisterTypePage({Key? key}) : super(key: key);

  @override
  _RegisterTypePageState createState() => _RegisterTypePageState();
}

class _RegisterTypePageState extends State<RegisterTypePage> {
  Dio dio=Dio();
  Profile profile=Profile();
  bool isPasswordObscure = true;
  final googleSignIn=GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;


     Future facebookLogin() async {
       final status = await OneSignal.shared.getDeviceState();
       profile.oneSignalId=status?.userId;
    openLoadingDialog(context, "Signing In");

    try {
      final loginResult = await FacebookAuth.instance.login();
      print(loginResult.status);
      // final userData = await FacebookAuth.instance.getUserData();
      switch (loginResult.status) {
        case LoginStatus.success :
          final facebookAuthCredential = FacebookAuthProvider.credential(
              loginResult.accessToken!.token);
          print(facebookAuthCredential.accessToken);
          final graphResponse = await dio.get('https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email & access_token=${facebookAuthCredential.accessToken}');
          final prof = json.decode(graphResponse.data);
          print(prof);
          print(prof['id']);
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
              if(prof['first_name'] != null) "firstName": prof['first_name'],
              if(prof['last_name'] != null) "lastName": prof['last_name'],
              if(prof['email'] != null) "userEmail": prof['email'],
              "accountType": 'facebook',
              "facebookId": prof['id'],
              "userType": '1',
              "oneSignalId":profile.oneSignalId
            });
            print(response);
            Profile profiles = Profile.fromJson(response);
            var userData = response['data']['user'] as List;
            AppData().profile = profiles;
            List<UserDetail> userDetail = userData.map<UserDetail>((e) =>
                UserDetail.fromJson(e)).toList();
            print(userDetail.first.toJson());
            AppData().userdetail = userDetail.first;
            showSuccessToast(
                "You are signed In as  ${AppData().userdetail!.user_name}");
          //  CustomNavigator.pushReplacement(context, SelectCategoriesPage());
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
      showErrorToast("Something happened or check Your Internet Connection");
    }

  }

     Future signInWithGoogle() async {
    final status = await OneSignal.shared.getDeviceState();
    profile.oneSignalId=status?.userId;
    openLoadingDialog(context, "signing In");
    try {
      var token = await dio.get("${apiUrl}token", options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 600;
        },
      ));
      AppData().accessToken = token.data['token'];
      try {
        GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
        print(_googleSignIn.currentUser);
        var res = await _googleSignIn.signIn();
        var data = await res!.authentication;
        print(res);
        print(data.accessToken);

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
          List<UserDetail> userDetail = userData.map<UserDetail>((e) =>
              UserDetail.fromJson(e)).toList();
          print(userDetail.first.toJson());
          AppData().profile = prof;
          AppData().userdetail = userDetail.first;
          print(AppData().userdetail!.toJson());
          showSuccessToast(
              "You are signed In as  ${AppData().userdetail!.user_name}");
       //   CustomNavigator.pushReplacement(context, SelectCategoriesPage());
        }
        catch (e) {
          Navigator.pop(context);
          print(e.toString());
        }
      } catch (e) {
        Navigator.of(context).pop();
      }

      // GoogleSignInAuthentication auth = await acc!.authentication;
      // acc.authentication.then((GoogleSignInAuthentication auth) async {
      //   print(auth.idToken);
      //   print(auth.accessToken);
      // });
    }
    catch(e){
      Navigator.of(context).pop();
      showErrorToast("Something happened or check Your Internet Connection");
    }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/imgs/handsbg.png'), fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(padding * 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Text('Sign Up', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: globalLGray,),
                          ),
                          SizedBox(height: padding),
                          Text('Please sign up to continue', style: TextStyle(color: globalGolden, fontSize: 16, fontWeight: FontWeight.w700,),),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 10,),
                    SizedBox(width: double.infinity, height: 50,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: globalGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text('Create an account'.toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold,),
                        ),
                        onPressed: () {
                          CustomNavigator.navigateTo(context, RegisterPage());

                         // Navigator.pushNamed(context, '/register');
                        },
                      ),
                    ),
                    SizedBox(height: padding * 2,),
                    Row(
                      children: [
                        Flexible(
                          child: Divider(color: globalLGray),
                          flex: 1,
                        ),
                        if(isSocial=='1')
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: padding),
                          child: Text('Or', style: TextStyle(color: globalLGray, fontSize: 14, fontWeight: FontWeight.w300,),),
                        ),
                        Flexible(
                          child: Divider(color: globalLGray,),
                          flex: 1,
                        ),
                      ],
                    ),
                    SizedBox(height: padding * 2,),
                    if(isSocial=='1')
                    SizedBox(width: double.infinity, height: 50,
                      child: TextButton(
                        onPressed: () =>facebookLogin(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/icons/facebook.svg'),
                            SizedBox(width: padding,),
                            Text('Sign Up with Facebook', style: TextStyle(color: globalGreen, fontSize: 16, fontWeight: FontWeight.w700),),
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
                    SizedBox(height: padding,),
                    if(isSocial=='1')
                    SizedBox(width: double.infinity, height: 50,
                      child: TextButton(
                        onPressed: () =>signInWithGoogle(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/icons/google.svg'),
                            SizedBox(width: padding,),
                            Text('Sign Up with Google', style: TextStyle(color: globalGreen, fontSize: 16, fontWeight: FontWeight.w700),),
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
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account?', style: TextStyle(color: globalLGray, fontSize: 14, fontWeight: FontWeight.w700),),
                  TextButton(
                    onPressed: () {
                      CustomNavigator.navigateTo(context, LoginPage());
                      // Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: Text('SIGN IN', style: TextStyle(color: globalGolden, fontSize: 14, fontWeight: FontWeight.w700,),),
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
