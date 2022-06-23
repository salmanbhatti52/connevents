import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/comments-model.dart';
import 'package:connevents/models/create-event-model.dart';
import 'package:connevents/models/mention-model.dart';
import 'package:connevents/pages/businessCommentsPages/business-Comment-Page-Functions.dart';
import 'package:connevents/pages/emojisPicker/emojis-picker.dart';
import 'package:connevents/pages/eventComments/eventCommentsPageFunctions.dart';
import 'package:connevents/pages/eventReplyPage/widget/event-reply-mention-list.dart';
import 'package:connevents/pages/messageDetails/messageDetailsPage.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/comment-textfield.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:connevents/widgets/profile-image-picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';


class EventReplyPage extends StatefulWidget {
  final  Comments? comment;
  Function(int totalRepliesCount)? totalRepliesCount;
  final EventDetail? event;
   EventReplyPage({Key? key,this.event,this.comment, this.totalRepliesCount}) : super(key: key);

  @override
  _EventReplyPageState createState() => _EventReplyPageState();
}

class _EventReplyPageState extends State<EventReplyPage> {

  bool isFocus=false;
  int currentSlide = 0;
  var isCommentVisible = false;
  var isMoreCommentVisible = false;
  var text;
  String? isLiked;
  int? likeCount;
  int? selectedId;
  bool isEmojiShown=false;

  int? replyToCommentId;
  String? comment;
  List<CommentReplies> commentReplies=[];
  List<MentionCommentUserList> mentionCommentList=[];
  int? selectedComment;
  late FocusNode myFocusNode;
  TextEditingController mentionName=TextEditingController();
  bool isReply=false;
  bool isShown=false;
  String mentionNameSelected="";
  bool isCount=false;


