import 'dart:io';

import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:connevents/mixins/data.dart';
import 'package:connevents/pages/landing/landingPage.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:connevents/widgets/profile-image-picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class BasicMenuPage extends StatefulWidget {
  const BasicMenuPage({Key? key}) : super(key: key);

  @override
  State<BasicMenuPage> createState() => _BasicMenuPageState();
}

class _BasicMenuPageState extends State<BasicMenuPage> {

   final qrKey= GlobalKey(debugLabel:'QR');
   QRViewController? controller;
    Barcode? result;

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




    @override
   void dispose(){
     controller?.dispose();
     super.dispose();
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
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          children: [
            TextButton(
              onPressed: ()=> Navigator.of(context).pop(),
              child: Row(
                children: [
                  Icon(Icons.chevron_left),
                  Text('Back'),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(padding * 2),
          decoration: BoxDecoration(color: globallightbg,),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: padding,),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 100, height: 100,
                          child: ProfileImagePicker(
                                onImagePicked: (value){},
                                 previousImage: AppData().userdetail!.profile_picture,
                                  )),
                        SizedBox(height: padding,),
                        Text(AppData().userdetail!.user_name!, style: TextStyle(color: globalBlack, fontSize: 28, fontWeight: FontWeight.bold,),),
                        SizedBox(height: padding / 1.2),
                        // GestureDetector(
                        //     onTap: () =>CustomNavigator.navigateTo(context, MenuPage()),
                        //     child: Text('Detailed View', style: TextStyle(color: globalGreen, fontSize: 14, fontWeight: FontWeight.bold)))
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Location', style: TextStyle(color: globalBlack, fontSize: 16, fontWeight: FontWeight.w600)),
                        SizedBox(height: padding / 1.2),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: globalLGray,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: TextFormField(
                            initialValue:AppData().userLocation !=null ?   AppData().userLocation!.address :"",
                            style: TextStyle(color: globalBlack, height: 1.7, fontSize: 14, fontWeight: FontWeight.normal,),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: SvgPicture.asset('assets/icons/mark.svg', fit: BoxFit.scaleDown, color: globalGreen,),
                              hintText: 'Location Here',
                              hintStyle: TextStyle(color: globalBlack.withOpacity(0.5), fontSize: 14, height: 1.7, fontWeight: FontWeight.normal,),
                            ),
                          ),
                        ),
                        Text('Email', style: TextStyle(color: globalBlack, fontSize: 16, fontWeight: FontWeight.w600,),),
                        SizedBox(height: padding / 2),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: globalLGray,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: TextFormField(
                            initialValue: AppData().userdetail!.email ?? "",
                            enabled: false,
                            style: TextStyle(color: globalBlack, height: 1.7, fontSize: 14, fontWeight: FontWeight.normal,),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: SvgPicture.asset('assets/icons/mail1.svg', color: globalGreen, fit: BoxFit.scaleDown,),
                              hintText: 'Email Here',
                              hintStyle: TextStyle(color: globalBlack.withOpacity(0.5), height: 1.7, fontSize: 14, fontWeight: FontWeight.normal,),
                            ),
                          ),
                        ),
                        SizedBox(height: padding * 2),
                        SizedBox(width: double.infinity, height: 50,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: globalGreen,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset('assets/icons/checkIn.svg'),
                                Text('  CHECK IN', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold,),
                                )
                              ],
                            ),
                            onPressed: () async{
                                var result = await BarcodeScanner.scan();
                                if(result.rawContent.isNotEmpty)
                                scanCode(result.rawContent);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: padding*10),
              Row(
                children: [
                  TextButton(
                    onPressed: () async{
                    await  AppData().signOut();
                    CustomNavigator.pushReplacement(context, LandingPage());
                    },
                    child: Row(
                      children: [
                        Icon(Icons.logout,color: Colors.red),
                        Text('Log out', style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold,),),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
