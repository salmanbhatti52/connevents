import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/user-model.dart';
import 'package:connevents/pages/login/loginPage.dart';
import 'package:connevents/pages/selectCategories/selectCategoriesPage.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/const.dart';
import 'package:connevents/utils/fonts.dart';
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
        child: Align(
          alignment:Alignment.center,
          child: Container(
            width: 350,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text("This website is owned and operated by ConnEvents. Your interaction with ConnEvents ('Website') is governed by this document. The following terms, conditions, and notices govern access to and use of this Website, our Mobile Application (“App” or “Application”), and our products and services accessible through our Application (collectively, the 'Services') (the 'Terms of Service'). You agree to all of the Terms of Service, as they may be modified by us from time to time, by using the Services. You should check this page frequently for any changes to the Terms of Service that we may have made.\n\n"+
                    ' Our website will only be for informational purposes.\n\n'+
                    'We will not be accountable if this Application is inaccessible at any time or for any period due to any reason. We reserve the right to limit access to sections or all of this Application at any time.\n'+
                    'This Application may contain links to other Applications that are not managed by us (the "Linked Sites"). We have no control over the Linked Sites and take no responsibility for them or any loss or damage that may occur as a result of your use of them. Your use of the Linked Sites is governed by the terms of service and use set out on each site.\n\n'+
                    'Please keep an eye out for any extra terms and conditions that may be published with any Services that you use from time to time, as these will apply to you as well. Furthermore, by accepting these Terms of Service, you indicate that you have read and understood the Privacy Policy and Cookie Statement that apply to all Users. Unless we have entered into a separate, signed agreement that expressly substitutes these Terms of Service, we may occasionally offer you with services that are not defined in these Terms of Service, or customized services: these Terms of Service will apply to those services as well.\n\n'+
                    'If you are using the Services on behalf of a company (for example, your employer), you agree to these Terms on behalf of that company and its affiliates and represent that you have the ability to do so. "You" and "your" will relate to that entity as well as yourself in this circumstance.\n\n',
                    textAlign: TextAlign.justify,
                    style: gilroyLight),
                Text("* ConnEvents's Services and Role\n",style: gilroyExtraBold),
                Text('This is what we do. \n',style: gilroyBold),
                Text("Organizers can use ConnEvents' Services to create speaker profiles, organizer profiles, and other event-related webpages, promote those pages and events to visitors or browsers on the Services or elsewhere online, manage online or onsite ticketing and registration, solicit donations, and sell or reserve merchandise or accommodations related to those events to Consumers or other Users. Other and more specific services are often described on the ConnEvents Properties' respective Applications.\n\n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight),
                Text('How We Fit In.',style: gilroyBold),
                Text('The events featured on the Services were not created, organized, or owned by ConnEvents. ConnEvents, on the other hand, provides its Services, which enable Organizers to manage ticketing and registration as well as advertise their events. The Organizer is solely responsible for ensuring that any page displaying an event on the Services (as well as the event itself) complies with all applicable local, state, provincial, national, and other laws, rules, and regulations, and that the goods and services described on the event page are delivered accurately and in a timely manner. The Organizer can only use the payment processing option provided by us. Consumers will buy directly from the app using our "Stripe" payment gateway. Organizers can only post and manage their events. They may use only their followers’ email for promotional purposes but cannot do or see anything else about the users/consumers\n\n'+
                    "ConnEvents acts as the Organizer's limited agent for the express purpose of employing our third-party payment service providers to collect and transmit payments made by Consumers on the Services to the Organizer. \n\n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight),
                RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        text: 'Event Catalog.',
                        style: gilroyBold,
                        children: [
                          TextSpan(
                              style:gilroyLight ,
                              text:'. We provide a feature in the Application called the Event Catalog where only event participants or tickets holders can have access to for a specific event and they will be able to post pictures, selfies and/or videos at their own discretion.\n\n'
                          )
                        ]
                    )),
                RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        text: 'My Portfolio.',
                        style: gilroyBold,
                        children: [
                          TextSpan(
                              style:gilroyLight ,
                              text:'We provide a feature in the Application called the My Portfolio where all the pictures, selfies and/or videos posted by users/consumers or event participants, or tickets holders will be stored. The hosts will have these event contents in their account, and they will also have access to upload or remove from those contents. Then, users/consumers can check out the recent events hosted by the organizer if needed\n\n'
                          )
                        ]
                    )),
                Text('* Privacy and Consumer Information\n\n',style: gilroyBold),
                Text('We understand how essential your personal information is to you, and we understand how important it is to ConnEvents as well. Our Privacy Policy governs information supplied to ConnEvents by Users or collected by ConnEvents through ConnEvents Properties.\n\n'+
                    "If you are an Organizer, you represent, warrant, and agree that (a) you will comply with all applicable local, state, provincial, national, and other laws, rules, and regulations with respect to information you collect from (or receive about) consumers at all times, and (b) you will comply with any applicable policies posted on the Services with respect to information you collect from (or receive about) consumers at all times\n\n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight),
                Text('* Term; Termination',style: gilroyExtraBold),

                Text("ConnEvents reserves the right to discontinue your access to the Services at any time:\n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),
                Text("   (a) If you violate or breach these Terms;\n"
                    "    (b) If you misuse or abuse the Services, or use them in\n"
                    "         a way that ConnEvents did not intend or\n"
                    "         permit; or\n"
                    "   (c)	If allowing you to access and use the Services\n"
                    "          would violate any applicable local, state,l\n"
                    "           provincial, national, or other laws, rules, or\n"
                    "           regulations, or expose ConnEvents to legal\n"
                    "           liability.\n"
                    ,
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),


                Text("ConnEvents reserves the right to discontinue providing the Services, or any portion thereof, or to modify or replace any component of the Service at any time. If, in ConnEvents' sole judgement, failure to do so would materially prejudice you, we shall use reasonable efforts to provide you with notice of our termination of your access to the Services. You agree that ConnEvents will not be liable to you or any third party if your right to use or otherwise access the Services is terminated by ConnEvents.\n\n"+
                    "You may cancel your access to the Services and the general applicability of Terms by deleting your account unless you have agreed differently in a separate written agreement between you and ConnEvents. If you are a Consumer using the Services without a registered account, your only alternative is to discontinue using the Services indefinitely, in which case these Terms will no longer apply to you. These Terms will remain in effect as long as you use the Services, even if you do not have an account. If you and ConnEvents have a separate agreement controlling your use of the Services, that agreement will end or expire after such termination or expiration, and these Terms (as unaffected by such agreement) shall govern your use of the Services after such termination or expiration.\n\n"+
                    "All provisions of these Terms that should, by their nature, survive termination will do so (including, without limitation, all limitations on liability, releases, indemnification obligations, disclaimers of warranties, agreements to arbitrate, choices of law and judicial forum and intellectual property protections and licenses).\n\n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),
                Text('* Release and Indemnification',style: gilroyBold),
                RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        text: 'Release.',
                        style: gilroyBold,
                        children: [
                          TextSpan(
                              style:gilroyLight ,
                              text:'You agree to hold ConnEvents harmless from any and all damages (direct, indirect, incidental, consequential, or otherwise), losses, liabilities, costs, and expenses of any kind and nature, known and unknown, arising out of a dispute between you and a third party (including other Users) in connection with the Services or any event listed on the Services. You also agree to waive any applicable law or statute that states, in part: "A GENERAL RELEASE DOES NOT EXTEND TO CLAIMS WHICH THE RELEASING PARTY DOES NOT KNOW OR SUSPECT TO EXIST IN HIS FAVOR AT THE TIME OF EXECUTING THE RELEASE, WHICH IF KNOWN BY HIM MUST HAVE MATERIALLY AFFECTED HIS SETTLEMENT WITH THE RELEASED PARTY."\n\n'
                          )
                        ]
                    )),
                RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        text: 'Indemnification',
                        style: gilroyBold,
                        children: [
                          TextSpan(
                              style:gilroyLight ,
                              text:'You agree to defend, indemnify, and hold ConnEvents and each of its and their respective officers, directors, agents, co-branders, licensors, payment processing partners, other partners, and employees harmless from any and all damage, loss, liability, cost, and expense (including, without limitation, reasonable attorneys’, and accounting fees) resulting from any claim, demand, suit, or proceeding (whether before or after the event)."\n\n'+
                                  "             * your violation of the Terms (including any terms or agreements or policies incorporated into these Terms);\n\n"+
                                  "             *  your use of the Services in contravention of \n"
                                      "                these Terms or any other policies we \n"
                                      "                 publish or make available; \n\n "+
                                  "             * your violation of any relevant local, state, \n "
                                      "               provincial, national, or international law\n"
                                      "               rule, or regulation, or any third-party right;\n\n"+
                                  "             * ConnEvents' tax collection and remittance; and  \n\n "
                                      "             * if you are an Organizer, your events (including \n"
                                      "               where ConnEvents has provided Services with\n"
                                      "                 respect to those events\n"
                                      "               ), provided that in the case of (e), this \n"
                                      "               indemnification will not apply to the extent \n"
                                      "            that the Claim arises from ConnEvents' \n"
                                      "             gross negligence or willful misconduct.\n\n"

                          )

                        ]
                    )),




                Text("ConnEvents will notify you of any such Claim; but ConnEvents' failure or delay in delivering such notice will not reduce your duties hereunder unless you are materially harmed as a result of such failure. ConnEvents may also choose to manage the Claim itself in certain instances, in which case you agree to comply with ConnEvents in any way we require.\n\n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),
                Text('⦁	Disclaimer of Warranties and Assumption of Risks by You',style: gilroyBold),
                Text('We attempt to deliver Services in the manner in which you require them, but there are some things that you should be aware of that we cannot guarantee\n\n'+
                    'The Services are provided "as is" and "as available" to the degree permitted by relevant laws. ConnEvents expressly disclaims all express and implied warranties of any kind, including but not limited to implied warranties of merchantability, title, non-infringement, and fitness for a particular purpose. ConnEvents, for example, gives no guarantee that:\n',
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),

                Text(
                  "             * The Services (or any portion thereof) will\n"
                      "                 satisfy your needs or expectations;\n\n"+
                      "             * The Services will be available at all times,\n"
                          "                 will be secure, or will be error-free; or\n\n "
                          "             * The results produced from using the Services\n"
                          "                    will be accurate or trustworthy.\n\n",
                  style: gilroyLight,
                ),

                Text("You acknowledge that ConnEvents has no control over, and does not guarantee, the quality, safety, accuracy, or legality of any event or event-related Content, the truth or accuracy of any information provided by Users (including the Consumer's personal information shared with Organizers in connection with events), or any User's ability to perform or actually complete a transaction. ConnEvents has no responsibility to you for the acts or omissions of any third parties that ConnEvents requires to provide the Services, that an Organizer chooses to assist with an event, or that you choose to contract with when using the Services, and hereby disclaims all liability arising from such acts or omissions.\n\n"+
                    "You acknowledge and agree that some events may involve inherent risk, and that by participating in those events, you freely accept those risks. Some events, for example, may include the risk of illness, bodily harm, disability, or death, which you freely and willingly accept by participating in those events.\n\n"+
                    "To the fullest extent permissible by law, the preceding disclaimers apply. Other statutory rights may apply to you. The period of any statutorily required warranties, if any, will, however, be reduced to the extent authorized by law.\n\n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),
                Text('Limitation of Liability',style: gilroyBold),
                Text("ConnEvents and any person or organization affiliated with ConnEvents' provision of the Services (e.g., an affiliate, vendor, strategic partner, or employee) ('Associated Parties') will not be liable to you or any third party, to the extent permitted by applicable laws or as otherwise set forth below:\n\n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),
                Text(
                  "    *  Any indirect, incidental, special, consequential,\n"
                      "       punitive, or exemplary damages, such as damages\n"
                      "       for loss of profits, goodwill, use, data, opportunity\n"
                      "       costs, intangible losses, or the cost of substitute\n"
                      "       services (even if ConnEvents has been advised \n"
                      "       of the possibility of such damages); or \n\n"
                      "    *  Your Content, except for ConnEvents' duty to pay\n"
                      "       out Event Registration Fees to certain organizers in\n"
                      "       specific circumstances and only in accordance\n "
                      "       with the provisions therein.\n"
                  , style: gilroyLight,
                ),
                Text("Refund warning: All refund requests for tickets that are refundable should be made a day (24 hours) before the date of that event. Any request after that period will not be granted by the organizer because organizers will be able to withdraw their money from the app by 12am on the day of the event. All requests after that will require ConnEvents' assistance if the organizer doesn't respond. \n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),
                Text(
                  "    * 	We reserve the right to ask or demand that\n"
                      "       organizers honor the refund promised to customers\n "
                      "       if a refundable ticket was registered at the\n "
                      "       creation of the event and refund request was \n "
                      "       made in a timely manner as described. If the ticket\n "
                      "       was refundable, the customer will request a refund\n "
                      "       and the organizer will have to accept the refund.\n "
                      "       Failure to do so, the app will flag that, and\n "
                      "       organizer won't be able to withdraw until honoring\n"
                      "       the refund.\n"

                  , style: gilroyLight,
                ),
                Text(
                  "    *  If the event ticket was non-refundable, organizers\n "
                      "       reserve the right to not respond to customers since \n "
                      "       customers won’t have the right to request for\n "
                      "       refund  because customers won't have any option\n "
                      "       to ask for  a refund in the app system.\n "
                      "       Customers have an option of reaching out directly\n "
                      "       to the organizer, but it won't be registered in the\n"
                      "       app system.\n"
                  , style: gilroyLight,
                ),

                Text("Nothing in these Terms is intended to restrict or exclude any condition, guarantee, right, or responsibility that cannot be legally limited or excluded. Certain guarantees or conditions, as well as the limitation or exclusion of liability for loss or damage caused by deliberate conduct, carelessness, breach of contract or breach of implied terms, or incidental or consequential damages, are prohibited in some jurisdictions. As a result, only the liability and other limits that are permissible in your jurisdiction (if any) will apply to you, and our liability will be limited to the extent authorized by law.\n\n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),

                Text('    *  Agreement to Arbitrate.',style: gilroyLight),
                Text("If our customer support team is unable to resolve your concerns, the parties (you and we) hereby agree to resolve any and all disputes or claims arising out of or relating to these Terms, the Services, or our relationship through binding arbitration or small claims court (to the extent the claim qualifies), rather than in courts of general jurisdiction, and only on an individual basis.\n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),
                Text('    * Scope of Agreement',style: gilroyLight),
                Text("This agreement to arbitrate is meant to cover a wide range of legal issues between you and us. It includes, but is not limited to: (i) all claims arising out of or relating to any aspect of our relationship, whether based on contract, tort, statute, fraud, misrepresentation, or any other legal theory; (ii) all claims that arose prior to this or any prior agreement (including, but not limited to, advertising claims); and (iii) all claims that may arise after termination of these Terms and/or your use of the Services.\n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),
                Text('    * Exceptions.',style: gilroyLight),
                Text("Regardless of this Agreement to Arbitrate, either party may (i) bring an action in small claims court (to the extent the applicable claim qualifies); or (ii) bring enforcement actions, validity determinations, or claims arising from or relating to theft, piracy, or unauthorized use of intellectual property in state or federal court in the United States Patent and Trademark Office to protect its Intellectual Property Rights in state or federal court in the United States Patent and Trademark Office to protect its Intellectual Property Rights ('Intellectual Property Rights' means patents, copyrights, moral rights, trademarks, and trade secrets, but not privacy or publicity rights).\n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),
                Text('    * No Class Actions.',style: gilroyLight),
                Text("YOU AND CONNEVENTS AGREE THAT YOU AND CONNEVENTS MAY BRING CLAIMS AGAINST EACH OTHER ONLY IN YOUR OR ITS INDIVIDUAL CAPACITY, NOT AS A PLAINTIFF OR CLASS MEMBER IN ANY PURPORTED CLASS, CONSOLIDATED, OR REPRESENTATIVE PROCEEDING. THE ARBITRATOR MAY NOT CONSOLIDATE MORE THAN ONE PERSON'S CLAIMS, MAY NOT PRESIDE OVER ANY KIND OF CLASS, CONSOLIDATED, OR REPRESENTATIVE PROCEEDING, AND MAY ONLY PROVIDE RELIEF IN FAVOR OF THE INDIVIDUAL PARTY SEEKING RELIEF, AND ONLY TO THE EXTENT NECESSARY TO PROVIDE RELIEF WARRANTED BY THAT PARTY'S INDIVIDUAL CLAIM.\n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),
                Text('    * Notice of Dispute.',style: gilroyLight),
                Text("A party seeking arbitration must first send a written Notice of Dispute to the other party ('Notice'). The Notice to ConnEvents must be addressed to and transmitted by certified mail to the following address ('Notice Address'): 3915 S Kennedy Dr, Bloomington, IN 47401.\n\n"+
                    "Notice to you will be sent by certified letter to a postal, home, or payment address that ConnEvents has on file for you. If ConnEvents does not have a record of such a physical address, the notice may be sent to the email address associated with your ConnEvents account. The Notice must I identify the nature and basis of the claim or dispute, and (ii) specify the relief requested. You or ConnEvents may initiate an arbitration procedure if you and ConnEvents do not reach an agreement to resolve the claim within thirty (30) calendar days of receiving the Notice.\n\n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),

                Text('    * Arbitration Proceedings.',style: gilroyLight),
                Text("The arbitration will be governed by the Commercial Arbitration Rules of the American Arbitration Association ('AAA'), as modified by this Section, or the Consumer Arbitration Rules of the American Arbitration Association ('AAA'), if the actions giving rise to the dispute or claim relate to your personal or household use of the Services (rather than business use) and will be administered by the AAA and settled by a single arbitrator. The arbitrator will decide any issues in dispute between the parties, including, but not limited to, issues relating to the scope, enforcement, and arbitrability of this Section.\n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),
                Text('    * Location of Arbitration Proceedings.',style: gilroyLight),
                Text("Parties to a dispute will agree to the location of proceedings and if not, the AAA will choose a location for them.\n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),
                Text('    * Costs of Arbitration; Legal Fees.',style: gilroyLight),
                Text("The AAA regulations will govern the payment of all filing, administration, and arbitrator costs and expenditures imposed by the organization. If the arbitrator finds that all of your claims in arbitration are frivolous, you undertake to reimburse ConnEvents for all costs and expenses that ConnEvents paid and that you would have been responsible for under the AAA rules.\n\n"+
                    "In any arbitration, each party will initially incur its own attorneys' fees and expenses, just as in any court case. If any party is found to have significantly succeeded in the arbitration, the arbitrator will award the successful party reasonable attorneys' costs and expenses expended in connection with the arbitration upon its request.\n\n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),
                Text('    * Location of Arbitration Proceedings.',style: gilroyLight),
                Text("Parties to a dispute will agree to the location of proceedings and if not, the AAA will choose a location for them.\n\n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),
                Text('    * Costs of Arbitration; Legal Fees.',style: gilroyLight),
                Text("The AAA regulations will govern the payment of all filing, administration, and arbitrator costs and expenditures imposed by the organization. If the arbitrator finds that all of your claims in arbitration are frivolous, you undertake to reimburse ConnEvents for all costs and expenses that ConnEvents paid and that you would have been responsible for under the AAA rules.\n\n"+
                    "In any arbitration, each party will initially incur its own attorneys' fees and expenses, just as in any court case. If any party is found to have significantly succeeded in the arbitration, the arbitrator will award the successful party reasonable attorneys' costs and expenses expended in connection with the arbitration upon its request.\n\n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),
                Text('    * Future Changes',style: gilroyLight),
                Text("You and ConnEvents agree that if ConnEvents makes any future change to this arbitration provision (other than a change to the Notice Address), ConnEvents will provide you with notice of such change, and you may reject any such change by sending us written notice within thirty (30) calendar days of the change to the Notice Address provided above. By rejecting any future change, you agree to arbitrate any dispute between us in accordance with the language of this clause as it stands now, unaffected by the rejected change.\n\n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),
                Text('    * Special Severability.',style: gilroyLight),
                Text("If any of the provisions of this Section are determined to be unlawful or unenforceable for any dispute or claim, the entire Section will be null and void with respect to that dispute or claim, and Section 20 will take its place\n\n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),
                Text('    * Opt Out.',style: gilroyLight),
                Text("You have the right to opt out of the arbitration and class action waiver provisions set out above by submitting written notice of your desire to opt-out to TermsofUse@connevents.com (from the email address we identify with you as a User). Otherwise, you will be compelled to arbitrate disputes in accordance with the terms of those paragraphs until you send the notice within thirty (30) days of your first use of the Services or your consent to these Terms (whichever comes first). ConnEvents will not be bound by these arbitration provisions if you want to opt out of them.\n\n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),
                Text('    License to the ConnEvents Services.\n',style: gilroyExtraBold),
                RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        text: 'License to Services. ',
                        style: gilroyBold,
                        children: [
                          TextSpan(
                              style:gilroyLight ,
                              text:'. We provide you a revocable limited, non-exclusive, non-transferable, non-sublicensable (save to sub-Users registered via the Services) license to use our Services solely for the purposes described in this Agreement."\n\n'
                          )
                        ]
                    )),

                Text(
                  "    *  search for, view, register for, or buy tickets or \n"
                      "       registrations to an event listed on the Services;\n"
                      "       and/or\n "

                  , style: gilroyLight,
                ),
                Text(
                  "    *  establish event registration, organizer profiles, and\n "
                      "       other webpages to promote, market, manage,\n "
                      "       track, and collect sales profits for an event listed\n"
                      "       on the Services.\n "

                  , style: gilroyLight,
                ),
                Text(
                  "These Terms, as well as all applicable local, state, provincial, national, and other laws, rules, and regulations, must be followed when using the Services. You are also bound by the Google Maps/Google Earth Additional Terms of Service if you use any search capabilities or address auto-population technologies (including the Google Privacy Policy).\n\n "
                  , style: gilroyLight,
                ),
                RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        text: 'Restrictions on Your License',
                        style: gilroyBold,
                        children: [
                          TextSpan(
                              style:gilroyLight ,
                              text:'.Without limitations on other restrictions, limitations, and prohibitions that we impose (in these Terms or elsewhere), you agree you will not directly or indirectly"\n\n'
                          )
                        ]
                    )),

                Text("      copy, modify, reproduce, translate, localize, port,\n"
                    "      or otherwise create derivatives of any part of the\n"
                    "      Services;\n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),

                Text("      reverse engineer, disassemble, decompile or\n"
                    "      otherwise attempt to discover the source code\n"
                    "      or structure,sequence and organization of all\n"
                    "      or any part of theServices;\n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),

                Text("      rent, lease, resell, distribute, use the\n"
                    "      Services for othercommercial purposes not\n"
                    "      contemplated or otherwiseexploit the Services\n"
                    "      in any unauthorized manner;\n\n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),

                Text("       remove or alter any proprietary notices on the\n"
                    "       Services; or \n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),

                Text("       engage in any activity that interferes with\n"
                    "       or disrupts the Services. \n\n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),

                RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        text: 'Our Intellectual Property and Copyrights:',
                        style: gilroyBold,
                        children: [
                          TextSpan(
                              style:gilroyLight ,
                              text:'. You acknowledge that copyrights, trademarks, service marks, trade secrets, and other intellectual property and proprietary rights and laws may apply to all Site Content. ConnEvents may own the Site Content, or ConnEvents may have access to elements of the Site Content through third-party agreements. ConnEvents owns all of the Site Content that is incorporated in or made available through the Services, and it is protected by copyright laws. You undertake to only use the Site Content in accordance with these Terms and any applicable local, state, provincial, national, or other law, rule, or regulation. Any rights not expressly granted are reserved in this document"\n\n'
                          )
                        ]
                    )),
                RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        text: 'Trademarks:',
                        style: gilroyBold,
                        children: [
                          TextSpan(
                              style:gilroyLight ,
                              text:'. ConnEvents trademarks, service marks, and logos (the "ConnEvents Trademarks") are registered and unregistered trademarks or service marks of ConnEvents that are used and displayed in connection with the Services. Other company, product, and service names used in conjunction with the Services could be third-party trademarks or service marks (the "Third Party Trademarks," and, collectively with ConnEvents Trademarks, the "Trademarks"). The provision of the Services does not provide, by implication, estoppel, or otherwise, any license or right to use any Trademark shown in connection with the Services without ConnEvents prior written authorization for each such use. The Trademarks may not be used in any way that disparages ConnEvents, any third party, or ConnEvents or such third party"s products or services, or in any way that damages the Trademarks goodwill. The use of any Trademarks as part of a link to or from any site is prohibited unless ConnEvents permits the establishment of such a link in writing prior to the link being established. ConnEvents will benefit from all goodwill generated by the use of any ConnEvents Trademark. The Services are covered by a number of issued and pending patents. Copyrights owned by ConnEvents and/or other parties may also protect Site Content. Please be aware that copying sections of the Services infringes on these patent and copyright rights.\n\n'
                          )
                        ]
                    )),

                RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        text: 'Use of Sub-domains.',
                        style: gilroyBold,
                        children: [
                          TextSpan(
                              style:gilroyLight ,
                              text:'. ConnEvents may grant you permission to utilize a sub-domain on the Site for a certain event. ConnEvents retains sole ownership of all such sub-domains and reserves the right to choose their appearance, design, functioning, and any other elements. If ConnEvents provides you with a sub-domain, you will be able to use it only as long as your event is actively selling on the Services and you are in compliance with the Terms, including these Terms of Service. ConnEvents will provide you with a new sub-domain if your permission to use a sub-domain is terminated for any other reason.\n\n'
                          )
                        ]
                    )),



                Text('Licenses and Permits Organizers Must Obtain\n',style: gilroyExtraBold),
                Text('If you are an Organizer, you represent and warrant to us, without limiting the generality of any other representations or warranties made elsewhere in these Terms of Service, that\n\n',style: gilroyLight),


                Text("      With respect to events hosted by you or your\n"
                    "      affiliates on the Services, you and your affiliates\n"
                    "      will obtain allrelevant licenses, permits, and\n"
                    "      authorizations(individually and collectively,\n"
                    "      'Licensure') prior to thestart of ticket sales.\n"
                    "      Property operation permits andfire marshal permits,\n"
                    "       are examples of licensure.\n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),
                Text("     You and your affiliates will comply with all\n"
                    "     applicable laws, regulations, rules, and ordinances,\n"
                    "     and will ensure that the venues for any event hosted\n"
                    "     by you or your affiliates on the Services will comply;\n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),
                Text("     You will only request that ConnEvents offer \n"
                    "     tickets to an event after you have obtained any\n"
                    "     specific Licensures for the event, such as any\n"
                    "     state, county, municipal, or other local authority's\n"
                    "     authorization of the event, traffic engineering\n"
                    "     authorizations, fire department inspection reports,\n"
                    "     authorization toreceive minors (if applicable),\n"
                    "     sanitary authorization (if applicable), and any other\n"
                    "     potential applicableauthorization; and\n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),
                Text("    you and your affiliates will maintain in force\n"
                    "    throughout  the term of access to the Servicen\n"
                    "    the applicable Licensure for organizer to promote,\n"
                    "    produce, sponsor host, and sell tickets for all events\n"
                    "    hosted by you or your affiliates on the Services.\n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),

                Text("Without limiting the generality of any release provided under these Terms of Service, as a material inducement to ConnEvents permitting you to access and use the Services, you hereby agree to release ConnEvents, and its affiliates and subsidiaries, and each of its and their respective parent companies, subsidiaries, officers, affiliates, representatives, shareholders, contractors, directors, agents, partners and employees from all damages (whether direct, indirect, incidental, consequential or otherwise), losses, liabilities, costs and expenses of every kind and nature, including, without limitation, attorneys' fees, known and unknown, arising out of or in any way connected with your or your affiliates' Licensure, any failure to obtain or maintain any Licensure, or any error in obtaining or maintaining any Licensure.\n\n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),
                Text("Without limiting your indemnification obligations elsewhere under these Terms of Service, you agree to defend, indemnify and hold ConnEvents, and its affiliates and subsidiaries, and each of its and their respective officers, directors, agents, co-branders, licensors, payment processing partners, other partners and employees, harmless from any and all damage (whether direct, indirect, incidental, consequential or otherwise), loss, liability, cost and expense (including, without limitation, reasonable attorneys' and accounting fees) resulting from any Claim due to or arising out of your or your affiliates' Licensure, any failure to obtain or maintain any Licensure, or any error in obtaining or maintaining any Licensure. You agree to provide evidence of Licensure and related information prior to offering tickets or registrations for events on the Site and promptly upon the reasonable request of ConnEvents from time to time.\n\n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),


                Text('Your Rights to Submit a Copyright Takedown Notice',style: gilroyBold),
                Text("If you feel that any content on the Sites infringes on your copyrights and you are a copyright owner or an agent of a copyright owner, you may file a notice under the Digital Millennium Copyright Act ('DMCA') by following the instructions in ConnEvents' Trademark and Copyright Policy.\n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),
                Text('Scraping or Commercial Use of Site Content is Prohibited',style: gilroyBold),
                Text("The Site Content is not meant to be used for commercial purposes. You have no right to utilize any Site Content for your own commercial purposes, and you agree not to do so. You have no right to scrape, crawl, or use any automated means to obtain data from the Site, and you agree not to do so (s).\n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),
                Text('Business Transfers.',style: gilroyBold),
                Text("We may sell or buy businesses or assets as our company grows. Personal Data may be part of the transferred assets in the event of a corporate sale, merger, reorganization, dissolution, or similar event. In the event of such an event, we may also disclose your Personal Data as part of our due diligence. You agree that any successor to ConnEvents (or its assets) shall have the right to use your Personal Data and other information in line with the provisions of this Privacy Policy\n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),
                Text('Fees',style: gilroyExtraBold),
                RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        text: 'Fees That We Charge.',
                        style: gilroyBold,
                        children: [
                          TextSpan(
                              style:gilroyLight ,
                              text:'It is completely free to create an account, list an event, and use the Services. When you sell or acquire paid tickets or registrations, however, we charge a fee between 1.5-2% plus \$0.50 (additional 2.9% plus \$0.30 for Credit/Debit Card Processing Fees may be applied) on each purchased ticket. Individual agreements between ConnEvents and select Organizers may affect these fees. Organizers ultimately decide whether these fees will be passed on to consumers and displayed as "Fees" on the relevant event page, or whether they will be absorbed into the ticket or registration price and paid by the Organizer from ticket and registration gross proceeds. Other fees that may be charged to Consumers include, but are not limited to, facility fees, royalties, taxes, processing fees, and fulfillment fees. As a result, the fees charged by ConnEvents to the applicable Organizer, or the standard fees specified on the Services to Organizers are not always the same as the fees charged by Consumers for an event. Furthermore, certain fees are intended to cover certain costs borne by ConnEvents on an average basis but may involve an element of profit or loss in other situations. ConnEvents has no control over (and consequently cannot disclose) costs imposed by your bank or credit card company, such as fees for purchasing tickets and registrations in foreign currencies or from foreign individuals. Before engaging in a transaction, be sure you understand all applicable fees, credit card surcharges, and currency conversion rates by checking with your bank or credit card issuer\n\n'
                          )
                        ]
                    )),

                RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        text: 'Ticket Transfers.',
                        style: gilroyBold,
                        children: [
                          TextSpan(
                              style:gilroyLight ,
                              text:"If you want to transfer tickets to an event you bought on ConnEvents, ConnEvents may be able to help you. In all other cases, please contact the event's organizer to make arrangements for ticket transfers. Please contact us if you are unable to reach the Organizer or if the Organizer is unable to facilitate a ticket transfer.\n\n"
                          )
                        ]
                    )),

                RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        text: 'Refunds',
                        style: gilroyBold,
                        children: [
                          TextSpan(
                              style:gilroyLight ,
                              text:"ConnEvents urges that all Consumers contact the applicable Organizer of their event with any refund requests because all transactions are between an Organizer and its associated attendees.\n"
                          )
                        ]
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Refunds Policy\n',style: gilroyExtraBold),
                  ],
                ),

                Text("ConnEvents urges that all Consumers contact the applicable Organizer of their event with any refund requests because all transactions are between an Organizer and its associated attendees.\n\n"+
                    "The user can seek a refund from the digital ticket, which will appear on the organizer's account.\n\n"+
                    "If you are a Consumer, you agree that if your ticket is refunded, you will throw away any ticket that we or any Organizer has delivered and will not use it (or any copy of it) to attend the event. Fraud is defined as a violation of the above. You acknowledge that the proper procedure for checking the ticket's validity must be followed at all times. ConnEvents will not be held liable under any circumstances for any expenditures incurred as a result of Organizers' failure to follow required processes for checking ticket validity. ConnEvents shall not be held liable under any circumstances for costs and/or damage incurred as a result of ticket fraud or damage incurred as a result of purchasing a ticket through non-official means, such as third parties.\n\n"+
                    "If you are an Organizer, you recognize that the applicable method for checking the ticket's validity must be followed at all times. ConnEvents will not be held liable under any circumstances for any expenditures incurred as a result of Organizers' failure to follow required processes for checking ticket validity. ConnEvents shall not be held liable under any circumstances for costs and/or damage incurred as a result of ticket fraud or damage incurred as a result of purchasing a ticket through non-official means, such as third parties.\n\n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),
                Text('Your Account with ConnEvents\n',style: gilroyBold),
                Text('To access certain features or functions of the Services, you may be required to create an account. When you register an account with ConnEvents or use the Services, you agree to observe certain guidelines, including the following:\n',style: gilroyLight),

                Text("    To use the Services, you must be at least 18 years\n"
                    "    old, or the legal age of majority in your jurisdiction.\n"
                    "    You must use the Services under the supervision of a\n"
                    "    parent or legal guardian who manages your use \n"
                    "    and/or account if you are 13 or older. If you are \n"
                    "    under the age of 13, please do not give us with any\n"
                    "    personal information. \n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),

                Text("    If you are using the Services on behalf of an entity,\n"
                    "    you undertake to submit true, accurate, current, and\n"
                    "    complete information about the entity (the\n"
                    "   'Registration Data'). You also promise to keep this\n"
                    "    Registration Data up to date if anything changes.\n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),

                Text("    ConnEvents will be the sole arbiter of account\n"
                    "    ownership disputes between two or more persons or\n"
                    "    entities, and ConnEvents' decision (which may\n"
                    "    include account termination or suspension) will be\n"
                    "    final and binding on those parties.\n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),

                Text("   If you are using the Services on behalf of a company\n"
                    "   or other entity, you represent and warrant that you\n"
                    "   have the legal power to bind that entity to these\n"
                    "   Terms and grant ConnEvents any permissions and\n"
                    "   licenses set forth in these Terms.\n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),

                Text("   We may give you the opportunity to give third-party\n"
                    "   users, such as 'sub-users,' 'sub accounts,' or other\n"
                    "   credentialed account users, certain permission within\n"
                    "   your account. If we do so, you agree that you are\n"
                    "   solely responsible for all for all activity that occurs\n"
                    "   your account(including activities by sub-users), and\n"
                    "   that you will keep your password and account\n"
                    "   information secure. You also agree that restrictions\n"
                    "   that apply to your account will apply to any third\n"
                    "   parties to whom you allow access.\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight,),

                Text("   You undertake to alert ConnEvents immediately of\n"
                    "   any unauthorized use of your password or account,\n"
                    "   or any other security violation.\n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),

                Text("   You agree not to use our services to collect any\n"
                    "   sensitive personal information, such as health\n"
                    "   information, social security numbers, financial\n"
                    "   information, payment card numbers, driver's\n"
                    "   license numbers, or passwords, unless otherwise\n"
                    "   permitted by these Terms or ConnEvents has\n"
                    "   consented in writing.\n\n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),

                Text('Your Interests\n',style: gilroyBold),
                Text("   Users can choose their events interest or skip while\n"
                    "   signing up, If you choose to skip, you can choose your\n"
                    "   events interest later in the app.\n"
                    "   Notifications will be sent to users when an event that\n"
                    "   is under the category of their interest is posted if\n"
                    "   their notification is enabled.\n\n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),

                Text('Your Content\n',style: gilroyBold),
                RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        text: 'License',
                        style: gilroyBold,
                        children: [
                          TextSpan(
                              style:gilroyLight ,
                              text:". ConnEvents makes no claim to the content you provide. Your Content, on the other hand, is totally your responsibility. You hereby grant ConnEvents a non-exclusive, worldwide, perpetual, irrevocable, royalty-free, transferable, sublicensable right and license to access, use, reproduce, transmit, adapt, modify, perform, display, distribute, translate, publish, and create derivative works based on Your Content, in whole or in part, in any media, for the purpose of operating the Services (including ConnEvents' promotional and marketing services, which may include, without limitation, promotional and marketing services). Despite the foregoing, ConnEvents does not claim ownership of any of Your Content, and you do not transfer ownership of any of Your Content to ConnEvents, and nothing in these Terms of Service will limit any rights you may have to use and exploit Your Content outside of the Services.\n"
                          )
                        ]
                    )),

                RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        text: 'Your Representations About Your Content',
                        style: gilroyBold,
                        children: [
                          TextSpan(
                              style:gilroyLight ,
                              text:" You represent and warrant that you have all necessary rights, power, and authority to grant the aforesaid license, and that all of Your Content: \n"
                          )
                        ]
                    )),
                Text("   (a)	is accurate and complete.\n"
                    "   (b)	does not infringe, violate, misappropriate, or\n"
                    "         otherwise interfere with any third party's rights;\n"
                    "   (c)	follows all applicable local, state, provincial,\n"
                    "        national, and international laws, rules and\n"
                    "        regulations; and\n\n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),

                RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        text: 'Additional Rules About Your Content.',
                        style: gilroyBold,
                        children: [
                          TextSpan(
                              style:gilroyLight ,
                              text:"Your content must be true and accurate. ConnEvents retains the right to remove Your Content from the Services if ConnEvents believes it violates these Terms or for any other reason in its sole discretion. ConnEvents may use your name and logo (whether or not you have made it available through the Services) on the Services and in marketing, advertising, and promotional materials to identify you as a current or past customer of ConnEvents. We may also keep and share Your Content and account information if required by law or if we have a good faith opinion that such preservation or disclosure is reasonably necessary to:\n"
                          )
                        ]
                    )),

                Text("   (a) comply with legal process;\n"
                    "   (b)	respond to claims that any of Your Content \n"
                    "         violates the rights of third parties;\n"
                    "   (c)	enforce or administer the Terms of Service,\n"
                    "         including without limitation, these Terms of\n"
                    "         Service; and/or\n"
                    "   (d)	protect the rights, property and/or personal\n"
                    "         safety of ConnEvents, its users and/or the\n"
                    "         public, including fraud prevention.\n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),

                Text("   You acknowledge that the technical processing and\n"
                    "   transmission of the Services, including Your Content,\n"
                    "   may entail transmissions across multiple networks \n"
                    "   and/or changes to conform and adapt to technical\n"
                    "   requirements of connecting networks or devices.\n\n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),

                Text('Rules for Use of Email Tools\n\n',style: gilroyBold),
                Text("   ConnEvents may make services and resources\n"
                    "   email saccessible to you that allow you to send\n"
                    "   send emails to your Consumers, other users\n"
                    "   of the Services, or other parties (the 'Email Tools').\n"
                    "   You represent and agree that if you use Email Tools:\n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),

                Text("   (a) You have the right and power to send emails\n"
                    "   	     to the addresses on your recipient list, and\n"
                    "          those addresses were collected in compliance\n"
                    "          with the recipient's country of residence's\n"
                    "          email marketing legislation;\n"
                    "   (b)  your emails are not sent in violation of any\n"
                    "          privacy policies that were used to collect\n"
                    "          the recipient's emails;\n"
                    "   (c)	 you will use the Email Tools in accordance\n"
                    "          with all applicable local, state, provincial,\n"
                    "          national, and international laws, rules, and\n"
                    "          regulations, including those relating to spam\n"
                    "          and email, such as the CAN-SPAM Act in the\n"
                    "          United States, the Canadian CASL, and\n"
                    "          the EU GDPR and e-privacy directive;\n"
                    "   (d)	 you will only use the Email Tools to promote,\n"
                    "          market, and/or administer a legitimate\n"
                    "          event that is listed on the Services;\n"
                    "   (e)	 your use of the Email Tools, as well as the\n"
                    "          content of your communications, is in\n"
                    "          accordance event that is listed on the Services;\n"
                    "          with these Terms;\n"
                    "   (f)	  you shall not use deceptive subject lines\n"
                    "          or false or misleading headers in emails\n"
                    "          sent using the Email Tools;\n"
                    "   (g)	  you will react promptly and in line with\n"
                    "          ConnEvents' instructions to any Consumer who\n"
                    "          requests that you change such Consumer's email\n"
                    "          settings;\n"
                    "   (h)	  In every email where one is necessary, you will\n"
                    "          include an easily available and unconditional\n"
                    "          unsubscribe link, and you will not send any email\n"
                    "          to anyone who has unsubscribed from your\n"
                    "          mailing list.\n\n"
                    ,
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),
                Text("   If you violate any of these Email Tools rules, or if\n"
                    "   your use of the Email Tools results in bounce rates,\n"
                    "   complaint rates, or unsubscribe requests that are\n"
                    "   higher than than industry standards, or if your emails\n"
                    "   cause the Services to be disrupted, ConnEvents may\n"
                    "   may limit or suspend your access to the Email Tools\n",
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),

                RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        text: 'Organizer Emails.\n',
                        style: gilroyBold,
                        children: [
                          TextSpan(
                              style:gilroyLight ,
                              text:"We allow Organizers to use our email facilities to contact Consumers for current and past events, therefore you may receive emails from our system that are sent on their"
                                  " behalf by such Organizers. If you registered for an event through the Services, the Organizer has access to your email address. "
                                  "Organizers may, however, import email addresses from external sources and send emails to those addresses through the Services, and we will deliver those communications on the Organizer's behalf. "
                                  "ConnEvents is not responsible for sending these emails; instead, it is the organizer's responsibility.\n\n"
                                  "Organizers will not have access to any other user/consumers' personal information (except followers’ emails), however, there is"
                                  " a built-in direct message in the app where everyone (user-user or user-organizer) can connect.\n\n"
                                  "Notifications will be sent to users when an event that is under the category of their "
                                  "interest is posted if their notification is enabled\n"
                          )
                        ]
                    )),

                RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        text: 'Notices\n',
                        style: gilroyBold,
                        children: [
                          TextSpan(
                              style:gilroyLight ,
                              text:"ConnEvents may send you notices by email or normal mail to the address on "
                                  "file with ConnEvents. The Services may also provide you with notices "
                                  "of changes to these Terms or other matters by displaying notices "
                                  "or links to notices on the Services in general. If you need to contact ConnEvents "
                                  "or deliver a notice, you can do so at:\n\n"
                                  "Support@connevents.com\n\n"
                                  "Connevents@gmail.com\n\n"
                          )
                        ]
                    )),

                RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        text: 'Modifications to the Terms or Services\n\n',
                        style: gilroyBold,
                        children: [
                          TextSpan(
                              style:gilroyLight ,
                              text:"ConnEvents has the right to make changes to these Terms at any time (collectively, 'Modifications')."
                                  " If we believe the Modifications are significant, we will notify you by one (or more) of the following methods:\n"
                          )
                        ]
                    )),
                Text("   (a) posting the changes through the Services.\n"
                    "   (b)	updating the 'Updated' date at the top of \n"
                    "         this page; or\n"
                    "   (c)	sending you an email or message about the\n"
                    "         Modifications.\n"
                    ,
                    textAlign: TextAlign.justify,
                    style: gilroyLight ),

                RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        children: [
                          TextSpan(
                              style:gilroyLight ,
                              text:"Any Modifications are your responsibility to evaluate and get comfortable with. "
                                  "Your continued use of the Services after the Modifications indicates that you agree to the Modifications "
                                  "and the revised Terms. ConnEvents may seek a modification to these Terms that will only apply to you "
                                  "in specified circumstances. This type of modification must be made via a written or electronic document "
                                  "signed by both you and a ConnEvents authorized authority. ConnEvents' products and services are always "
                                  "growing to better meet the demands of our users. As a result, we cannot guarantee that specific product "
                                  "features or functionality will be available. ConnEvents has the right to change, replace, or terminate "
                                  "any element of the Services, or the entire Service, at any time.\n"
                          )
                        ]
                    )),

                RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        text: 'Assignment.\n\n',
                        style: gilroyBold,
                        children: [
                          TextSpan(
                              style:gilroyLight ,
                              text:"We may, without your consent or approval, freely assign these Terms and our rights and obligations under these Terms whether to an affiliate or to another entity in connection with a corporate transaction or otherwise.\n"
                          )
                        ]
                    )),

                RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        text: 'Entire Agreement.\n\n',
                        style: gilroyBold,
                        children: [
                          TextSpan(
                              style:gilroyLight ,
                              text:"Except as otherwise set forth herein, these Terms constitute the entire agreement between you and ConnEvents and govern your use of the Services, superseding any prior or contemporaneous agreements, proposals, discussions, or communications between you and ConnEvents on the subject matter hereof, other than any written agreement for Services between you and an authorized officer of ConnEvents relating to a specified event or events.\n"
                          )
                        ]
                    )),

                RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        text: 'Applicable Law and Jurisdiction\n\n',
                        style: gilroyBold,
                        children: [
                          TextSpan(
                              style:gilroyLight ,
                              text:"These Terms are governed by the laws of the State of Indiana, without regard to its conflict of laws rules. These laws will apply no matter where in the world you live. But if you live outside of the United States, you may be entitled to the protection of the mandatory consumer protection provisions of your local consumer protection law. Thus, for any actions not subject to arbitration, you and ConnEvents agree to submit to the personal jurisdiction of the federal or state courts (as applicable) located in the United States.\n"
                          )
                        ]
                    )),
                RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        text: 'Feedback\n\n',
                        style: gilroyBold,
                        children: [
                          TextSpan(
                              style:gilroyLight ,
                              text:"We welcome and encourage you to provide feedback, comments, and "
                                  "suggestions for improvements to the Services ('Feedback')."
                                  " Any Feedback you submit to us will be considered non-confidential "
                                  "and non-proprietary to you. By submitting Feedback to us, you grant us "
                                  "a non-exclusive, worldwide, royalty-free, irrevocable, sub-licensable, perpetual "
                                  "license to use and publish those ideas and materials for any purpose, without compensation to you.\n\n"
                                  "Our mobile application is like a social media platform. You can like, share, and comment about events.\n\n"
                                  "We have also incorporated a live feature in the app where organizers can go live to give update on events such as cancellation, adding guests, or just checking in with users or hype an event. Live participants will be able to raise hands and ask questions to host/organizer. \n\n"
                          )
                        ]
                    )),
                RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        text: 'Third Party Applications; Linked Accounts; Third Party Offers\n\n',
                        style: gilroyBold,
                        children: [
                          TextSpan(
                              style:gilroyLight ,
                              text:"The Services may provide, or Users may provide, links to other Internet Applications or resources. Because ConnEvents has no control over such Applications and resources, you acknowledge and agree that ConnEvents is not responsible for the availability of such Applications or resources, and does not endorse and is not responsible or liable for any Content, advertising, offers, products, services or other materials on or available from such Applications or resources, or any damages or losses related thereto, even if such Applications or resources are connected with ConnEvents partners or third party service providers. \n\n"
                          )
                        ]
                    )),

                RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        text: 'Additional Miscellaneous Provisions\n\n',
                        style: gilroyBold,
                        children: [
                          TextSpan(
                              style:gilroyLight ,
                              text:"Failure to enforce any aspect of these Terms does not renounce our right to enforce that or any other provision of these Terms in the future. There will be no oral waivers, amendments, or modifications to these Terms.\n\n"
                                  "If any part of these Terms is deemed to be unenforceable, it will be restricted to the bare minimum required, while the remaining provisions will remain in full force and effect.\n\n"
                                  "The headings in these Terms are for reference only and have no legal or contractual significance.\n\n"
                                  "These Terms do not form any independent contractor, agency, partnership, joint venture, or other similar arrangement.\n\n"
                                  "Any of our rights and responsibilities under these Terms may be freely assigned by us.\n\n"
                                  "For your convenience, we may translate these Terms into different languages. If a conflict arises between the English and a translated version, the English version will take precedence.\n\n"
                          )
                        ]
                    )),
              ],
            ),
          ),
        )
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
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top:12.0),
                child: Text("ConnEvents is glad to have you here. We're a ticketing and registration platform devoted to connecting people from all over the world together through live events. People from all over the world can create, discover, share, and register for events using our platform, mobile apps, and services\n\n"+
                    ' When we say "Organizer" in this Privacy Policy, we mean those who use the Services to produce events for people who use the Services (a) to get information about or attend events ("Consumers"), or (b) for any other reason. In these Terms, "Users," "you," or "your" refers to organizers, consumers, and third parties who use our Services collectively.\n\n'+
                    'With respect to Personal Data (defined below) collected through the Services, ConnEvents is the responsible party.\n',
                    textAlign: TextAlign.justify,
                    style: gilroyLight),
              ),
              Text('Our Privacy Statement\n',style: gilroyExtraBold),
              Text('Application\n',style: gilroyBold),
              Text(" This Privacy Policy outlines our policies regarding information collected from Users on or via the Services that can be associated with, pertains to, or could be used to identify a person ('Personal Data'). We are committed to protecting the privacy of your Personal Data. As a result, we've developed our Privacy Policy. Please read this Privacy Policy carefully because it contains crucial information about your Personal Data and other data. \n\n"+
                  'As used in this Privacy Policy, "non-Personal Data" refers to any information that does not identify a person and/or cannot be used to identify a person. We may gather Non-Personal Data when you engage with the Services. Non-Personal Data is exempt from the limitations and requirements set forth in this Privacy Policy regarding our collection, use, disclosure, transfer, and storage/retention of Personal Data.\n',
                  textAlign: TextAlign.justify,
                  style: gilroyLight),
              Text('Personal Data That We Collect.',style: gilroyExtraBold),
              Text('We may gather Personal Data when you use or interact with us through the Services. This will be on our own behalf at times, and on behalf of an Organizer who is utilizing our Services to host an event at other times. This distinction is critical for the purposes of some data protection rules, and it is addressed in greater detail below.\n',
                  textAlign: TextAlign.justify,
                  style: gilroyLight),
              Text('Information Collected From All Users.',style: gilroyExtraBold),
              RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                      text: 'Information you provide to us: ',
                      style: gilroyBold,
                      children: [
                        TextSpan(
                            style:gilroyLight ,
                            text:'We gather Personal Data from all Users when they voluntarily supply it to the Services, such as when they register for access to the Services, contact us with questions, participate in one of our surveys, or browse or utilize certain portions of the Services. Your name, address, email address, and any other information that you choose to supply and/or that enables Users to be personally recognized are examples of Personal Data that we may collect. We automatically collect the following data: We also collect certain technical data that is automatically supplied to us from the computer, mobile device, and/or browser that you use to use the Services ("Automatic Data"). Automatic Data includes, for example, a unique identifier associated with your access device and/or browser (such as your Internet Protocol (IP) address), characteristics of your access device and/or browser, statistics on your activities on the Services, information about how you came to the Services, and data collected through Cookies, Pixel Tags, Local Shared Objects, Web Storage, and other similar technologies. Our Cookie Statement contains further information about how we use Cookies and other similar tracking technology. We may connect such Non-Personal Data (including Non-Personal Data we obtain from third parties) with your Personal Data when you register for the Services or otherwise submit Personal Data to us. In this case, any merged data will be treated as your Personal Data until it can no longer be associated with you or used to identify you.\n'
                        )
                      ]
                  )),
              Text('Information Collected From Organizers.',style: gilroyBold),
              Text('We will collect more Personal Data from you if you are a Consumer, sometimes for our own purposes and occasionally on behalf of an Organizer \n\n'+
                  "ConnEvents Properties or Applications offer the following information: You will supply financial information (e.g., your credit card number and expiration date, billing address, etc.) if you register for a paid event, some of which may constitute Personal Data. Organizers can also set up event registration pages on the Services to collect almost any information from Consumers in conjunction with registration for an Organizer's event listed on the Services. ConnEvents has no control over how an Organizer registers or what Personal Data they collect. ConnEvents receives and may use the information you supply when you register for or otherwise provide information to ConnEvents in connection with an Organizer event or activity, whether that information is yours or a third party's, in connection with a purchase, registration, or transfer.\n\n"+
                  'We may also gather Personal Data through third-party sources, such as Organizers, other Consumers, social media or other third-party integrations, your credit card issuing bank, our payment processing partners, or other third parties.\n\n',
                  textAlign: TextAlign.justify,
                  style: gilroyLight),
              Text('How We Use Your Personal Data.',style: gilroyExtraBold),
              Text('We collect and use the Personal Data we collect in a manner that is consistent with this Privacy Policy, and applicable privacy laws. We may use the Personal Data as follows:\n',
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('Specific Reason.',style: gilroyBold),
              Text('If you give Personal Data for a specific purpose, we may use it in connection with that purpose. If you contact us by email, for example, we will use the Personal Data you supply to react to your query or solve your problem, and we will respond to the email address from which you contacted us\n',
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('Access and Use.',style: gilroyBold),
              Text('We will use your Personal Data to provide you with access to or use of the Services or any functionality thereof, as well as to analyze your usage of such Services or functionality, if you give Personal Data in order to get access to or use of the Services or any functionality thereof. For example, if you provide Personal Data about your identification or qualifications to use specific parts of the Services, we will use that information to decide whether or not to provide you access to those parts of the Services and to assess your continued qualification to use those parts of the Services.\n',
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('Internal Business Purposes.',style: gilroyBold),
              Text('We may use your Personal Data for internal business purposes, such as improving the content and functionality of the Services, better understanding our Users, improving the Services, protecting against, identifying, or addressing wrongdoing, enforcing our Terms of Service, managing your account and providing you with customer service, and generally managing the Services and our business.\n',
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('ConnEvents and Organizer Marketing.',style: gilroyBold),
              Text("We may use your Personal Data for marketing and advertising purposes, such as (but not limited to) email marketing, SMS marketing, display media, and device targeting (such as tablets, mobile devices and televisions). We do this to keep you informed about services or events we think you'll like, generate promotional or marketing materials, and show ConnEvents or event-related content and advertising on or off the Services that we think you'll like. We may also do this on behalf of an Organizer, such as if your previous contacts with an Organizer indicate that you might be interested in a specific type of event.\n"+
                  "Advertisements for our Services may appear on third-party websites, such as social media platforms. We also give event organizers tools to assist them promote their events on third-party websites and social media platforms. If you see an advertisement on a third-party website or social media platform, it's because we or the Organizer paid the third-party or social media platform to display the advertisement to our Users or others with comparable characteristics. In some cases, this may entail sharing your email address or other contact information with a third party or social media platform so that they can recognize you as one of our Users, or identify other people who share similar characteristics with you so that we can show them advertisements for our Services (or for our Organizer's events). Please contact us at Support@connevents.com if you no longer want your Personal Data to be used for these purposes. You may need to contact the Organizer directly if you see an Organizer's advertisement",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('Organizer Emails.',style: gilroyBold),
              Text("We allow Organizers to use our email facilities to contact Consumers for current and past events, therefore you may receive emails from our system that are sent on their behalf by such Organizers. If you registered for an event through the Services, the Organizer has access to your email address. Organizers may, however, import email addresses from external sources and send emails to those addresses through the Services, and we will deliver those communications on the Organizer's behalf. ConnEvents is not responsible for sending these emails; instead, it is the organizer's responsibility.\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('Use of Interest-Based Data',style: gilroyBold),
              Text("We make educated guesses about the types of events or activities you might enjoy. These inferences may be used by us, including on behalf of Organizers, to assist target advertising or customize recommendations to you. This could be done in an aggregated or generalized manner.\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('Other Purposes',style: gilroyBold),
              Text("If we intend to use any Personal Data in a way that is inconsistent with this Privacy Policy, we will notify you prior to or at the time the Personal Data is collected, or we will obtain your agreement after the data is received but before it is used.\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('Aggregated Personal Data.',style: gilroyBold),
              Text("We frequently perform research on our customer demographics, interests, and behavior based on Personal Data and other information that we have acquired in an ongoing attempt to better understand and serve our Users. This type of research is usually done in an aggregated form that does not identify you. When Personal Data is aggregated, it becomes Non-Personal Data for the purposes of this Privacy Policy\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('How We Disclose And Transfer Your Personal Data.',style: gilroyBold),
              Text("We are not in the business of selling your personal information to other parties. This information is a critical component of our interaction with you. As a result, we will not sell your personal information to third parties, including marketers. As set forth in this Privacy Policy, there are some circumstances in which we may disclose, transfer, or share your Personal Data with third parties without additional notification to you\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('Business Transfers.',style: gilroyBold),
              Text("We may sell or buy businesses or assets as our company grows. Personal Data may be part of the transferred assets in the event of a corporate sale, merger, reorganization, dissolution, or similar event. In the event of such an event, we may also disclose your Personal Data as part of our due diligence. You agree that any successor to ConnEvents (or its assets) shall have the right to use your Personal Data and other information in line with the provisions of this Privacy Policy\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('Parent Companies, Subsidiaries and Affiliates',style: gilroyBold),
              Text("For the purposes of this Privacy Policy, we may also share your Personal Data with our parent businesses, subsidiaries, and/or affiliates. Our parent companies, subsidiaries, and affiliates will be obligated to protect your personal information in line with this policy.\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('Agents, Consultants and Service Providers.',style: gilroyBold),
              Text("Your Personal Data may be shared with our contractors and service providers who process Personal Data on ConnEvents' behalf to execute certain business-related services. Our marketing agencies, online advertising providers, data enhancement and data services providers, database service providers, backup and disaster recovery service providers, email service providers, payment processing partners, customer service, tech support, hosting companies, and others are among the companies we work with. We may give them with information, including Personal Data, in connection with their fulfillment of such activities when we hire another company to do so.\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('Organizers.',style: gilroyBold),
              Text("Furthermore, whether you register for an event, sign up for communications, enter a contest, or otherwise provide your Personal Data (such as via a web form) to contact with an Organizer or participate in an Organizer event, such information is shared with that Organizer. For example, if you fill up a web form for an Organizer offer, activity, or event, the Organizer will receive your name and email address. After that, the Organizer may send you marketing or other messages, which may be subject to its own privacy policy. You may also receive information messages connected to the service, event, activity, or information in which you've expressed interest if you supply your mobile phone number.\n"+
                  "When you buy tickets to an event, register for an event, donate to an event, transfer an event ticket or registration to another person, enter a contest, or otherwise input your Personal Data (such as through a web form), or otherwise communicate with an Organizer, or participate in or express interest in an Organizer or Organizer event or activity, that Organizer will receive the information you provide, including your Personal Data. Other third parties involved in or on behalf of whom an event or activity is promoted may also receive Personal Data. For example, when it comes to fundraising sites, we may share your Personal Data with both the fundraiser's organizer charity and the organizer of the event to which the fundraiser is tied. In some cases, an Organizer may appoint a third party, who may or may not be linked with the Organizer, to construct an event or fundraising page on the Organizer's behalf (we refer to these third parties as 'third parties') ('Third Party Organizers').\n"
                  +"With respect to your Personal Data, we are not responsible for the acts of these Organizers or their Third Party Organizers (or any downstream recipients of your Personal Data). Before providing Personal Data or other information in connection with an event (and, if applicable and available, their appointed Third Party Organizers), it is critical that you review the applicable policies of the Organizers (and, if applicable and available, their appointed Third Party Organizers) of that event (and, if applicable, the related fundraising page). If you are a member of an Organizer's ConnEvents organization, your Personal Data will be available to the Organizer and shared with those Third Party Organizers who have been granted permission by the Organizer to view all members of the Organizer's organization.\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('Social Media and Other Third Party Connections.',style: gilroyBold),
              Text("a. Connecting Your ConnEvents Account to Social Media Services. You can link your ConnEvents account to third-party services such as Facebook, in which case we may collect, use, disclose, transmit, and store/retain information about your account with those third-party services in line with this Privacy Policy. If you connect with Facebook, for example, we will store your Facebook id, first name, last name, email, location, friends list, and profile picture and use them to connect with your Facebook account to provide certain functionality on the Services, such as recommending events to your Facebook friends and sharing events you are interested in or attending with specific groups of people, such as your Facebook friends.\n\n"+
                  "b. “Liking” or “Following” ConnEvents on Social Media. We may also collect information from you when you 'like' or 'follow' us on Facebook, Instagram, Twitter, or other social networking sites (to the extent we give that possibility), such as your name, email address, and any related comments or material you post. If you sign up for one of our promotions or submit information to us through social networking sites, we may gather your information as well.\n"+
                  "c. Facebook Plug-Ins and Links on Our Pages. ConnEvents' own website may also feature links to Facebook, such as the 'Like' or 'Share' buttons on Facebook or other social plug-ins. When you use these features and links, your browser establishes a direct connection with Facebook servers, and Facebook receives information about your browser and behavior, which it may associate with your Facebook user account. Please visit Facebook's own policies for additional information on how they use data.\n\n"+
                  "d. Additional Facebook Marketing and Connectivity by Organizers. Furthermore, if you are a member of Facebook (or another social media platform) and provide Personal Data to an Organizer, the Organizer may use that Personal Data to send you advertising and offers via Facebook (or another social media platform), including when you are on Facebook (or another social media platform). To enable data integration and advertising, the Organizer may use tools that we provide, as well as collaborate with other parties. There may be an option to opt out of this type of advertising on Facebook and other social media platforms. Please take a look at their user settings and support pages to discover more about how they can assist you in managing your privacy and marketing preferences.\n\n"+
                  "e. Third party services and integrations. Through our platform, ConnEvents may provide you the ability to contract directly with third parties and/or interface with third-party services or applications. In some cases, we shall share your Personal Data with other entities in order to fulfill your request or provide the services you have requested.\n\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('Legal Requirements.',style: gilroyBold),
              Text("We may disclose your Personal Data if required to do so by law, such as in response to a subpoena or request from law enforcement, a court, or a government agency (including in response to public authorities to meet national security or law enforcement requirements), or if we believe in good faith that such action is necessary to: \n"+
                  "             * comply with a legal obligation.\n\n"+
                  "             * preserve or defend our rights, interests, or \n"
                      "               property, as well as the rights, interests, and \n "
                      "               property of others.\n\n"+
                  "             * prevent or investigate any potential wrongdoing \n "
                      "               involving the Services.\n\n"+
                  "             * take action in an emergency to protect the \n "
                      "                 personal safety of Users of the Services or the \n "
                      "               general public, or \n\n"+
                  "             * avoid legal liability.\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('How We Store Your Personal Data.',style: gilroyBold),
              Text("We may store Personal Data ourselves, or we may transmit it to third parties who will store it in compliance with our Privacy Policy. We take reasonable precautions to protect Personal Data obtained through the Services against loss, misuse, unauthorized use, access, unintended disclosure, modification, and destruction. No network, server, database, or Internet or email transmission, on the other hand, is ever completely secure or error-free. As a result, you should exercise extreme caution when determining what information you transmit us electronically. When revealing any Personal Data, please bear this in mind\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('How You Can Access, Update, Correct or Delete Your Personal Data',style: gilroyBold),
              Text("You have the ability to view or remove your Personal Data that we have on file for you. If you are a registered User, you can do so by checking in and going to the Account Settings page to download a machine-readable copy of your Personal Data and/or delete it. Some of your Personal Data can also be edited directly through your account. In some situations, you can contact us to request that we correct or amend any erroneous Personal Data, and we will evaluate your request in compliance with applicable regulations\n"+
                  "If a Consumer requests that their data be deleted, ConnEvents is authorized to remove or anonymize the requesting Consumer's Personal Data from the Services, even if this means making it unavailable to the Organizer through the Services. If you are a Consumer, you should be aware that even if ConnEvents deletes or anonymizes your Personal Data at your request or in accordance with this Policy, your Personal Data may still be available in the Organizer's databases if it was transmitted to the Organizer before ConnEvents received or took action on any deletion or anonymization activity.\n"+
                  " Unregistered Users can also use the contact information below to view, update, correct, or delete Personal Data and exercise these rights. All inquiries will be considered and responded to in accordance with the legislation.\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('How Long We Retain Your Personal Data.',style: gilroyBold),
              Text("Your Personal Data may be kept for as long as you are a registered user of the Services. By going to the Account Settings page, you can delete your account. However, we may keep Personal Data for a longer period if necessary or permitted by applicable laws. Even if we delete your Personal Data, it may be retained for a longer amount of time on backup or archive media for legal, tax, or regulatory purposes, or for legitimate and reasonable business objectives.\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('Cookies, Pixels Tags, Local Shared Objects, Web Storage And Similar Technologies.',style: gilroyBold),
              Text("Please refer to our Cookie Statement for more information about our use of cookies and other similar tracking technologies.\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('Your Choices.',style: gilroyBold),
              Text("You have several choices available when it comes to your Personal Data:\n\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('Limit the Personal Data You Provide.',style: gilroyBold),
              Text("You can use the Services without supplying any Personal Data (save to the extent that Automatic Data is considered Personal Data under applicable legislation) or with limited Personal Data. You may not be able to use some features of the Services if you choose not to supply any Personal Data or limit the Personal Data you provide.\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('Opt Out from Electronic Communications.',style: gilroyBold),
              Text("(a) ConnEvents Marketing Communications. To the extent you have registered for the Services or purchased a ticket and/or registration to an event listed on the Services, ConnEvents may send you electronic communications marketing or advertising the Services themselves or events on the Services, in accordance with your marketing preferences. You can also 'unsubscribe'from receiving these electronic communications by clicking the 'Unsubscribe' link at the bottom of each such electronic communication. You can also change your email options at any time by checking in (or signing up and then logging in), going to 'Account,' and then 'Email Preferences'.\n\n"+
                  '(b) Organizer-initiated Communications. Organizers may send electronic communications to people on their email subscription lists, which may include Consumers who have already registered for their events on the Services, using our email capabilities. Despite the fact that these electronic communications are sent through our system, ConnEvents has no control over the content or recipients of these messages. Organizers are only allowed to use our email tools if they follow all applicable regulations. On each of these emails, ConnEvents includes a "Unsubscribe" link that allows recipients to "opt out" of receiving electronic communications from the specific Organizer.\n\n'+
                  '(c) Social Notifications. You will receive these social notifications if you connect your Facebook account or join up for other social network integrations whose product features include social notifications (i.e., updates on what your friends are doing on the Services). Toggle your social settings to private or disconnect such integration to manage these social notifications.\n\n'+
                  "(d) Transactional or Responsive Communications. ConnEvents' electronic communications are responsive to your needs in some cases. Only by contacting us will you be able to stop getting these types of emails. You will no longer receive any updates on events you have produced (including payout difficulties) or events you have registered to attend if you choose to stop receiving all electronic communications from us or through our system (including emails with your tickets). We don't advocate doing this unless you're planning to stop using the Services, aren't currently registered for an event, aren't actively organizing an event, and won't need to hear from us or through our system again.\n\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('Do Not Track.',style: gilroyBold),
              Text("You can use the Services without supplying any Personal Data (save to the extent that Automatic Data is considered Personal Data under applicable legislation) or with limited Personal Data. You may not be able to use some features of the Services if you choose not to supply any Personal Data or limit the Personal Data you provide.\n\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('Exclusions.\n',style: gilroyExtraBold),
              Text('Personal Data Provided to Others.',style: gilroyBold),
              Text("This Privacy Policy does not apply to any Personal Data that you provide to another User or visitor through the Services or through any other means, including to Organizers on event pages or information posted by you to any public areas of the Services.\n\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('Third Party Links.',style: gilroyBold),
              Text('This Privacy Policy applies only to the Services. The Services may contain links to other websites not operated or controlled by us (the "Third Party Sites"). The policies and procedures we described here do not apply to the Third Party Sites. The links from the Services do not imply that we endorse or have reviewed the Third Party Sites. We suggest contacting those sites directly for information on their privacy policies.\n\n',
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text("Children - Children's Online Privacy Protection Act.",style: gilroyBold),
              Text("We do not collect Personal Data from children under the age of thirteen without their consent (13). Please do not submit any Personal Data through the Services if you are under the age of thirteen (13). We encourage parents and legal guardians to keep an eye on their children's online activities and to help us enforce our Privacy Policy by educating their children to never provide Personal Data over the Services without their permission. If you believe a child under the age of 13 has contributed Personal Data to us through the Services, please notify us and we will make every effort to remove the information from our databases.\n\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text("International Privacy Laws.",style: gilroyBold),
              Text("If you are visiting the Services from outside the United States, please be aware that you are sending information (including Personal Data) to the United States where our servers are located. That information may then be transferred within the United States or back out of the United States to other countries outside of your country of residence, depending on the type of information and how it is stored by us. These countries (including the United States) may not necessarily have data protection laws as comprehensive or protective as those in your country of residence; however, our collection, storage and use of your Personal Data will at all times continue to be governed by this Privacy Policy.\n\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text("Changes To This Privacy Policy.",style: gilroyBold),
              Text("From time to time, the Services and our business may change. As a result, we may need to make modifications to this Privacy Policy from time to time. We retain the right to amend or modify this Privacy Policy at any time in our sole discretion (collectively, 'Modifications'). Changes to this Privacy Policy will be posted on the Site and the 'Updated' date at the top of this Privacy Policy will be updated. ConnEvents may, but is not obligated to, provide you with additional notice of such Modifications, such as by email or in-Service notices, in certain instances. Modifications shall take effect thirty (30) days from the 'Updated' date or such other date as may be disclosed to you in any other notification\n\n"+
                  "Please examine this policy on a regular basis, particularly before providing any Personal Data. This Privacy Policy was last updated on the above-mentioned date. Continued use of the Services after any Modifications to this Privacy Policy go into effect implies acceptance of the Modifications. You shall stop accessing, browsing, and otherwise using the Services if any Modification to this Privacy Policy is unacceptable to you.\n\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text("Dispute Resolution.",style: gilroyBold),
              Text("If you have a complaint about ConnEvents's privacy practices you should write to us at: Support@connevents.com. We will take reasonable steps to work with you to attempt to resolve your complaint\n\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),


            ],
          ),
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
