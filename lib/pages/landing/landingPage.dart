import 'package:connevents/pages/login/loginPage.dart';
import 'package:connevents/pages/registerType/registerTypePage.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/widgets/custom-navigator.dart';

import '../../variables/globalVariables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';


String isSocial='';
class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {




  Future isSocialAvailable() async {
    try{
      var response = await DioService.get('check_social_login');
      print("response");
      print(response);
      isSocial=response['data']['login_status'];
      print("isSocial");
      print(isSocial);
      Navigator.of(context).pop();
    }
    catch(e){
      Navigator.of(context).pop();
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        openLoadingDialog(context, "loading...");
        isSocialAvailable();
         });
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/imgs/handsbg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SvgPicture.asset('assets/imgs/logo.svg', width: 210,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(padding),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: TextButton(
                      onPressed: () {
                        CustomNavigator.navigateTo(context, LoginPage());
                      //  Navigator.pushNamed(context, '/login');
                      },
                      child: Text('SIGN IN', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold,),),
                      style: TextButton.styleFrom(
                        backgroundColor: globalGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: TextButton(
                      onPressed: () {
                        CustomNavigator.navigateTo(context, RegisterTypePage());
                        // Navigator.pushNamed(context, '/registerType');
                      },
                      child: Text('SIGN UP', style: TextStyle(color: globalGreen, fontSize: 16, fontWeight: FontWeight.bold,),
                      ),
                      style: TextButton.styleFrom(backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
