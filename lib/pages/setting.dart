import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/notification-setting-model.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/connevent-appbar.dart';
import 'package:connevents/widgets/switch-button.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  List<NotificationSettingModel>  notificationSettingList=[];

  List<int> list=[];

  Future notificationPreference() async {
   try{
     var response = await DioService.post('get_user_notification_preferences', {
       "usersId": AppData().userdetail!.users_id
     });
      var notifications = response['data'] as List;
        notificationSettingList = notifications.map<NotificationSettingModel>((e) => NotificationSettingModel.fromJson(e)).toList();
        setState(() {});
        Navigator.of(context).pop();
   }
   catch(e){
     Navigator.of(context).pop();
   }
 }



   Future updateNotification(String status , int userNotificationSettingId) async {
    openLoadingDialog(context, 'loading');
   try{
     var response = await DioService.post('update_notification_setting', {
       "userNotificationSettingId" :userNotificationSettingId ,
       "status" : status,
     });

       notificationPreference();

   }
   catch(e){
     Navigator.of(context).pop();
   }
 }








   toggleSwitch(index) {
     print("toggle");

   }

   @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
    openLoadingDialog(context, "loading...");
    notificationPreference();

     });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ConneventAppBar(),
      body:  Column(
        children: [
          Text("General Posts",style:TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: globalGreen)),
          Expanded(
            child: ListView.builder(
                   itemCount: notificationSettingList.length,
                   itemBuilder: (context,index){
                     NotificationSettingModel notification= notificationSettingList[index];
                     return Column(
                          children:[
                            switchButton(onChanged:(val){
                              if( notification.status=="On")
                                updateNotification("Off",notification.userNotificationSettingId!);
                              else
                                updateNotification("On",notification.userNotificationSettingId!);

                          }, title: notification.notificationType!, isSwitched: notification.status=="On"),
                        ]
                        );
                     }),
          ),
        ],
      )
    );
  }
}
