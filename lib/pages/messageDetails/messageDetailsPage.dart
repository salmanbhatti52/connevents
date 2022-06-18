import 'dart:async';

import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/chat-model.dart';
import 'package:connevents/pages/emojisPicker/emojis-picker.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/comment-textfield.dart';
import 'package:connevents/widgets/profile-image-picker.dart';
import 'package:flutter/material.dart';

class MessageDetailsPage extends StatefulWidget {
 final  String profilePic;
 final int? otherUserChatId;
 final String userName;

  const MessageDetailsPage({Key? key,required this.profilePic,this.otherUserChatId,required this.userName, }) : super(key: key);

  @override
  State<MessageDetailsPage> createState() => _MessageDetailsPageState();
}

class _MessageDetailsPageState extends State<MessageDetailsPage> {
    TextEditingController message=TextEditingController();
    Timer? timer;
    StartChatModel? chat;
    List<GetMessages> messages=[];
    late FocusNode myFocusNode;
    bool isEmojiShown=false;
    ScrollController _controller = ScrollController();


   Future sendMessage() async{
     if(isEmojiShown)
       isEmojiShown=false;
     setState(() {});
     if(message.text.isEmpty)
      return showErrorToast("Please Write Some Comment");
      else{
       print(message.text);
       openLoadingDialog(context, 'sending');
       await startChat();
       var response;
       try{
         response   = await  DioService.post("chat", {
           "userId" : AppData().userdetail!.users_id,
           "otherUserId" : widget.otherUserChatId,
           "content" :      message.text,
           "messageType" : "text",
           "sendingTime" :  "",
           "requestType" : "sendMessage"
         });
         print(response);
         Navigator.of(context).pop();
         FocusManager.instance.primaryFocus!.unfocus();
         message.clear();
         Timer(Duration(milliseconds: 500),() => _controller.jumpTo(_controller.position.maxScrollExtent));
         setState(() {});
       }
       catch(e) {
        // showErrorToast(e.toString());
         print(response);
       }
     }
   }

  Future startChat() async {
    try{
      var response = await DioService.post('chat', {
        "otherUserId": widget.otherUserChatId,
        "userId": AppData().userdetail!.users_id,
        "requestType": "startChat"
      });
      var userDetail= response['data'];

      chat = StartChatModel.fromJson(userDetail);
      setState(() {});
    }
    catch(e){
      Navigator.of(context).pop();
     // showSuccessToast(e.toString());
    }
  }

  Future getMessages() async {
      var response;
      try{
         response = await DioService.post('chat', {
          "otherUserId": widget.otherUserChatId,
          "userId": AppData().userdetail!.users_id,
          "requestType": "getMessages"
        });

        var messagesDetail= response['data'] as List;
        messages =  messagesDetail.map<GetMessages>((e) => GetMessages.fromJson(e)).toList();
        print("messages");
        print(messages.toList());
       //  Navigator.of(context).pop();
        print("messages");
        setState(() {});
      }
      catch(e){
       // Navigator.of(context).pop();
     //   showErrorToast(response['message']);
      }
    }

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
       myFocusNode = FocusNode();
      timer = Timer.periodic(Duration(seconds: 1), (Timer t) =>  getMessages());
    //   WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
    //     openLoadingDialog(context, "loading...");
    //
    //   // getMessages();
    // });
    }
  @override
  void dispose() {
    myFocusNode.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f6f6),
      appBar: AppBar(
        titleSpacing: 0.0,
        elevation: 0,
        backgroundColor: Colors.white,
        leadingWidth: 100,
        leading: TextButton(
              onPressed: () =>Navigator.pop(context),
              child: Row(
                children: [
                  Icon(Icons.chevron_left),
                  Text(' Back', style: TextStyle(color: globalGreen, fontSize: 16, fontWeight: FontWeight.normal)),
                ],
              ),
            ),
        centerTitle: true,
        title: Text(widget.userName, style: TextStyle(color: globalBlack, fontSize: 16, fontWeight: FontWeight.w500,)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left:8.0,top: 8.0,bottom:8.0,right:10.0),
            child: SizedBox(
                  width: 40,
                  height: 20,
                  child: ProfileImagePicker(
                    onImagePicked: (value){},
                    previousImage: widget.profilePic,
                  ),
                ),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  controller: _controller,
                  itemCount:messages.length,
                    itemBuilder: (context,index){
                    GetMessages message=messages[index];
                    print(message.userId);
                    bool isMe = message.userId == AppData().userdetail!.users_id;
                    print(isMe);
                  return Container(
                    decoration: BoxDecoration(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if(message.date!.isNotEmpty)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(message.date! , style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal, color: globalBlack.withOpacity(0.5),)),
                          ],
                        ),
      isMe   ?       Container(
                        padding: EdgeInsets.symmetric(vertical: padding / 10, horizontal: padding*0.7),
                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.all(padding),
                              decoration: BoxDecoration(
                                color: globalGreen,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Text(message.message!, style: TextStyle(color: Colors.white, fontSize: 13),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ):
                        Container(
                          padding: EdgeInsets.symmetric(vertical: padding / 10, horizontal: padding*0.7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.all(padding),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25),
                                    bottomRight: Radius.circular(25),
                                    bottomLeft: Radius.zero,
                                  ),
                                ),
                                child: Text(message.message ?? "", style: TextStyle(color: globalBlack, fontSize: 13,
                                ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ],
                    ),
                  );
                }),
              )
            ),

            EventCommentTextField(
                  onTapEmoji: (){
                  FocusScopeNode currentFocus = FocusScope.of(context);
                   if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                    isEmojiShown=!isEmojiShown;
                    setState(() {});
                  },
                  onTap: (){
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                     currentFocus.unfocus();
                  }
                   if(isEmojiShown)
                    isEmojiShown=false;
                    setState(() {});
                  },
                  controller: message,
                  onTapIcon: () => sendMessage(),
                  focusNode: myFocusNode,
                ),
                if(isEmojiShown)
                EmojisPickerPage(
                  emoji: (val) => setState(()=> message.text = message.text + val)
                ),
          ],
        ),
      ),
    );
  }
}
