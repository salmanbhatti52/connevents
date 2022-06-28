import 'dart:developer';
import 'package:agora_rtc_engine/rtc_channel.dart';
import 'package:agora_rtm/agora_rtm.dart';
import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/live-streaming-message-model.dart';
import 'package:connevents/pages/liveStreaming/alert-box/member-left-alert.dart';
import 'package:connevents/pages/videoRoom/endingLiveAlert.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/const.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/profile-image-picker.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'logs.dart';

class BroadcastPage extends StatefulWidget {
  final int? userId;
  final String channelName;
  final String userName;
  final String description;
  final eventHostName;
  final String rtcToken;
  final String rtmToken;
   bool isBroadcaster;
  final int hostRoomId;
  int? seconds;

   BroadcastPage({this.seconds,this.description="",required this.hostRoomId,this.eventHostName="",Key? key,this.rtcToken="",this.rtmToken="", this.userId,this.channelName="", this.userName="", this.isBroadcaster=false}) : super(key: key);

  @override
  _BroadcastPageState createState() => _BroadcastPageState();
}

class _BroadcastPageState extends State<BroadcastPage> {
  final _users = <int>[];
  bool _isLogin = false;
  bool _isInChannel = false;
  bool isClickHand=false;
  final _infoStrings = <String>[];
  AgoraRtmClient? _client;
  AgoraRtmChannel? _channel;
  RtcEngine? _engine;
  bool isSlidingPanel =false;
  List<LiveStreamingChat> messageList=[];
  List<LiveStreamingChat> slidingPaneList=[];
  RtcChannel?    rtcChannel;
  String selectedSegment = 'video';
  bool isJoined=false;
  bool switchCamera = true;
  bool muted = false;
  bool  openMicrophone = true;
  bool isRelaying=false;
  bool isAudioMood=false;
  int channelCount=0;
  List<String> list=[];
  String joinedUser="";
  bool isAllowing=false;

  LogController logController = LogController();

  final _channelMessageController = TextEditingController();
  LiveStreamingChat _liveStreamingChat = LiveStreamingChat();


