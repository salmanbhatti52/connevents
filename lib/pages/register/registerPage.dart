import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/user-model.dart';
import 'package:connevents/pages/login/loginPage.dart';
import 'package:connevents/pages/selectCategories/selectCategoriesPage.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/const.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import '../../variables/globalVariables.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final regFormKey = GlobalKey<FormState>();

  Profile user=Profile();
  Dio dio=Dio();
  bool isPasswordObscure = true;
  bool isConfirmPasswordObscure = true;
  bool isSelected=false;
  bool isSelectedPrivacy=false;
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/imgs/handsbg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          key: regFormKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: padding),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, bottom: MediaQuery.of(context).padding.top,),
                          child: Center(
                            child: Column(
                              children: [
                                Text('Sign Up', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: globalLGray,),),
                                SizedBox(height: padding,),
                                Text('Please sign up to continue', style: TextStyle(color: globalGolden, fontSize: 16, fontWeight: FontWeight.w700,),),
                              ],
                            ),
                          ),
                        ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: SvgPicture.asset('assets/icons/user.svg', width: 18, height: 18,),
                                ),
                                SizedBox(width: padding,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('First Name', style: TextStyle(color: globalGolden, fontSize: 14, fontWeight: FontWeight.w700,),),
                                      TextFormField(
                                        validator: (val) => val!.isEmpty ? "Please Enter your first name" : null,
                                        onSaved: (val) =>setState(() =>user.firstName = val!),
                                        style: TextStyle(color: globalLGray, fontSize: 14, fontWeight: FontWeight.w700,),
                                        decoration: InputDecoration(
                                          hintText: 'First Name',
                                          hintStyle: TextStyle(color: globalLGray.withOpacity(0.5), fontSize: 14, fontWeight: FontWeight.w700,),
                                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: globalLGray,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: padding),
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: SvgPicture.asset('assets/icons/user.svg', width: 18, height: 18,),),
                                SizedBox(width: padding,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Last Name', style: TextStyle(color: globalGolden, fontSize: 14, fontWeight: FontWeight.w700,),),
                                      TextFormField(
                                        validator: (val) => val!.isEmpty ? "Please Enter your last name" : null,
                                        onSaved: (val) =>setState(() =>user.lastName = val!),
                                        style: TextStyle(color: globalLGray, fontSize: 14, fontWeight: FontWeight.w700,),
                                        decoration: InputDecoration(
                                          hintText: 'Last Name',
                                          hintStyle: TextStyle(color: globalLGray.withOpacity(0.5), fontSize: 14, fontWeight: FontWeight.w700,),
                                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: globalLGray,),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: padding),
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: SvgPicture.asset('assets/icons/user.svg', width: 18, height: 18,),
                                ),
                                SizedBox(width: padding),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Username', style: TextStyle(color: globalGolden, fontSize: 14, fontWeight: FontWeight.w700,),),
                                      TextFormField(
                                        validator: (val) => val!.isEmpty ? "Please Enter username" : null,
                                        onSaved: (val) =>setState(() =>user.userName = val!),
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.deny(RegExp("[ ]")),
                                        ],
                                        style: TextStyle(color: globalLGray, fontSize: 14, fontWeight: FontWeight.w700,),
                                        decoration: InputDecoration(
                                          hintText: 'Username',
                                          hintStyle: TextStyle(color: globalLGray.withOpacity(0.5), fontSize: 14, fontWeight: FontWeight.w700,),
                                          enabledBorder:
                                              UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: globalLGray,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: padding),
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: SvgPicture.asset('assets/icons/mail.svg', width: 18, height: 18,),),
                                SizedBox(width: padding,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Email', style: TextStyle(color: globalGolden, fontSize: 14, fontWeight: FontWeight.w700,),),
                                      TextFormField(
                                        validator: (val) {
                                          return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(val!) ? null : "Please enter correct Email";
                                        },
                                        onSaved: (val) =>setState(() =>user.userEmail = val!),
                                        style: TextStyle(color: globalLGray, fontSize: 14, fontWeight: FontWeight.w700,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: 'example@example.com',
                                          hintStyle: TextStyle(color: globalLGray.withOpacity(0.5), fontSize: 14, fontWeight: FontWeight.w700,),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: globalLGray,),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: padding),
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: SvgPicture.asset('assets/icons/password.svg', width: 18, height: 18,),
                                ),
                                SizedBox(width: padding,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Password', style: TextStyle(color: globalGolden, fontSize: 14, fontWeight: FontWeight.w700,),),
                                      TextFormField(
                                        validator: (val) => val!.length < 6 ? "Enter password grater then 6" : null,
                                        onSaved: (val) =>setState(() =>user.userPassword = val!),
                                        obscureText: isPasswordObscure,
                                        style: TextStyle(color: globalLGray, fontSize: 14, fontWeight: FontWeight.w700,),
                                        decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            onPressed: () =>setState(() =>isPasswordObscure =!isPasswordObscure),
                                            icon: isPasswordObscure ? SvgPicture.asset('assets/icons/eye.svg', width: 18,) : SvgPicture.asset('assets/icons/noeye.svg', width: 18,),
                                          ),
                                          hintText: 'Password',
                                          hintStyle: TextStyle(color: globalLGray.withOpacity(0.5), fontSize: 14, fontWeight: FontWeight.w700,),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: globalLGray,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: padding),
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: SvgPicture.asset('assets/icons/password.svg', width: 18, height: 18,
                                  ),
                                ),
                                SizedBox(width: padding,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Confirm Password', style: TextStyle(color: globalGolden, fontSize: 14, fontWeight: FontWeight.w700,),),
                                      TextFormField(
                                        // validator: (val) =>
                                        // val!.length < 6 ? "Enter password grater then 6" : null,
                                        validator: (val) => val!.isEmpty ? "Enter Confirm Password" : null,
                                        onSaved: (val) =>setState(() =>user.confirmPassword = val!),
                                        obscureText: isConfirmPasswordObscure,
                                        style: TextStyle(color: globalLGray, fontSize: 14, fontWeight: FontWeight.w700,),
                                        decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            onPressed: () =>setState(() =>isConfirmPasswordObscure = !isConfirmPasswordObscure),
                                            icon: isConfirmPasswordObscure ? SvgPicture.asset('assets/icons/eye.svg', width: 18,) : SvgPicture.asset('assets/icons/noeye.svg', width: 18,),
                                          ),
                                          hintText: 'Confirm Password',
                                          hintStyle: TextStyle(color: globalLGray.withOpacity(0.5), fontSize: 14, fontWeight: FontWeight.w700,),
                                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: globalLGray,
                                            ),
                                          ),
                                        ),
                                      ),
                                     Padding(
                                       padding: const EdgeInsets.only(top:20.0),
                                       child: Theme(
                                         data: ThemeData(unselectedWidgetColor: globalGolden),
                                         child: CheckboxListTile(
                                           contentPadding: EdgeInsets.zero,
                                          title: Text("Agree To Terms & Condition",style: TextStyle(color: globalGolden)),
                                          selectedTileColor: Colors.white,
                                          value: isSelected,
                                          activeColor: globalGolden,
                                          onChanged: (newValue) {
                                             if(!isSelected)
                                              showDialog(context: context,barrierDismissible: false,builder: (index){
                                                return termsAndCondition(
                                                    onTapAccept: (){
                                                      isSelected=true;
                                                      setState(() {});
                                                      Navigator.of(context).pop();
                                                    },
                                                    onTapDecline:()=>Navigator.of(context).pop());
                                              });
                                             else setState(() => isSelected=false);
                                          },
                                          controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                                    ),
                                       ),
                                     ),

                                      Theme(
                                        data: ThemeData(unselectedWidgetColor: globalGolden),
                                        child: CheckboxListTile(
                                          contentPadding: EdgeInsets.zero,
                                          title: Text("Privacy & Policy",style: TextStyle(color: globalGolden)),
                                          selectedTileColor: Colors.white,
                                          value: isSelectedPrivacy,
                                          activeColor: globalGolden,
                                          onChanged: (newValue) {
                                            if(!isSelectedPrivacy)
                                              showDialog(context: context,barrierDismissible: false,builder: (index){
                                                return privacyAndPolicy(
                                                    onTapAccept: (){
                                                      isSelectedPrivacy=true;
                                                      setState(() {});
                                                      Navigator.of(context).pop();
                                                    },
                                                    onTapDecline:()=>Navigator.of(context).pop());
                                              });
                                            else setState(() => isSelectedPrivacy=false);
                                          },
                                          controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 50,),
                    SizedBox(width: double.infinity, height: 50,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: globalGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text('Next'.toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () async{
                          final status = await OneSignal.shared.getDeviceState();
                          user.oneSignalId=status?.userId;
                          if (regFormKey.currentState!.validate()) {
                            regFormKey.currentState!.save();
                            if(!isSelected) return showErrorToast("Please Accept our Terms & Condition");
                            if(!isSelectedPrivacy) return showErrorToast("Please Accept our Privacy & Policy");
                            openLoadingDialog(context, "Signing Up");
                              var token = await dio.get(
                                  "${apiUrl}token", options: Options(
                                followRedirects: false,
                                validateStatus: (status) {
                                  return status! < 600;
                                },
                              ));
                              AppData().accessToken = token.data['token'];
                              print(AppData().accessToken);
                              final response = await DioService.post('signup', {
                                "userName": user.userName,
                                "userEmail": user.userEmail,
                                "firstName": user.firstName,
                                "lastName": user.lastName,
                                "userPassword": user.userPassword,
                                "confirmPassword": user.confirmPassword,
                                "userType": "1",
                                "oneSignalId":user.oneSignalId
                              });
                              Navigator.pop(context);
                              if (response['status'] == 'success') {
                                Profile profile = Profile.fromJson(response);
                                var userData = response['data']['user'] as List;
                                List<UserDetail> userDetail = userData.map<UserDetail>((e) => UserDetail.fromJson(e)).toList();
                                print(userDetail.first.toJson());
                                AppData().userdetail = userDetail.first;
                                print(profile.hint_flag);
                                AppData().profile = profile;
                                print(AppData().profile!.hint_flag);
                                showSuccessToast("You are signed up as ${AppData().userdetail!.user_name}");
                                CustomNavigator.pushReplacement(context, SelectCategoriesPage());
                              }
                              else if (response['status'] == 'error') {
                                showErrorToast(response['message']);
                              }
                            }
                          else {
                            showErrorToast("Something happened wrong");
                            //print('Error Occured');
                          }

                        },
                      ),
                    )
                  ],
                ),
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
                    CustomNavigator.pushReplacement(context, LoginPage());
                    // Navigator.pushNamedAndRemoveUntil(
                    //     context, '/login', ModalRoute.withName('/'));
                  },
                  child: Text('SIGN IN', style: TextStyle(color: globalGolden, fontSize: 14, fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ),
);
}


