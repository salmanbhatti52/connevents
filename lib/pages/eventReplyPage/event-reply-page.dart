import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/comments-model.dart';
import 'package:connevents/models/create-event-model.dart';
import 'package:connevents/models/mention-model.dart';
import 'package:connevents/pages/eventComments/eventCommentsPageFunctions.dart';
import 'package:connevents/pages/messageDetails/messageDetailsPage.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:connevents/widgets/profile-image-picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class EventReply extends StatefulWidget {
  List<CommentReplies>? commentReplies;
  final EventDetail? event;
  final  Comments? comment;
   EventReply({Key? key,this.event,this.commentReplies,this.comment}) : super(key: key);

  @override
  _EventReplyState createState() => _EventReplyState();
}

class _EventReplyState extends State<EventReply> {

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
  List<MentionCommentUserList> mentionCommentList=[];
  int? selectedComment;
  late FocusNode myFocusNode;
  TextEditingController mentionName=TextEditingController();
  bool isReply=false;
  bool isShown=false;
  String mentionNameSelected="";
  bool isCount=false;
  bool viewReply=false;


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
      widget.commentReplies = commentsList.map<CommentReplies>((e) => CommentReplies.fromJson(e)).toList();
      setState(() {});
      Navigator.of(context).pop();
    }
    catch(e){
      print("shahzaib");
      Navigator.of(context).pop();
    }
  }





  @override
  Widget build(BuildContext context) {
    return widget.commentReplies!.isNotEmpty && !viewReply ? ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: 1,
        itemBuilder: (context,index){
          CommentReplies commentReply  = widget.commentReplies![index];
          return  Column(
            children: [
              Container(
                decoration: BoxDecoration(color: globallightbg),
                padding: EdgeInsets.only(left: 56 + padding + padding, right: padding, top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap:(){
                        if(commentReply.usersId!=AppData().userdetail!.users_id)
                          CustomNavigator.navigateTo(context, MessageDetailsPage(
                            userName: commentReply.replyUserName!,
                            otherUserChatId: commentReply.usersId,
                            profilePic: commentReply.replyUserProfile!,
                          ));
                      },
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: ProfileImagePicker(
                          onImagePicked: (value){},
                          previousImage: commentReply.replyUserProfile,
                        ),
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
                                  widget.commentReplies!.removeAt(index);
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
                                      Padding(
                                        padding: const EdgeInsets.only(left:1.0),
                                        child: Text(' ${commentReply.totalLikes} Likes', style: TextStyle(color: globalBlack.withOpacity(0.7), fontSize: 8,),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if(widget.commentReplies!.length>1)
                                InkWell(
                                    onTap:(){
                                      viewReply=!viewReply;
                                      setState(() {});
                                    },
                                    child: Text("view Reply", style: TextStyle(color: globalGolden, fontSize: 10,),)),
                                Text(commentReply.replyTimeAgo!, style: TextStyle(color: globalBlack.withOpacity(0.7), fontSize: 10,),),

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
    ):
    ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: widget.commentReplies!.length,
        itemBuilder: (context,index){
          CommentReplies commentReply  = widget.commentReplies![index];
          print(commentReply.replyLiked);
          return  Column(
            children: [
              Container(
                decoration: BoxDecoration(color: globallightbg),
                padding: EdgeInsets.only(left: 56 + padding + padding, right: padding, top: 10, bottom: padding),
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
                                  widget.commentReplies!.removeAt(index);
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
                              Text(commentReply.comment!, style: TextStyle(color: globalBlack, fontSize: 14)),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
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
              Divider(color:globallightbg,height: 2),
            ],
          );
        }
    );

  }
}
