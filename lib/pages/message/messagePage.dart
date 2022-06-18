import 'dart:async';

import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/chat-model.dart';
import 'package:connevents/pages/messageDetails/messageDetailsPage.dart';
import 'package:connevents/pages/tabs/tabsPage.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:connevents/widgets/notification-button.dart';
import 'package:connevents/widgets/profile-image-picker.dart';
import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {

List<GetAllChats> chatsDetail=[];
Timer? timer;

ScrollController _controller= ScrollController();


  Future getChat() async {
    try{
      var response = await DioService.post('chat', {
        "userId" : AppData().userdetail!.users_id,
        "requestType" : "getChatList"
      });
      var chats= response['data'] as List;
      chatsDetail =    chats.map<GetAllChats>((e) =>  GetAllChats.fromJson(e)).toList();
      print(chatsDetail.toList());
      setState(() {});
    }
    catch(e){
     // Navigator.of(context).pop();
     // showSuccessToast(e.toString());
    }
  }

  Future getChatList() async {
  try{
    var response = await DioService.post('chat', {
      "userId" : AppData().userdetail!.users_id,
      "requestType" : "getChatList"
    });
    var chats= response['data'] as List;
    chatsDetail =    chats.map<GetAllChats>((e) =>  GetAllChats.fromJson(e)).toList();
    print(chatsDetail.toList());
    Navigator.of(context).pop();
    setState(() {});
  }
  catch(e){
    Navigator.of(context).pop();
    // showSuccessToast(e.toString());
  }
}



  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) =>  getChat());
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      openLoadingDialog(context, "loading...");
      getChatList();
    });
  }


  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Colors.white),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: globallightbg,
                ),
                padding: EdgeInsets.symmetric(vertical: padding, horizontal: padding * 2),
                child: Text('Message', style: TextStyle(color: globalBlack, fontSize: 36, fontWeight: FontWeight.bold))),
              SizedBox(height: padding),
              ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: chatsDetail.length,
                  shrinkWrap: true,
                  controller: _controller,
                  itemBuilder: (context,index){
                  GetAllChats chat=chatsDetail[index];
                    return InkWell(
                      onTap: () {
                        CustomNavigator.navigateTo(context, MessageDetailsPage(
                          otherUserChatId: chat.user_id,
                          userName: chat.name!,
                          profilePic: chat.profile_pic!,
                        ));
                      },
                      child: Container(
                              padding: EdgeInsets.symmetric(horizontal: padding * 2),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: ProfileImagePicker(
                                          onImagePicked: (value){},
                                          previousImage: chat.profile_pic ?? "",
                                        ),
                                      ),
                                      SizedBox(width: padding),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(vertical: padding / 2),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(chat.name!, style: TextStyle(color: globalBlack, fontSize: 16, fontWeight: FontWeight.w500,)),
                                              SizedBox(height: padding / 4),
                                              Text(chat.message!, style: TextStyle(color: globalBlack, fontSize: 8, fontWeight: FontWeight.w400, height: 1.5,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: padding / 2),
                                      Column(
                                        children: [
                                          Text(chat.time!, style: TextStyle(color: globalLGray, fontSize: 8)),
                                          SizedBox(height: padding / 2),
                                        if(chat.badge!=0)
                                         notificationButton(chat.badge!)
                                        ],
                                      )
                                    ],
                                  ),
                                  Divider(color: globalLGray),
                                ],
                              ),
                        ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