     Future changeRequestRole() async {
     await _engine!.setClientRole(ClientRole.Audience);
     widget.isBroadcaster=false;
     isClickHand=false;
     setState(() {});
     await _channel!.sendMessage(AgoraRtmMessage.fromText("${AppData().userdetail!.profile_picture ?? "https://www.google.com/imgres?imgurl=https%3A%2F%2Fhelpx.adobe.com%2Fcontent%2Fdam%2Fhelp%2Fen%2Fphotoshop%2Fusing%2Fconvert-color-image-black-white%2Fjcr_content%2Fmain-pars%2Fbefore_and_after%2Fimage-before%2FLandscape-Color.jpg&imgrefurl=https%3A%2F%2Fhelpx.adobe.com%2Fphotoshop%2Fusing%2Fconvert-color-image-black-white.html&tbnid=2DNOEjVi-CBaYM&vet=12ahUKEwibzcaFl8_2AhVKEmMBHT1HCpsQMygDegUIARDcAQ..i&docid=AOz9-XMe1ixZJM&w=1601&h=664&q=image&ved=2ahUKEwibzcaFl8_2AhVKEmMBHT1HCpsQMygDegUIARDcAQ"}," +  "${AppData().userdetail!.user_name}," + "Withdraw Join Request"));

   }


  Future<void> getChannelCount() async {
    var membersData = await _channel?.getMembers();
    setState(() {
      if (membersData != null) {
        channelCount = membersData.length;
     //   showSuccessToast("Channel Count:$channelCount");
      }
    });
  }



  void _sendChannelMessage() async {
    if (_channelMessageController.text.isEmpty) {
      return;
    }
    try {
      await _channel!.sendMessage(AgoraRtmMessage.fromText("${AppData().userdetail!.profile_picture ?? "https://www.google.com/imgres?imgurl=https%3A%2F%2Fhelpx.adobe.com%2Fcontent%2Fdam%2Fhelp%2Fen%2Fphotoshop%2Fusing%2Fconvert-color-image-black-white%2Fjcr_content%2Fmain-pars%2Fbefore_and_after%2Fimage-before%2FLandscape-Color.jpg&imgrefurl=https%3A%2F%2Fhelpx.adobe.com%2Fphotoshop%2Fusing%2Fconvert-color-image-black-white.html&tbnid=2DNOEjVi-CBaYM&vet=12ahUKEwibzcaFl8_2AhVKEmMBHT1HCpsQMygDegUIARDcAQ..i&docid=AOz9-XMe1ixZJM&w=1601&h=664&q=image&ved=2ahUKEwibzcaFl8_2AhVKEmMBHT1HCpsQMygDegUIARDcAQ"}," +  "${AppData().userdetail!.user_name}," + "${_channelMessageController.text}"));
      messageList.add(LiveStreamingChat(
        message: _channelMessageController.text,
        profilePicture: AppData().userdetail!.profile_picture ?? "https://www.google.com/imgres?imgurl=https%3A%2F%2Fhelpx.adobe.com%2Fcontent%2Fdam%2Fhelp%2Fen%2Fphotoshop%2Fusing%2Fconvert-color-image-black-white%2Fjcr_content%2Fmain-pars%2Fbefore_and_after%2Fimage-before%2FLandscape-Color.jpg&imgrefurl=https%3A%2F%2Fhelpx.adobe.com%2Fphotoshop%2Fusing%2Fconvert-color-image-black-white.html&tbnid=2DNOEjVi-CBaYM&vet=12ahUKEwibzcaFl8_2AhVKEmMBHT1HCpsQMygDegUIARDcAQ..i&docid=AOz9-XMe1ixZJM&w=1601&h=664&q=image&ved=2ahUKEwibzcaFl8_2AhVKEmMBHT1HCpsQMygDegUIARDcAQ",
        userName: AppData().userdetail!.user_name!
      ));
      _channelMessageController.clear();
      setState(() {});
    //  widget.logController!.addLog('Send channel message success.');
     //  showSuccessToast(_channelMessageController.text.toString());
    } catch (errorCode) {
       // showSuccessToast(" helooo   ${errorCode.toString()}");
    //  widget.logController!.addLog('Send channel message error: ' + errorCode.toString());
    }
  }


   Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    if(status.isGranted){
       initialize(true);
    }
  }

  Future  _switchMicrophone() async{
   await _engine!.enableLocalAudio(!openMicrophone).then((value) {
      setState(() {
        openMicrophone = !openMicrophone;
      });
    }).catchError((err) {
      log('enableLocalAudio $err');
    });
  }

  Future  _switchCamera() async {
  await  _engine!.switchCamera().then((value) {
      setState(() {
        switchCamera = !switchCamera;
      });
    }).catchError((err) {
      log('switchCamera $err');
    });
  }

  Future<void> onJoin() async {
    await _handleCameraAndMic(Permission.camera);
    await _handleCameraAndMic(Permission.microphone);
  }




  @override
  void dispose() {
    // clear users
    _users.clear();
    // destroy sdk and leave channel
    _engine!.destroy();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // initialize agora sdk
    // initialize RTC (Real Time Communication)
    initialize(true);
    // initialize RTM (Real Time Messaging)
    _createClientRtm();
   // _createClient();
  // onJoin();
  }


  //Rtm Implementation
   void _createClientRtm() async {
    _client = await AgoraRtmClient.createInstance(appId);
    _client!.onMessageReceived = (AgoraRtmMessage message, String peerId) {
      logController.addLog("Private Message from " + peerId + ": " + message.text);
    };
    _client!.onConnectionStateChanged = (int state, int reason) async {
      logController.addLog('Connection state changed: ' + state.toString() + ', reason: ' + reason.toString());
      if (state == 5) {
        _client!.logout();
        logController.addLog('Logout.');
      }
    };
       _loginRtm(context);
  }

   void _loginRtm(BuildContext context) async {

    try {
      await _client!.login(widget.rtmToken , AppData().userdetail!.user_name.toString());
      logController.addLog('Login success: ' + AppData().userdetail!.user_name.toString());
      _joinChannelRtm(context);
    } catch (errorCode) {
      print('Login error: ' + errorCode.toString());
    }
  }

  void _joinChannelRtm(BuildContext context) async {
    try {
      _channel = await _createChannelRtm(widget.channelName);
      await _channel!.join();
      await getChannelCount();
      logController.addLog('Join channel success.');
    } catch (errorCode) {
          //  showSuccessToast('Join channel error: ' + errorCode.toString());

      print('Join channel error: ' + errorCode.toString());
    }
  }

  Future<AgoraRtmChannel> _createChannelRtm(String name) async {
    AgoraRtmChannel? channel = await _client!.createChannel(name);
    channel!.onMemberJoined = (AgoraRtmMember member) async {
      await getChannelCount();
      // messageList.add(LiveStreamingChat(
      //   userName: member.userId + ': joined'
      // ));
      setState(() {});
      //showSuccessToast("Member joined: " + member.userId + ', channel: ' + member.channelId);
      showSuccessToast('${member.userId} joined');
    };

    channel.onMemberLeft = (AgoraRtmMember member) async{

      if(widget.eventHostName==member.userId){

        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return MemberLeftAlert();
            });
      }

      else{

       // showErrorToast("Member:"+member.userId);
        if(joinedUser==member.userId){
          joinedUser="";
        }
        if(slidingPaneList.any((element) => element.userName==member.userId)){
          slidingPaneList.removeWhere((element) => element.userName==member.userId);
        }
      //    messageList.add(LiveStreamingChat(
      //   userName: member.userId + ': Left'
      // ));
      }
      await getChannelCount();
      //showSuccessToast("Member left: " + member.userId + ', channel: ' + member.channelId);

 setState(() {});
      showSuccessToast('${member.userId} left');
    };
    channel.onMessageReceived = (AgoraRtmMessage message, AgoraRtmMember member) async{
       list= message.text.split(',');
       if(list[2]=="Requested to Join"){
         if(!slidingPaneList.any((element) => element.userName==list[1]))
            slidingPaneList.add(LiveStreamingChat(
            profilePicture: list[0],
            userName: list[1],
            message: list[2],
          ));
       }
       else if(list[2]=="Withdraw Join Request"){
         if(slidingPaneList.any((element) => element.userName==member.userId)){
           slidingPaneList.removeWhere((element) => element.userName==member.userId);
         }
         if(joinedUser==member.userId){
           joinedUser="";
         }
       }
       else if(list[2]=="Shifted to Audience"){

         if(list[1]==AppData().userdetail!.user_name){
           changeRequestRole();
         }
       }


       else if(list[2]=="Accepted to Join") {
         print(list[1]);
         setState(() {});
         if(list[1]==AppData().userdetail!.user_name){

           await _engine!.leaveChannel();
           openLoadingDialog(context, 'joining');
           var response = await DioService.post('start_live_stream',{
             "hostRoomId":widget.hostRoomId.toString(),
             "channelName" : widget.channelName.toString(),
             "roleId" : "1" ,
             "uId": AppData().userdetail!.users_id.toString(),
             "expireTimeInSeconds": widget.seconds,
             "userName": AppData().userdetail!.user_name.toString()
           });
           print(response);
           Navigator.of(context).pop();
         // await initialize(true);
           widget.isBroadcaster=true;
          // _initAgoraRtcEngine(false);
           RtcEngineContext contexts = RtcEngineContext(appId);
           _engine = await RtcEngine.createWithContext(contexts);
           await _engine!.enableVideo();
           isAudioMood=false;
           await _engine!.setChannelProfile(ChannelProfile.LiveBroadcasting);
           await _engine!.setClientRole(ClientRole.Broadcaster);
           await _engine!.joinChannel(response['rtc_token'], widget.channelName, null,  AppData().userdetail!.users_id!);
           _addListener();
           setState(() {});
           // slidingPaneList.add(LiveStreamingChat(
           //   profilePicture: list[0],
           //   userName: list[1],
           //   message: list[2],
           // ));
         }
       }
       else{
        messageList.add(LiveStreamingChat(
        profilePicture: list[0],
        userName: list[1],
        message: list[2],
      ));
       }

      setState(() {});
    //  showSuccessToast("Public Message from " + member.userId + ": " + message.text);
      logController.addLog("Public Message from " + member.userId + ": " + message.text);
    };
    return channel;
  }



  //Rtc Implementation
  Future<void> initialize(bool isVideo) async {
    print('Client Role: ${widget.isBroadcaster}');
    if (appId.isEmpty) {
      setState(() {
        _infoStrings.add(
          'APP_ID missing, please provide your APP_ID in settings.dart',
        );
        _infoStrings.add('Agora Engine is not starting');
      });
      return;
    }
    print("appId");
    print(appId);
    await _initAgoraRtcEngine(isVideo);

    await _engine!.joinChannel(widget.rtcToken, widget.channelName, null,  AppData().userdetail!.users_id!);
    _addListener();

  }

  Future<void> _initAgoraRtcEngine(isVideo) async {
    RtcEngineContext context = RtcEngineContext(appId);
    _engine = await RtcEngine.createWithContext(context);
    print(isVideo);
    if(isVideo) {
      await _engine!.enableVideo();
      isAudioMood=false;
    }
    else{
      await _engine!.disableVideo();
      await _engine!.enableAudio();
      isAudioMood=true;
      setState(() {});
    }
    await _engine!.setChannelProfile(ChannelProfile.LiveBroadcasting);
    if (widget.isBroadcaster) {
      await _engine!.setClientRole(ClientRole.Broadcaster);
    } else {
      await _engine!.setClientRole(ClientRole.Audience);
    }
  }


  _addListener() {
    _engine!.setEventHandler(RtcEngineEventHandler(warning: (warningCode) {

    //showErrorToast('Warning ${warningCode}');
    //  log('Warning ${warningCode}');
    },  streamMessage: (int uid, int streamId,  data) {
      /// change for 2.10
      _showMyDialog(uid, streamId, data.toString());
      log('streamMessage $uid $streamId $data');
    },
        streamMessageError: (int uid, int streamId, ErrorCode error, int missed, int cached) {
      log('streamMessage $uid $streamId $error $missed $cached');
    },tokenPrivilegeWillExpire: (token) async {
               //I need to renew token here
             await rtcChannel!.renewToken(token);
            },
        error: (errorCode) {
      log('Error here $errorCode');
     // showErrorToast('Error here ${errorCode}');
    }, joinChannelSuccess: (channel, uid, elapsed) {
     // showErrorToast("join ${channel} ${uid} ${elapsed}");
      log('joinChannelSuccess $channel $uid $elapsed');
      setState(() {
        isJoined = true;
      });
    }, userJoined: (uid, elapsed) {
      log('userJoined $uid $elapsed');
     //  showErrorToast('userJoined $uid $elapsed');
      this.setState(() {
        final info = '${AppData().userdetail!.user_name}: joined';
        // messageList.add(LiveStreamingChat(
        //   userName: info
        // ));
               _infoStrings.add(info);
              if(!_users.contains(uid)){
                _users.add(uid);
              }
      });
    }, userOffline: (uid, reason) {

    //  log('userOffline $uid $reason');
      // showErrorToast('userOffline $uid $reason');
      this.setState(() {
        final info = 'userOffline: $uid';
              _infoStrings.add(info);
               _users.remove(uid);
      });
    }, channelMediaRelayStateChanged:
        (ChannelMediaRelayState state, ChannelMediaRelayError code) {
      switch (state) {
        case ChannelMediaRelayState.Idle:
      //    log('ChannelMediaRelayState.Idle $code');
          this.setState(() {
            isRelaying = false;
          });
          break;
        case ChannelMediaRelayState.Connecting:
        //  log('ChannelMediaRelayState.Connecting $code)');
          break;
        case ChannelMediaRelayState.Running:
       //   log('ChannelMediaRelayState.Running $code)');
          this.setState(() {
            isRelaying = true;
          });
          break;
        case ChannelMediaRelayState.Failure:
         // log('ChannelMediaRelayState.Failure $code)');
          this.setState(() {
            isRelaying = false;
          });
          break;
        default:
          //log('default $code)');
          break;
      }
    }));
  }

  @override
  Widget build(BuildContext context) {

      SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white,
      ),
    );
    return WillPopScope(
      onWillPop: () async {
       return  await   showDialog(
            context: context,
            builder: (BuildContext context) {
              return EndingLiveAlert(engine: _engine,channel: _channel,hostRoomId: widget.hostRoomId,eventHostName: widget.eventHostName);
            });
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Stack(
            children: <Widget>[
               Stack(
                 children: [
                   _viewRows(),
                   if((widget.isBroadcaster && AppData().userdetail!.users_id != widget.userId) || (AppData().userdetail!.users_id == widget.userId && joinedUser.isNotEmpty))
                   Positioned(
                     bottom:10,
                     right: 25,
                     child: SizedBox(
                       width: 30,
                       height:  27,
                       child: TextButton(
                         onPressed: () async {
                          if(AppData().userdetail!.users_id==widget.userId){
                            await _channel!.sendMessage(AgoraRtmMessage.fromText("${AppData().userdetail!.profile_picture ?? "https://www.google.com/imgres?imgurl=https%3A%2F%2Fhelpx.adobe.com%2Fcontent%2Fdam%2Fhelp%2Fen%2Fphotoshop%2Fusing%2Fconvert-color-image-black-white%2Fjcr_content%2Fmain-pars%2Fbefore_and_after%2Fimage-before%2FLandscape-Color.jpg&imgrefurl=https%3A%2F%2Fhelpx.adobe.com%2Fphotoshop%2Fusing%2Fconvert-color-image-black-white.html&tbnid=2DNOEjVi-CBaYM&vet=12ahUKEwibzcaFl8_2AhVKEmMBHT1HCpsQMygDegUIARDcAQ..i&docid=AOz9-XMe1ixZJM&w=1601&h=664&q=image&ved=2ahUKEwibzcaFl8_2AhVKEmMBHT1HCpsQMygDegUIARDcAQ"}," +  "$joinedUser," + "Shifted to Audience"));
                            joinedUser="";
                            setState((){});
                          }

                          else
                          await changeRequestRole();
                           //   showDialog(
                           //     context: context,
                           //     builder: (BuildContext context) {
                           //     return EndingLiveAlert(engine: _engine,channel: _channel,hostRoomId: widget.hostRoomId,eventHostName: widget.eventHostName);
                           //     });
                         },
                         style: TextButton.styleFrom(
                           backgroundColor: Colors.red,
                           padding: EdgeInsets.zero,
                         ),
                         child: Icon(Icons.close, color: Colors.white),
                       ),
                     ),
                   ),
                 ],
               ),

              //  Padding(
              //   padding: const EdgeInsets.only(top:500.0),
              //   child: MessageScreen(channel: _channel,client: _client,logController: logController),
              // ),
              //_buildInfoList(),
              //_toolbar(),
               if(widget.isBroadcaster)
               _changingStream(),
               _cancelStreaming(),

              _buildSendChannelMessage(),
            ],
          ),
        ),
      ),
    );
  }