Widget termsAndCondition({void Function()? onTapAccept,void Function()? onTapDecline}){
    return AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0)
    ),
      title: Center(child: Text("Terms & Condition ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black))),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Text("By accessing, viewing and/or posting any content on Nationwide Children’s Hospital (“NCH”) Flutter site you accept, without limitation or qualification, the following terms of use. If you do not agree to these terms, you may not view or post any Content. Your use of NCH Flutter represents acceptance of this Agreement and has the same effect as if you had actually physically signed an agreement"
                 "The views expressed on NCH Flutter site are those of the users and are not necessarily representative of the views of NCH. You may not provide any content to Flutter that contains any product or service endorsements or any content that may be construed as political lobbying, solicitations or contributions."
                 "You shall defend, indemnify, and hold NCH and its respective officers, directors, employees, contractors, agents, successors and assigns harmless from and against, and shall promptly reimburse them for, any and all losses, claims, damages, settlements, costs, and liabilities of any nature whatsoever (including reasonable attorneys’ fees) to which any of them may become subject arising out of, based upon, as a result of, or in any way connected with, your posting of any content to an NCH social media site, any third party claims of infringement or any breach of this Agreement.",
            textAlign: TextAlign.justify,
            )
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(onPressed: onTapAccept, child: Text("Accept")),
              ElevatedButton(onPressed: onTapDecline, child: Text("Decline")),
            ],
          ),
        ),
      ],
    );


}

  Widget privacyAndPolicy({void Function()? onTapAccept,void Function()? onTapDecline}){
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)
      ),
      title: Center(child: Text("Privacy & Policy",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black))),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Text("By accessing, viewing and/or posting any content on Nationwide Children’s Hospital (“NCH”) Flutter site you accept, without limitation or qualification, the following terms of use. If you do not agree to these terms, you may not view or post any Content. Your use of NCH Flutter represents acceptance of this Agreement and has the same effect as if you had actually physically signed an agreement"
                "The views expressed on NCH Flutter site are those of the users and are not necessarily representative of the views of NCH. You may not provide any content to Flutter that contains any product or service endorsements or any content that may be construed as political lobbying, solicitations or contributions."
                "You shall defend, indemnify, and hold NCH and its respective officers, directors, employees, contractors, agents, successors and assigns harmless from and against, and shall promptly reimburse them for, any and all losses, claims, damages, settlements, costs, and liabilities of any nature whatsoever (including reasonable attorneys’ fees) to which any of them may become subject arising out of, based upon, as a result of, or in any way connected with, your posting of any content to an NCH social media site, any third party claims of infringement or any breach of this Agreement.",
              textAlign: TextAlign.justify,
            )
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(onPressed: onTapAccept, child: Text("Accept")),
              ElevatedButton(onPressed: onTapDecline, child: Text("Decline")),
            ],
          ),
        ),
      ],
    );


  }



}