  Future getMentionComment() async {
    // openLoadingDialog(context, 'loading');
    try{
      var response = await DioService.post('get_comment_mentions', {
        "eventPostId": widget.event!.eventPostId,
        "usersId": AppData().userdetail!.users_id
      });
      print(response);
      // Navigator.of(context).pop();
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

  Future likeReply(int eventPostId,int eventCommentId) async {
    openLoadingDialog(context, 'loading');
    try{
      var response = await DioService.post('like_comment', {
        "eventCommentId": eventCommentId,
        "eventPostId": eventPostId,
        "usersId": AppData().userdetail!.users_id
      });
      if(response['status']=="success"){
         await    getAllCommentsReplies();
                  setState(() {});

      }
    }
    catch(e){
      Navigator.of(context).pop();
      showSuccessToast(e.toString());
    }
  }

   Future unLikeReply(int eventPostId,int eventCommentId) async {
    openLoadingDialog(context, 'loading');
    try{
      var response = await DioService.post('unlike_comment', {
        "eventCommentId": eventCommentId,
        "eventPostId": eventPostId,
        "usersId": AppData().userdetail!.users_id
      });
       if(response['status']=="success"){
         await    getAllCommentsReplies();
         setState(() {});
      }
    }
    catch(e){
      Navigator.of(context).pop();
      showSuccessToast(e.toString());
    }
  }

  Future getAllCommentsReplies() async {
    try{
      var response = await DioService.post('get_comment_replies', {
        "eventPostId": widget.event!.eventPostId,
        "usersId": AppData().userdetail!.users_id,
        "eventCommentId":widget.comment!.eventCommentId
      });
      print(response);
      widget.comment!.totalRepliesCount = response['total_comment_replies'];
      print(widget.comment!.comment_replies);
      var commentsList = response['comments'] as List;
      commentReplies = commentsList.map<CommentReplies>((e) => CommentReplies.fromJson(e)).toList();
      print(commentReplies.toList());
      setState(() {});
      Navigator.of(context).pop();
    }
    catch(e){
      print("shahzaib");
      Navigator.of(context).pop();
    }
  }

  Future sendMessage() async {
    if(mentionName.text.isEmpty) return showErrorToast("Please Write Some Comment");
      print(widget.event!.eventPostId);
      if(isEmojiShown) setState(() {
        isEmojiShown = false;
      });
      List list=   mentionName.text.split(' ');
      print(list);
      if(list.contains(mentionNameSelected))
        list.remove(mentionNameSelected);
      comment = list.join(" ");
      openLoadingDialog(context, 'sending');
      var response;
        try{
          response   = await  DioService.post("comment_on_event", {
            "eventPostId": widget.event!.eventPostId,
            "usersId": AppData().userdetail!.users_id,
            "comment": comment,
            if(selectedId!=null)
            "mentionedUserId": selectedId,
            "commentType": "reply",
            "replyingToCommentId": widget.comment!.eventCommentId
          });
          FocusManager.instance.primaryFocus!.unfocus();
          mentionName.clear();
          setState(() {});
          print(response);
        }
        catch(e){
          showErrorToast(e.toString());
        }
      await  getAllCommentsReplies();
      print(response);
  }


  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
    );
     WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      openLoadingDialog(context, "loading");
      getAllCommentsReplies();
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          children: [
            TextButton(
              onPressed: () =>  Navigator.of(context).pop(widget.comment!.totalRepliesCount) ,
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
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Column(
                    children: [
                    Expanded(
                    child: Container(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: padding,),
                        child: Column(
                          children: [
                          Column(
                          children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: padding),
                            child: Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap:(){
                                      if(widget.comment!.usersId!=AppData().userdetail!.users_id)
                                        CustomNavigator.navigateTo(context, MessageDetailsPage(
                                          userName: widget.comment!.commentUserName!,
                                          otherUserChatId: widget.comment!.usersId,
                                          profilePic:widget.comment!.commentUserProfile!,
                                        ));
                                    },
                                    child: SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: ProfileImagePicker(
                                        onImagePicked: (value){},
                                        previousImage: widget.comment?.commentUserProfile,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: padding),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(widget.comment!.commentUserName!, style: TextStyle(color: globalBlack, fontSize: 18, fontWeight: FontWeight.w600)),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left:4.0),
                                          child: Text(widget.comment!.comment!, style: TextStyle(color: globalBlack, fontSize: 14)),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                SvgPicture.asset('assets/icons/share.svg', color: globalGolden, width: 10,),
                                                Text('${widget.comment!.totalRepliesCount} Reply', style: TextStyle(color: globalBlack.withOpacity(0.7), fontSize: 10,),),
                                              ],
                                            ),
                                            TextButton(
                                              onPressed: () {},
                                              child: Text(widget.comment!.commentTimeAgo!, style: TextStyle(color: globalBlack.withOpacity(0.7), fontSize: 10,),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: commentReplies.length,
                            itemBuilder: (context,index){
                              CommentReplies commentReply  = commentReplies[index];
                              print(commentReply.replyLiked);
                              return  Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(color: globallightbg,),
                                    padding: EdgeInsets.only(left: 56 + padding + padding, right: padding, top: padding, bottom: padding,),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: ProfileImagePicker(
                                            onImagePicked: (value){},
                                            previousImage: commentReply.replyUserProfile,
                                          ),
                                        ),
                                        SizedBox(width: padding),
                                        Expanded(
                                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(commentReply.replyUserName!, style: TextStyle(color: globalBlack, fontSize: 18, fontWeight: FontWeight.w600,),),
                                                  GestureDetector(
                                                    onTap: () => showCommentsOptionsForMyComments(context,commentReply,widget.event!.usersId , () async{
                                                      openLoadingDialog(context, 'deleting');
                                                         await DioService.post('delete_comment', {
                                                        "eventCommentId": commentReply.eventCommentId,
                                                        "usersId": AppData().userdetail!.users_id
                                                      });
                                                      commentReplies.removeAt(index);
                                                      await  getAllCommentsReplies();
                                                      setState(() {});
                                                      Navigator.of(context).pop();
                                                    }),
                                                    child: Icon(Icons.more_horiz,size: 25),
                                                  ),
                                                ],
                                              ),
                                              Wrap(
                                                children: [
                                                  Text(commentReply.mentionedUserName, style: TextStyle(color: Colors.blue, fontSize: 14)),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left:2.0),
                                                    child: Text(commentReply.comment!, style: TextStyle(color: globalBlack, fontSize: 14)),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(vertical: padding / 2),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    InkWell(
                                                      onTap:()async{
                                                        if(commentReply.replyLiked=='true') {
                                                          await   unLikeReply(commentReply.eventPostId!,commentReply.eventCommentId!);

                                                        }
                                                        else  {
                                                          await    likeReply(commentReply.eventPostId!,commentReply.eventCommentId!);
                                                        }
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          commentReply.replyLiked=='true'  ? SvgPicture.asset('assets/icons/heart.svg', width: 12):SvgPicture.asset('assets/icons/whiteheart.svg', width: 12),
                                                          Text(' ${commentReply.totalLikes} Likes', style: TextStyle(color: globalBlack.withOpacity(0.7), fontSize: 8,),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Text(commentReply.replyTimeAgo!, style: TextStyle(color: globalBlack.withOpacity(0.7), fontSize: 10,
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
                                ],
                              );
                            }
                        )
          ],
                      )
                      ],
                    ),
                    ),
                  ),
              ),
                          ),

                        ],
                      ),
                  if(isShown)
                  EventReplyMentionList(
                    selectedMentionName: (val){
                      mentionName=val;
                      setState(() {});
                    },
                    isShown: (val){
                      isShown=val;
                      setState(() {});
                    },
                    mentionCommentList: mentionCommentList,
                  ),
                ],
              ),
            ),
            EventCommentTextField(
              controller: mentionName,
              // autoFocus: true,
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
              onChanged: (value) => setState(() {
                if(value=="@") getMentionComment();
                else isShown=false;
                comment=value;}),
              focusNode: myFocusNode,
              onTapIcon: () => sendMessage(),
            ),
            if(isEmojiShown)
            EmojisPickerPage(
              emoji: (val){
                mentionName.text = mentionName.text + val  ;
                setState(() {});
              },
            ),

          ],
        ),
      ),
    );
  }
}