  Widget _slidingPanel() {
    return  Container(
          margin: EdgeInsets.symmetric(vertical: padding / 2, horizontal: padding),
          child: SlidingUpPanel(
            onPanelClosed: (){
              isSlidingPanel=false;
              setState(() {});
            },
            borderRadius: BorderRadius.circular(10),
            minHeight: 45,
            defaultPanelState: PanelState.OPEN,
            header: Container(
              height: 45,
              child: Divider(color: Colors.white),
            ),
            panel: Container(
              decoration: BoxDecoration(color: globalBlack.withOpacity(0.8)),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: padding / 2),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 54,
                          child: Divider(
                            color: globalLGray,
                            thickness: 3,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: padding),
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/icons/hand.svg'),
                              SizedBox(width: padding,),
                              Text('Show', style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14, fontWeight: FontWeight.bold,),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: slidingPaneList.length,
                      itemBuilder: (context, index) {

                        return InkWell(
                          onTap: ()async{
                            if(joinedUser.isEmpty){
                              isAllowing=true;
                              setState(() {});
                              joinedUser=slidingPaneList[index].userName;
                              await _channel!.sendMessage(AgoraRtmMessage.fromText("${AppData().userdetail!.profile_picture ?? "https://www.google.com/imgres?imgurl=https%3A%2F%2Fhelpx.adobe.com%2Fcontent%2Fdam%2Fhelp%2Fen%2Fphotoshop%2Fusing%2Fconvert-color-image-black-white%2Fjcr_content%2Fmain-pars%2Fbefore_and_after%2Fimage-before%2FLandscape-Color.jpg&imgrefurl=https%3A%2F%2Fhelpx.adobe.com%2Fphotoshop%2Fusing%2Fconvert-color-image-black-white.html&tbnid=2DNOEjVi-CBaYM&vet=12ahUKEwibzcaFl8_2AhVKEmMBHT1HCpsQMygDegUIARDcAQ..i&docid=AOz9-XMe1ixZJM&w=1601&h=664&q=image&ved=2ahUKEwibzcaFl8_2AhVKEmMBHT1HCpsQMygDegUIARDcAQ"}," +  "${slidingPaneList[index].userName}," + "Accepted to Join"));
                            }
                            else{
                              showErrorToast("Already User Joined");
                            }


                            // showDialog(
                            //     context: context,
                            //     builder: (BuildContext
                            //     context) {
                            //       return RaiseHandAlert();
                            //     });
                          },
                          child: Container(
                            padding: EdgeInsets.all(padding),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  child: Image.network(slidingPaneList[index].profilePicture ==null || slidingPaneList[index].profilePicture!.isEmpty ?  "https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg":  slidingPaneList[index].profilePicture!, fit: BoxFit.cover)),
                                SizedBox(width: padding),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(slidingPaneList[index].userName, style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12,),),
                                      SizedBox(height: padding / 3),
                                      Text(slidingPaneList[index].message, style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold,),),
                                    ],
                                  ),
                                ),
                                SizedBox(width: padding / 3),
                                Text(joinedUser==slidingPaneList[index].userName?"Allowed":'Accept', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold,),),
                                SizedBox(width: padding * 2),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
  }


