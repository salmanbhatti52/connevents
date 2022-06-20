import 'dart:developer';
import 'dart:io';

import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:connevents/mixins/data.dart';
import 'package:connevents/pages/basicMenu/basicMenuPage.dart';
import 'package:connevents/pages/chosePlan/chosePlanPage.dart';
import 'package:connevents/pages/landing/landingPage.dart';
import 'package:connevents/pages/menu/cancelPremiumSubscriptionAlert.dart';
import 'package:connevents/pages/menu/menuPageFunctions.dart';
import 'package:connevents/pages/tabs/tabsPage.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:connevents/widgets/notification-button.dart';
import 'package:connevents/widgets/profile-image-picker.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter_svg/svg.dart';


class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {

 final qrKey= GlobalKey(debugLabel:'QR');
 QRViewController? controller;
 Barcode? result;
 int badgeCount=-1;

 String selectedSegment = "Events";

 Future scanCode(qrCode) async {
   print(qrCode);
   openLoadingDialog(context, 'loading');
   try{
     var response = await DioService.post('checkin', {
       "ticketUniqueNumber": qrCode,
       'usersId':AppData().userdetail!.users_id

     });
     Navigator.of(context).pop();
     if(response['status']=='success'){
       showSuccessToast(response['data']);
     }
     else {
       showSuccessToast(response['message']);
     }


   }
   catch(e){
     print("shahzaib");
     Navigator.of(context).pop();
     showSuccessToast(e.toString());
   }
 }


  Future notificationBadge() async {
   try{
     var response = await DioService.post('get_user_notifications_badge_count', {
       "usersId": AppData().userdetail!.users_id
     });
     if(response['status']=='success'){
       if(mounted){
         badgeCount = response['data'];
         setState(() {});
       }
     }
   }
   catch(e){
     Navigator.of(context).pop();
   }
 }


 void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
   log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
   if (!p) {
     ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(content: Text('no Permission')),
     );
   }
 }


 @override
 void dispose(){
   controller?.dispose();
   super.dispose();
 }


 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationBadge();
  }

 void reassemble() async {
   super.reassemble();
   if (Platform.isAndroid) {
   await  controller?.pauseCamera();
   }
   controller?.resumeCamera();
 }


  @override
  Widget build(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    print(AppData().userdetail!.subscription_package_id);
    List activitiesOptions = <String>[
      'Payment Method',
      'Dashboard',
      'Favorite Events',
      'Refund Requests',
      'Event Guests List',
      'Ticket Library',
      'Event Catalog',
      'Interest Categories',
      'Your Rewards',
      'My Portfolio',
      'My Earnings',
      'Book Room',
    ];
    List settingsOptions = <String>[
      'Profile',
      'Notifications',
      'Help',
      'Notification Settings',
      'Terms & Conditions',
      'Privacy & Policy'
    ];
    return Scaffold(
      backgroundColor: globallightbg,
      body: Padding(
        padding: const EdgeInsets.only(top:40.0),
        child: Container(
          decoration: BoxDecoration(color: globallightbg),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              padding: EdgeInsets.all(padding * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 62,
                        height: 62,
                        child : ProfileImagePicker(
                                onImagePicked: (value){},
                                previousImage: AppData().userdetail!.profile_picture,
                              ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left:10.0,right:8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(AppData().userdetail!.first_name! + " ${AppData().userdetail!.last_name!}", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: globalBlack, overflow: TextOverflow.ellipsis),
                          ),
                              GestureDetector(
                                onTap: () {
                                  CustomNavigator.navigateTo(context, BasicMenuPage());
                                  // Navigator.pushNamed(context, '/basicMenu');
                                },
                                child: Text('Basic View', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: globalGreen,),),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 112,
                        height: 40,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: globalGreen,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () async{
                            var result = await BarcodeScanner.scan();
                            if(result.rawContent.isNotEmpty)
                            scanCode(result.rawContent);
                            // print(result.rawContent);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/icons/checkIn.svg'),
                              Text('CHECK IN', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold,)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: padding),
                    child: Text('Status', style: TextStyle(color: globalBlack, fontSize: 18, fontWeight: FontWeight.bold))),
                   if(checkUserSubscription != null)
                    checkUserSubscription == 2 ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Premium', style: TextStyle(color: globalGreen, fontSize: 22, fontWeight: FontWeight.bold)),
                      SizedBox(
                        width: 80,
                        height: 24,
                        child: TextButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CancelPremiumSubscriptionAlert();
                                });
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor: globalGreen,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text('Cancel', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  )
                  :Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Basic', style: TextStyle(color: globalGreen, fontSize: 22, fontWeight: FontWeight.bold)),
                      SizedBox(
                        width: 80,
                        height: 24,
                        child: TextButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return ChosePlanPage();
                                });
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor: globalGreen,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text('Upgrade', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: padding),
                    child: InkWell(
                      onTap:()=>CustomNavigator.navigateTo(context,ChosePlanPage()),
                      child: Text('Activities', style: TextStyle(color: globalBlack, fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  for (var i = 0; i < activitiesOptions.length; i++)
                    Container(
                      margin: EdgeInsets.only(bottom: padding / 2),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: globalLGray,
                          ),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () =>executeActivitiesOption(activitiesOptions[i], context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(activitiesOptions[i], style: TextStyle(color: globalBlack.withOpacity(0.7), fontSize: 16, fontWeight: FontWeight.w300)),
                            Icon(Icons.chevron_right, color: globalLGray,
                            ),
                          ],
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: padding),
                    child: Text('Settings and more', style: TextStyle(color: globalBlack, fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  for (var i = 0; i < settingsOptions.length; i++)
                    Container(
                      margin: EdgeInsets.only(bottom: padding / 2),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: globalLGray,
                          ),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          executeSettingsOption(settingsOptions[i], context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Text(
                              settingsOptions[i],
                              style: TextStyle(
                                color: globalBlack.withOpacity(0.7),
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            if(settingsOptions[i]=="Notifications")
                            badgeCount > -1 ?
                            badgeCount == 0 ? SizedBox():
                            Padding(
                              padding: const EdgeInsets.only(right: 100),
                              child: notificationButton(badgeCount),
                            ):SizedBox(height:12,width: 12,child: CircularProgressIndicator(strokeWidth: 2,)),

                            Icon(
                              Icons.chevron_right,
                              color: globalLGray,
                            ),
                          ],
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: padding),
                    child: TextButton(
                      onPressed: () async{
                      await  AppData().signOut();
                      CustomNavigator.pushReplacement(context, LandingPage());
                        //
                        // Navigator.pushNamedAndRemoveUntil(
                        //     context, '/', (route) => false);
                      },
                      child: Text('Log out', style: TextStyle(decoration: TextDecoration.underline, color: globalGreen, fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
