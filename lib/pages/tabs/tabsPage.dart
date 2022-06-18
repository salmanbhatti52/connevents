import 'dart:async';

import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/peek-model.dart';
import 'package:connevents/pages/createEvent/createPage.dart';
import 'package:connevents/pages/eventDetails/eventDetailsPage.dart';
import 'package:connevents/pages/eventPeeks/event-peeks.dart';
import 'package:connevents/pages/notifications/notificationsPage.dart';
import 'package:connevents/provider/provider-data.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import '../../pages/home/homePage.dart';
import '../../pages/menu/menuPage.dart';
import '../../pages/message/messagePage.dart';
import '../../variables/globalVariables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

 int? checkUserSubscription;
class TabsPage extends StatefulWidget {
  PeekDetail? peekDetail;
  bool fromPeeksTab;
 final int? index;
   TabsPage({Key? key,this.index,this.fromPeeksTab = true,this.peekDetail}) : super(key: key);
  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {

  bool _canExit=false;
  int messages=0;

  Future checkSubscription() async {
    try{
      var response = await DioService.post('check_user_subscription', {"userId": AppData().userdetail!.users_id
      });
       checkUserSubscription =response['data']['subscription_package_id'];
       print(checkUserSubscription);
    }
    catch(e){
       print(e.toString());
     // showSuccessToast(e.toString());
    }
  }

  Future onTimePost() async {
    try{
      var response = await DioService.post('post_count_available', {
        "usersId": AppData().userdetail!.users_id
      });
      print(response['data']);
      AppData().userdetail!.one_time_post_count =response['data'];
       setState(() {});
    }
    catch(e){
      print(e.toString());
     // showSuccessToast(e.toString());
    }
  }

  late  int currentIndex;
  List<Widget> myTabs = [
    HomePage(unreadMessage: (val){
      AppData().unreadMessage=val;

    }),
    EventPeeks(),
    CreatePage() ,
    MessagePage(),
    MenuPage(),
  ];
  @override
  void initState() {
    super.initState();
    initDynamicLinks();
    checkSubscription();
    onTimePost();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark));
     currentIndex = widget.index ?? 0;
      OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
        // Will be called whenever a notification is opened/button pressed.
        print("shahzaib");
        print(result.notification.rawPayload);
        print("shahzaib");

        CustomNavigator.navigateTo(context, NotificationsPage());
      });
  }
  void initDynamicLinks() async {
     FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async{
          final Uri deepLink=dynamicLink!.link;
          if(deepLink!=null){
            handleMyLink(deepLink);

            showSuccessToast("deep Link  shahzaib ${dynamicLink.toString()}");
            print("deep Link  shahzaib ${dynamicLink.toString()}");
          }
        },
        onError: (OnLinkErrorException e) async{
          print("I am here");
          print(e.message);
        }
    );
  }


  void handleMyLink(Uri url){
    List<String> sepeatedLink = [];
    /// osama.link.page/Hellow --> osama.link.page and Hellow
    sepeatedLink.addAll(url.path.split('/'));
    print("The Token that i'm interesed in is ${sepeatedLink[1]}");
    Get.to(EventDetailsPage(fromDynamicLink: true,dynamicEventPostId: int.parse(sepeatedLink[1])));

    setState(() {

    });

  }



  @override
   Widget build(BuildContext context) {

  return WillPopScope(
      onWillPop: ()async{
       if(_canExit) {
            return true;
          }else {
           showSuccessToast("Click Again To Exit");
         _canExit = true;
         Timer(Duration(seconds: 2), () {
           _canExit = false;
         });
         return false;
       }
      },
      child: Scaffold(
        body: currentIndex==1 && !widget.fromPeeksTab? EventPeeks(peekDetail: widget.peekDetail,fromPeeksTab: widget.fromPeeksTab) : myTabs[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
              // if(index==2) {
              //   if(checkUserSubscription == 2 || AppData().userdetail!.one_time_post_count > 0)
              //     currentIndex = index;
              //   else
              //    showErrorToast("Upgrade Your Package to create your Event Post");
              // }
             // else currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/icons/tabs/home.svg',
                  color: currentIndex == 0 ? globalGreen : globalBlack,
                  width: 30,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/tabs/story.svg',
                  color: currentIndex == 1 ? globalGreen : globalBlack,
                  width: 25,
                ),
                label: 'Peeks'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/icons/tabs/create.svg',
                  color: currentIndex == 2 ? globalGreen : globalBlack,
                  width: 30,
                ),
                label: 'Create'),
            BottomNavigationBarItem(
                icon: Stack(
                  children: [
                    SvgPicture.asset('assets/icons/tabs/message.svg',
                      color: currentIndex == 3 ? globalGreen : globalBlack,
                      width: 30,
                    ),

                    Consumer<ProviderData>(
                      builder:(context,value,child){
                        if(value.status== 'success')
                        return  Positioned(
                                left:1,
                                bottom: 12,
                                child: Container(
                                        height: 14,
                                        width: 14,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(color: Colors.red,
                                        borderRadius: BorderRadius.circular(40.0)),
                                        child: Text(value.unreadMessages.toString(),style: TextStyle(color:Colors.white,fontSize: 8))));
                        return SizedBox();
                      }
    ),
                  ],
                ),
                label: 'Message'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/icons/tabs/menu.svg',
                  color: currentIndex == 4 ? globalGreen : globalBlack,
                  width: 30,
                ),
                label: 'Menu'),
          ],
        ),
      ),
    );
  }
}