  Widget _cancelStreaming() {
     return  Positioned(
             top: 40,
             left: 0,
             right: 0,
       child: Padding(
         padding: const EdgeInsets.only(left: 20.0,right:20),
         child: Container(
           width: MediaQuery.of(context).size.width,
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
              Row(
                children: [
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: ProfileImagePicker(
                    onImagePicked: (value){},
                    previousImage: AppData().userdetail!.profile_picture),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Text(AppData().userdetail!.user_name!,style: TextStyle(color: Colors.white)),
                  ),

                ],
              ),
               Row(
                 children: [
                   Icon(Icons.remove_red_eye_rounded,color:Colors.white),
                   Padding(
                     padding: const EdgeInsets.only(left:8.0,right:8.0),
                     child: Text(channelCount.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize:16)),
                   ),

                   SizedBox(
                          width: 51,
                          height: 27,
                          child: TextButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return EndingLiveAlert(engine: _engine,channel: _channel,hostRoomId: widget.hostRoomId,eventHostName: widget.eventHostName);
                                  });
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.red,
                              padding: EdgeInsets.zero,
                            ),
                            child: Icon(Icons.close, color: Colors.white),
                          ),
                        ),
                 ],
               ),
             ],
           ),
         ),
       ),
     );
  }


   void _logPeer(String info) {
     info = '%' + info;
     print(info);
     setState(() {
       _infoStrings.insert(0, info);
     });
   }


  /// Helper function to get list of native views
  List<Widget> _getRenderViews() {
    final List<StatefulWidget> list = [];
    if(widget.isBroadcaster){
      list.add(RtcLocalView.SurfaceView());
    }
    print("list2.toList()");
    print(_users.length);
    print("list2.toList()");
    /// change for 2.10
    _users.forEach((int uid) => list.add(RtcRemoteView.SurfaceView(uid: uid,channelId: widget.channelName)));
    // print("list.toList()");
    // print(list.toList());
    // print("list here");
    return list;
  }

  /// Video view wrapper
  Widget _videoView(view) {
    return Expanded(child: Container(child: view));
  }

  /// Video view row wrapper
  Widget _expandedVideoRow(List<Widget> views) {
    final wrappedViews = views.map<Widget>(_videoView).toList();
    return Expanded(
      child: Row(
        children: wrappedViews,
      ),
    );
  }




   Widget _buildInfoList() {
    return Padding(
      padding: const EdgeInsets.only(bottom:80.0),
      child: Expanded(
          child: Container(
              child: _infoStrings.length > 0
                  ? ListView.builder(
                    itemCount: _infoStrings.length,
                      reverse: true,
                      itemBuilder: (context, i) {
                        return Container(
                          child: ListTile(
                            title: Align(
                              alignment: _infoStrings[i].startsWith('%')
                                  ? Alignment.bottomLeft
                                  : Alignment.bottomLeft,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                                color: Colors.grey,
                                child: Column(
                                  crossAxisAlignment: _infoStrings[i].startsWith('%') ?  CrossAxisAlignment.start : CrossAxisAlignment.end,
                                  children: [
                                    _infoStrings[i].startsWith('%')
                                    ? Text(
                                        _infoStrings[i].substring(1),
                                        maxLines: 10,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(color: Colors.black),
                                      )
                                    : Text(
                                        _infoStrings[i],
                                        maxLines: 10,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    Text(
                                      widget.channelName,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 10,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },

                    )
                  : Container())),
    );
  }


   Widget _buildSendChannelMessage() {
    // if (!_isLogin || !_isInChannel) {
    //   return Container();
    // }
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
         height:MediaQuery.of(context).size.height/1.7,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:8.0,left:17.0),
                  child: Text("Comments",style:TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 20)),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top:80),
              height:MediaQuery.of(context).size.height/2,
              child: ListView.builder(
               physics: BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                  itemCount: messageList.length,
                  itemBuilder: (context,index){
                  return  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(messageList[index].profilePicture==null || messageList[index].profilePicture!.isEmpty ? "https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg" : messageList[index].profilePicture!)),
                    title: Text(messageList[index].userName,style:TextStyle(color:Colors.white)),
                    subtitle: Text(messageList[index].message,style:TextStyle(color:Colors.white)),
                  );
                  }),
            ),

        isSlidingPanel?
        _slidingPanel():
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.65,
                      height: 45,
                      padding: EdgeInsets.only(bottom:10),
                      child: TextFormField(
                        showCursor: true,
                        enableSuggestions: true,
                        textCapitalization: TextCapitalization.sentences,
                        style: TextStyle(color: Colors.white),
                        controller: _channelMessageController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 12,left:12),
                          filled: true,
                          fillColor: Color(0xff1B1B1B),
                          hintText: 'Comment...',
                          hintStyle: TextStyle(color:Colors.white,fontSize:12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color:Color(0xff1B1B1B), width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Color(0xff1B1B1B), width: 2),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: InkWell(
                        onTap: _sendChannelMessage,
                        child: Icon(Icons.send, color: Color(0xffFFA800)),
                      ),
                    ),
                    InkWell(
                      onTap: ()async{
                        if(AppData().userdetail!.users_id == widget.userId) {
                          isSlidingPanel=true;
                          setState(() {});
                        }else
                        if(isClickHand){
                          await _channel!.sendMessage(AgoraRtmMessage.fromText("${AppData().userdetail!.profile_picture ?? "https://www.google.com/imgres?imgurl=https%3A%2F%2Fhelpx.adobe.com%2Fcontent%2Fdam%2Fhelp%2Fen%2Fphotoshop%2Fusing%2Fconvert-color-image-black-white%2Fjcr_content%2Fmain-pars%2Fbefore_and_after%2Fimage-before%2FLandscape-Color.jpg&imgrefurl=https%3A%2F%2Fhelpx.adobe.com%2Fphotoshop%2Fusing%2Fconvert-color-image-black-white.html&tbnid=2DNOEjVi-CBaYM&vet=12ahUKEwibzcaFl8_2AhVKEmMBHT1HCpsQMygDegUIARDcAQ..i&docid=AOz9-XMe1ixZJM&w=1601&h=664&q=image&ved=2ahUKEwibzcaFl8_2AhVKEmMBHT1HCpsQMygDegUIARDcAQ"}," +  "${AppData().userdetail!.user_name}," + "Withdraw Join Request"));
                          isClickHand=!isClickHand;
                        }
                        else{
                          await _channel!.sendMessage(AgoraRtmMessage.fromText("${AppData().userdetail!.profile_picture ?? "https://www.google.com/imgres?imgurl=https%3A%2F%2Fhelpx.adobe.com%2Fcontent%2Fdam%2Fhelp%2Fen%2Fphotoshop%2Fusing%2Fconvert-color-image-black-white%2Fjcr_content%2Fmain-pars%2Fbefore_and_after%2Fimage-before%2FLandscape-Color.jpg&imgrefurl=https%3A%2F%2Fhelpx.adobe.com%2Fphotoshop%2Fusing%2Fconvert-color-image-black-white.html&tbnid=2DNOEjVi-CBaYM&vet=12ahUKEwibzcaFl8_2AhVKEmMBHT1HCpsQMygDegUIARDcAQ..i&docid=AOz9-XMe1ixZJM&w=1601&h=664&q=image&ved=2ahUKEwibzcaFl8_2AhVKEmMBHT1HCpsQMygDegUIARDcAQ"}," +  "${AppData().userdetail!.user_name}," + "Requested to Join"));
                          isClickHand=!isClickHand;
                        }

                        setState(() {});
                      },
                        child: Stack(
                          children: [
                            SvgPicture.asset('assets/icons/hand.svg', height: isClickHand ? 25 : 20  , color:isClickHand ? Colors.green: Color(0xffFFA800)),
                            if(slidingPaneList.length > 0)
                            Container(
                              width: 12,
                              height: 12,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                  color: Colors.red
                                ),
                                child: Text(slidingPaneList.length.toString() ,style: TextStyle(color: Colors.white,fontSize: 8,fontWeight: FontWeight.bold)))
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _changingStream() {
    return  Padding(
              padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.12,left: MediaQuery.of(context).size.width*0.09),
              child: Container(
              height: 30,
              width: MediaQuery.of(context).size.width/1.2,
              decoration: BoxDecoration(
                color: globalLightButtonbg.withOpacity(0.3),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: globalGreen),
              ),
              child: Row(
                children: [
              Expanded(
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: (selectedSegment == 'video')
                      ? BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          border: Border.all(color: globalGreen),
                          borderRadius: BorderRadius.circular(30),
                        )
                      : BoxDecoration(),
                  child: TextButton(
                    onPressed: () async{

                     await _initAgoraRtcEngine(true);
                      setState(() {
                        selectedSegment = 'video';
                      });
                    },
                    child: Text('Video', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: (selectedSegment == 'audio')
                      ? BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          border: Border.all(color: globalGreen),
                          borderRadius: BorderRadius.circular(30),
                        )
                      : BoxDecoration(),
                  child: TextButton(
                      onPressed: () async{
                         await _initAgoraRtcEngine(false);
                        setState(() {
                          selectedSegment = 'audio';
                        });
                      },
                      child: Text('Audio', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))),
                ),
              ),
                ],
              )),
            );
  }

  /// Video layout wrapper
  Widget _viewRows() {
    final views = _getRenderViews();
    print("length here");
    print(views.length);
    print("length here");

    switch (views.length) {
      case 1:
        return Container(
             color: Colors.blueGrey.shade500,
             height:MediaQuery.of(context).size.height/2.6,
             child: Column(
             children: <Widget>[
             isAudioMood ?
             Padding(padding: EdgeInsets.only(top: 150 ),
             child: Center(child: Image.asset('assets/imgs/audioSignals.png', color: Colors.red,fit: BoxFit.contain)))
              :  _videoView(views[0])
          ],
        ));
      case 2:
        return Container(
             height:MediaQuery.of(context).size.height/2.5,
             child: isAudioMood ?
             Padding(padding: EdgeInsets.only(top: 150 ),
                 child: Center(child: Image.asset('assets/imgs/audioSignals.png', color: Colors.red,fit: BoxFit.contain))):
             Row(
             children: <Widget>[
            _expandedVideoRow([views[0]]),
               _expandedVideoRow([views[1]]),
          ],
        ));
      // case 3:
      //   return Container(
      //      height:MediaQuery.of(context).size.height/2.5,
      //      child: Row(
      //      children: <Widget>[
      //      _expandedVideoRow(views.sublist(0, 2)),
      //      _expandedVideoRow(views.sublist(2, 3))
      //     ],
      //   ));
      // case 4:
      //   return Container(
      //       height:MediaQuery.of(context).size.height/2.5,
      //       child: Row(
      //       children: <Widget>[
      //       _expandedVideoRow(views.sublist(0, 2)),
      //       _expandedVideoRow(views.sublist(2, 4))
      //     ],
      //   ));
      default:
    }
    return Container();
  }

  void _onCallEnd(BuildContext context) {
    Navigator.pop(context);
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine!.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    _engine!.switchCamera();
  }


  Future<void> _showMyDialog(int uid, int streamId, String data) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Receive from uid:$uid'),
          content: SingleChildScrollView(
          child: ListBody(
          children: <Widget>[Text('StreamId $streamId:$data')],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }



}
