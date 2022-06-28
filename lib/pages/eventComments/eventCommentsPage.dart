import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/comments-model.dart';
import 'package:connevents/models/create-event-model.dart';
import 'package:connevents/models/image-videos-model.dart';
import 'package:connevents/models/mention-model.dart';
import 'package:connevents/pages/businessCommentsPages/business-Comment-Page-Functions.dart';
import 'package:connevents/pages/emojisPicker/emojis-picker.dart';
import 'package:connevents/pages/eventComments/eventCommentsPageFunctions.dart';
import 'package:connevents/pages/eventComments/widgets/action-bar.dart';
import 'package:connevents/pages/eventComments/widgets/comments-mention-user.dart';
import 'package:connevents/pages/eventDetails/widget/carousel-slider-page.dart';
import 'package:connevents/pages/eventReplyPage/event-reply-page.dart';
import 'package:connevents/pages/liveStreaming/alert-box/live-streaming-scheduled-alert.dart';
import 'package:connevents/pages/liveStreaming/alert-box/meeting-started-alert.dart';
import 'package:connevents/pages/liveStreaming/broadcast_page.dart';
import 'package:connevents/pages/messageDetails/messageDetailsPage.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/date-time.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/comment-textfield.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:connevents/widgets/profile-image-picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';

class EventCommentsPage extends StatefulWidget {
    final EventDetail? event;
    final List<ImageData>?  images;
    final bool isNotification;

  const EventCommentsPage({Key? key,this.event,this.images, this.isNotification=false}) : super(key: key);

  @override
  _EventCommentsPageState createState() => _EventCommentsPageState();
}

class _EventCommentsPageState extends State<EventCommentsPage> {
  bool isFocus=false;
  int currentSlide = 0;
  var isCommentVisible = false;
  var isMoreCommentVisible = false;
  var text;
  String? isLiked;
  int? likeCount;
  int? selectedId;
  List<CommentReplies> commentReplies=[];
  int? commentId;
  String? commentUserName;

  int? replyToCommentId;
  String? comment;
  List<Comments> comments=[];
  List<MentionCommentUserList> mentionCommentList=[];
  int? selectedComment;
  late FocusNode myFocusNode;
  TextEditingController commentText=TextEditingController();
  bool isReply=false;
  bool isShown=false;
  bool isEmojiShown=false;
  String mentionNameSelected="";

  Future likeEventPost(num eventPostId) async {
    openLoadingDialog(context, 'loading');
    try{
      var response = await DioService.post('like_event', {
        "eventPostId": eventPostId,
        "userId": AppData().userdetail!.users_id
      });
      widget.event!.liked=response['is_liked'];
      widget.event!.totalLikes=response['like_count'];
      setState(() {});
      print(isLiked);
      Navigator.of(context).pop();
    }
    catch(e){
      Navigator.of(context).pop();
    }
  }

  Future likeComment(int eventPostId,int eventCommentId) async {
    openLoadingDialog(context, 'loading');
    try{
        var response = await DioService.post('like_comment', {
        "eventCommentId": eventCommentId,
        "eventPostId": eventPostId,
        "usersId": AppData().userdetail!.users_id
      });
        print(response);

    }
    catch(e){
      Navigator.of(context).pop();
    }
  }

  Future unLikeComment(int eventPostId,int eventCommentId) async {
    openLoadingDialog(context, 'loading');
    try{
      await DioService.post('unlike_comment', {
        "eventCommentId": eventCommentId,
        "eventPostId": eventPostId,
        "usersId": AppData().userdetail!.users_id
      });
    }
    catch(e){
      Navigator.of(context).pop();
    }
  }


  Future getMentionComment() async {
    try{
      var response = await DioService.post('get_comment_mentions', {
        "eventPostId": widget.event!.eventPostId,
        "usersId": AppData().userdetail!.users_id
      });
      print(response);
      if(response['status']=="success"){
        var data =response['data'] as List;
        mentionCommentList=   data.map<MentionCommentUserList>((e) => MentionCommentUserList.fromJson(e)).toList();
        isShown=true;
        setState(() {});
      }
      else if(response['status']=="error"){
        print(response['status']);
      }
    }
    catch(e){
     // Navigator.of(context).pop();
      print(e.toString());
      // showSuccessToast(e.toString());
    }
  }

  Future getAllComments() async {
    try{
       var response = await DioService.post('get_all_comments', {
      "eventPostId": widget.event!.eventPostId,
      "usersId": AppData().userdetail!.users_id
    });
       var commentsList = response['comments'] as List;
        comments = commentsList.map<Comments>((e) => Comments.fromJson(e)).toList();
        setState(() {});
       Navigator.of(context).pop();
    }
    catch(e){
      Navigator.of(context).pop();
    }
  }

  Future unLikeEventPost(num eventPostId) async {
      openLoadingDialog(context, 'loading');
      try{
         var response = await DioService.post('unlike_event', {
        "eventPostId": eventPostId,
        "userId": AppData().userdetail!.users_id
      });

          widget.event!.liked=response['is_liked'];
         widget.event!.totalLikes=response['like_count'];
         setState((){});
         Navigator.of(context).pop();
  //   showSuccessToast(response['data']);
  }
  catch(e){
    Navigator.of(context).pop();
    //showSuccessToast(e.toString());
  }
}

  Future sendMessage() async {
  if(commentText.text.isEmpty) return showErrorToast("Please Write Some Comment");
        if(isEmojiShown) setState(() {
          isEmojiShown = false;
        });
         List list=   commentText.text.split(' ');
         if(list.contains(mentionNameSelected))
        list.remove(mentionNameSelected);
       comment = list.join(" ");
      openLoadingDialog(context, 'sending');
      var response;
        try{
          print("shahzaib");
          response   = await  DioService.post("comment_on_event", {
            "eventPostId": widget.event!.eventPostId,
            "usersId": AppData().userdetail!.users_id,
            "comment": comment,
            if(selectedId!=null)
            "mentionedUserId": selectedId,
            "commentType":isReply ? "reply": "comment",
            if(isReply)
            "replyingToCommentId": commentId
          });
          FocusManager.instance.primaryFocus!.unfocus();
          commentText.clear();
         if(!isReply)
          widget.event!.totalPostComments = (int.parse(widget.event!.totalPostComments!) + 1).toString();
          if(isReply){
           isReply=false;
         }
          setState(() {});
        }
        catch(e){
          showErrorToast(e.toString());
        }

     await  getAllComments();
  }


  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
    );
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      openLoadingDialog(context, "loading");
      getAllComments();
    });
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            CarouselSliderEventPage(event: widget.event,images: widget.images,onPressed: (){
             Navigator.of(context).pop();
            }),
            Expanded(
              child: Stack(
                children: [
                  ActionBar(
                    event: widget.event,
                    child: Column(
                    children: [
                    Expanded(
                    child: Container(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.only(top: padding),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    child: Row(
                                      children: [
                                        SvgPicture.asset('assets/icons/comments.svg', color: globalGolden, width: 18, height: 16,),
                                        SizedBox(width: padding / 2),
                                        Text(widget.event!.totalPostComments.toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.5),),
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: ()async {
                                         if(widget.event!.liked=='true')
                                           await   unLikeEventPost(widget.event!.eventPostId!);
                                           else await    likeEventPost(widget.event!.eventPostId!);
                                    },
                                    child: Row(
                                      children: [
                                        widget.event!.liked=='true' ? SvgPicture.asset('assets/icons/heart.svg', width: 18):SvgPicture.asset('assets/icons/whiteheart.svg', width: 18),
                                        SizedBox(width: padding / 2,),
                                        Text('${widget.event!.totalLikes} Likes', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.5),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(widget.event!.timeAgo.toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.5),
                                    ),
                                  ),
                                ],
                              ),
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                 padding:EdgeInsets.zero,
                                  itemCount: comments.length,
                                itemBuilder: (context,index){
                                  Comments  commentData = comments[index];
                                  print(commentData.comment);
                                  replyToCommentId=commentData.eventCommentId;
                                  return Column(
                                    children: [
                                      // Padding(
                                      //   padding:  EdgeInsets.symmetric(horizontal: padding),
                                      //   child: Divider(color: globalLGray),
                                      // ),
                                      Padding(
                                          padding: const EdgeInsets.only(left: padding,right: padding,top:8,bottom: 8.0),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              InkWell(
                                                onTap:(){
                                                  if(commentData.usersId!=AppData().userdetail!.users_id)
                                                    CustomNavigator.navigateTo(context, MessageDetailsPage(
                                                      otherUserChatId: commentData.usersId,
                                                      userName: commentData.commentUserName!,
                                                      profilePic: commentData.commentUserProfile!,
                                                    ));
                                                },
                                                child: SizedBox(
                                                  width: 50,
                                                  height: 50,
                                                  child: ProfileImagePicker(
                                                    onImagePicked: (value){},
                                                    previousImage: commentData.commentUserProfile,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: padding),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(commentData.commentUserName!, style: TextStyle(color: globalBlack, fontSize: 18, fontWeight: FontWeight.w600)),

                                                          index == 0  && widget.event!.isRoomCreated ?
                                                          widget.event!.isRoomCreated && AppData().userdetail!.users_id == widget.event!.usersId ?
                                                          TextButton(
                                                            style: TextButton.styleFrom(
                                                              // backgroundColor: globalLGray.withOpacity(0.5),
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(20),
                                                              ),
                                                            ),
                                                            onPressed: () async{
                                                              DateTime dateTime   =  DateTime.parse("${widget.event!.roomDetails!.liveDate}"" ${ widget.event!.roomDetails!.liveEndTime}");
                                                              print("hours ");
                                                              var seconds =    secondsBetween(DateTime.now(),dateTime);
                                                              DateTime liveStreamingStartingDateTime   =  DateTime.parse("${widget.event!.roomDetails!.liveDate}"" ${ widget.event!.roomDetails!.liveStartTime}");
                                                              DateTime liveStreamingEndingDateTime   =  DateTime.parse("${widget.event!.roomDetails!.liveDate}"" ${ widget.event!.roomDetails!.liveEndTime}");
                                                              print(liveStreamingStartingDateTime);

                                                              if(liveStreamingStartingDateTime.isAfter(DateTime.now())  && liveStreamingEndingDateTime.isBefore(DateTime.now())){
                                                                showDialog(
                                                                    context: context,
                                                                    builder: (BuildContext context) {
                                                                      return LiveStreamingScheduledAlert(liveDate:widget.event!.roomDetails!.liveDate ,liveTime: widget.event!.roomDetails!.convertedStartTime);
                                                                    });
                                                              }
                                                              else{

                                                                openLoadingDialog(context, 'loading');
                                                                var response = await DioService.post('start_live_stream',{
                                                                  "hostRoomId":widget.event!.roomDetails!.hostRoomId.toString(),
                                                                  "channelName" : widget.event!.roomDetails!.channelName,
                                                                  "roleId" : "1",
                                                                  "uId": AppData().userdetail!.users_id.toString(),
                                                                  "expireTimeInSeconds": seconds ,
                                                                  "userName": AppData().userdetail!.user_name.toString()
                                                                });

                                                                Navigator.of(context).pop();
                                                                final  statusCamera  =  await _handleCameraAndMic(Permission.camera);
                                                                final statusMicrophone =    await _handleCameraAndMic(Permission.microphone);
                                                                //  CustomNavigator.navigateTo(context, VideoRoomPage());
                                                                if(statusMicrophone.isGranted && statusCamera.isGranted){
                                                                  CustomNavigator.navigateTo(context, BroadcastPage(
                                                                    userId: widget.event!.usersId,
                                                                    rtcToken: response['rtc_token'],
                                                                    description: widget.event!.roomDetails!.description!,
                                                                    eventHostName: widget.event!.organizerUserName,
                                                                    rtmToken: response['rtm_token'],
                                                                    userName: AppData().userdetail!.user_name!,
                                                                    hostRoomId:  widget.event!.roomDetails!.hostRoomId!,
                                                                    channelName: widget.event!.roomDetails!.channelName!,
                                                                    isBroadcaster: true,
                                                                  ));
                                                                }
                                                                else {
                                                                  return showErrorToast("PLease Allow Permission");
                                                                }


                                                              }

                                                              // Navigator.pushNamed(context, '/videoRoom');
                                                            },
                                                            child: Column(
                                                              children: [
                                                                Text('Start Hosting', style: TextStyle(fontSize: 5, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.5),),),
                                                                SizedBox(height: padding / 4,),
                                                                SvgPicture.asset('assets/icons/video.svg', width: 20),
                                                              ],
                                                            ),
                                                          ) :
                                                          TextButton(
                                                            style: TextButton.styleFrom(
                                                              padding:EdgeInsets.all(3),
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(60),
                                                              ),
                                                            ),
                                                            onPressed: () async {
                                                              DateTime dateTime   =  DateTime.parse("${widget.event!.roomDetails!.liveDate}"" ${ widget.event!.roomDetails!.liveEndTime}");
                                                              var seconds =    secondsBetween(DateTime.now(),dateTime);
                                                              DateTime liveStreamingStartingDateTime   =  DateTime.parse("${widget.event!.roomDetails!.liveDate}"" ${ widget.event!.roomDetails!.liveStartTime}");
                                                              DateTime liveStreamingEndingDateTime   =  DateTime.parse("${widget.event!.roomDetails!.liveDate}"" ${ widget.event!.roomDetails!.liveEndTime}");
                                                              if(liveStreamingStartingDateTime.isAfter(DateTime.now())  && liveStreamingEndingDateTime.isBefore(DateTime.now())){
                                                                showDialog(
                                                                    context: context,
                                                                    builder: (BuildContext context) {
                                                                      return LiveStreamingScheduledAlert(liveDate:widget.event!.roomDetails!.liveDate ,liveTime: widget.event!.roomDetails!.convertedStartTime);
                                                                    });
                                                              }
                                                              else{
                                                                openLoadingDialog(context, 'loading');
                                                                var response = await DioService.post('start_live_stream',{
                                                                  "hostRoomId":widget.event!.roomDetails!.hostRoomId.toString(),
                                                                  "channelName" : widget.event!.roomDetails!.channelName.toString(),
                                                                  "roleId" : "2" ,
                                                                  "uId": AppData().userdetail!.users_id.toString(),
                                                                  "expireTimeInSeconds": seconds,
                                                                  "userName": AppData().userdetail!.user_name.toString()
                                                                });
                                                                Navigator.of(context).pop();
                                                                if(response['status']=="success"){
                                                                  final  statusCamera  =  await _handleCameraAndMic(Permission.camera);
                                                                  final statusMicrophone =    await _handleCameraAndMic(Permission.microphone);
                                                                  //  CustomNavigator.navigateTo(context, VideoRoomPage());
                                                                  if(statusMicrophone.isGranted && statusCamera.isGranted) {
                                                                    CustomNavigator.navigateTo(context, BroadcastPage(
                                                                      userId: widget.event!.usersId,
                                                                      rtcToken: response['rtc_token'],
                                                                      rtmToken: response['rtm_token'],
                                                                      description: widget.event!.roomDetails!.description!,
                                                                      channelName: widget.event!.roomDetails!.channelName!,
                                                                      hostRoomId:  widget.event!.roomDetails!.hostRoomId!,
                                                                      eventHostName: widget.event!.organizerUserName,
                                                                      isBroadcaster: false,
                                                                      seconds: seconds,
                                                                    ));
                                                                  }

                                                                  // CustomNavigator.navigateTo(context, VideoRoomPage());
                                                                  //  CustomNavigator.navigateTo(context, LiveStreamingVideo());
                                                                  // Navigator.pushNamed(context, '/videoRoom');
                                                                }
                                                                else if(response['status']=="error"){
                                                                  showDialog(
                                                                      barrierDismissible: false,
                                                                      context: context,
                                                                      builder: (BuildContext context) {
                                                                        return MeetingStartedAlert(message:response['data']);
                                                                      });
                                                                }
                                                              }
                                                            },
                                                            child: Column(
                                                              children: [
                                                                Text('Join Host', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.5),),),
                                                                SizedBox(height: padding / 4),
                                                                SvgPicture.asset('assets/icons/video.svg', width: 20,   color:  widget.event!.roomDetails!.isLiveStreamingStarted! == 'True' ?   Colors.red   : Color(0xffF3960B)),
                                                              ],
                                                            ),
                                                          )
                                                        :
                                                        GestureDetector(
                                                          onTap: () {
                                                            showCommentsOptionsForOtherUsersComments(context,commentData,widget.event!.usersId , () async{
                                                              openLoadingDialog(context, 'deleting');
                                                              var response= await DioService.post('delete_comment', {
                                                                "eventCommentId": commentData.eventCommentId,
                                                                "usersId": AppData().userdetail!.users_id
                                                              });
                                                              await getAllComments();
                                                              Navigator.of(context).pop();
                                                              print(response);
                                                            },
                                                              commentData.commentUserName!,
                                                            );
                                                          },
                                                          child: Icon(Icons.more_horiz),
                                                        ),


                                                      ],
                                                    ),
                                                    Wrap(
                                                      children: [
                                                        Text(commentData.mentionedUserName, style: TextStyle(color: Colors.blue , fontSize: 14)),
                                                        Text(commentData.comment!, style: TextStyle(color: globalBlack, fontSize: 14)),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 8.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          InkWell(
                                                            onTap: () async{
                                                              if(commentData.commentLiked=='true') {
                                                                await   unLikeComment(commentData.eventPostId!,commentData.eventCommentId!);
                                                                await  getAllComments();
                                                              }
                                                              else  {
                                                                await    likeComment(commentData.eventPostId!,commentData.eventCommentId!);
                                                                await    getAllComments();
                                                              }
                                                            },
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: [
                                                                commentData.commentLiked=='true'  ? SvgPicture.asset('assets/icons/heart.svg', width: 12):SvgPicture.asset('assets/icons/whiteheart.svg', width: 12),
                                                                Text(' ${commentData.totalLikes} Likes', style: TextStyle(color: globalBlack.withOpacity(0.7), fontSize: 10)),
                                                              ],
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () async {
                                                              commentId =commentData.eventCommentId;
                                                              commentUserName =commentData.commentUserName;
                                                              isReply=true;
                                                              setState(() {});
                                                            },
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                SvgPicture.asset('assets/icons/share.svg', color: globalGolden, width: 10,),
                                                                Text('${commentData.totalRepliesCount} Reply', style: TextStyle(color: globalBlack.withOpacity(0.7), fontSize: 10,),),
                                                              ],
                                                            ),
                                                          ),
                                                          Text(commentData.commentTimeAgo!, style: TextStyle(color: globalBlack.withOpacity(0.7), fontSize: 10,),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )),
                                      EventReply(comment: commentData,event: widget.event!,commentReplies: commentData.comment_replies)
                                          //  EventCommentReplyList(event: widget.event,commentData:commentData)
                                        ],
                                      );
                                    })
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                              ],
                            ),
                  ),
                  if(isShown)
                  CommentsMentionUsers(
                    selectedMentionName: (mentionName,mentionNameSelected,mentionedUserId){
                      commentText=mentionName;
                     this.mentionNameSelected = mentionNameSelected;
                     this.selectedId = mentionedUserId;
                      setState(() {});
                    },
                  mentionCommentList: mentionCommentList,
                  isShown: (val) =>setState(() => isShown=val))
                      ],
                    ),
                  ),
            isReply?
            Container(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.15),
              child: Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                    Text('Replying to :',style: TextStyle(fontSize: 12,color: Colors.black)),
                    SizedBox(width: 5,),
                    Text(commentUserName!,style: TextStyle(fontSize: 12,color: Colors.black87),),
                    SizedBox(width: 5,),
                    InkWell(
                      onTap: (){
                        isReply=!isReply;setState(() {});},
                      child: Text('Cancel',style: TextStyle(fontSize: 12 ,color: Colors.black)),
                    ),
                  ]),
            ):SizedBox(),
                EventCommentTextField(
                      isReply: isReply,
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
                      controller: commentText,
                      onTapIcon: () => sendMessage(),
                      focusNode: myFocusNode,
                      onChanged: (value)=>setState(() {
                        if(value=="@") getMentionComment();
                        else isShown=false;
                        comment=value;
                                }),
                    ),
                    if(isEmojiShown)
                    EmojisPickerPage(
                      emoji: (val){
                        commentText.text = commentText.text + val  ;
                        setState(() {});
                      },
                    ),
                    ],
                  ),
            ),
    );
  }
  Future<PermissionStatus> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    return status;
  }
}
