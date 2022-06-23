import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/business-comment-model.dart';
import 'package:connevents/models/image-videos-model.dart';
import 'package:connevents/models/mention-model.dart';
import 'package:connevents/pages/businessCommentsPages/business-Comment-Page-Functions.dart';
import 'package:connevents/pages/businessCommentsPages/widgets/business-action-bar.dart';
import 'package:connevents/pages/businessReplyPage/business-reply-page.dart';
import 'package:connevents/pages/emojisPicker/emojis-picker.dart';
import 'package:connevents/pages/eventComments/eventCommentsPageFunctions.dart';
import 'package:connevents/pages/eventComments/widgets/comments-mention-user.dart';
import 'package:connevents/pages/home/businessPage/business-carousel-slider.dart';
import 'package:connevents/pages/messageDetails/messageDetailsPage.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/carousel-slider--business-page.dart';
import 'package:connevents/widgets/comment-textfield.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:connevents/widgets/profile-image-picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:connevents/models/business-create-model.dart';


class BusinessCommentsPage extends StatefulWidget {
    final Business? business;
    final List<ImageData>?  images;
    final bool isNotification;

  const BusinessCommentsPage({Key? key,this.business,this.images, this.isNotification=false}) : super(key: key);

  @override
  _BusinessCommentsPageState createState() => _BusinessCommentsPageState();
}

class _BusinessCommentsPageState extends State<BusinessCommentsPage> {
  bool isFocus=false;
  int currentSlide = 0;
  var isCommentVisible = false;
  var isMoreCommentVisible = false;
  var text;
  String? isLiked;
  int? likeCount;
  int? selectedId;
  String? commentUserName;

  int? replyToCommentId;
  String? comment;
  List<BusinessComments> businessComments=[];
  List<MentionCommentUserList> mentionCommentList=[];
  int? selectedComment;
  late FocusNode myFocusNode;
  TextEditingController mentionName=TextEditingController();
  bool isReply=false;
  bool isShown=false;
  bool isEmojiShown=false;
  int? businessCommentId;
  String mentionNameSelected="";


  Future likeBusinessComment(int businessId,int businessCommentId) async {
    openLoadingDialog(context, 'loading');
    try{
      var response = await DioService.post('like_comment_business', {
        "businessCommentId": businessCommentId,
        "businessId": businessId,
        "usersId": AppData().userdetail!.users_id
      });
      // showSuccessToast(response['data']);

    }
    catch(e){
      print("shahzaib");
      Navigator.of(context).pop();
      // showSuccessToast(e.toString());
    }
  }

  Future unLikeBusinessComment(int businessId,int businessCommentId) async {
    openLoadingDialog(context, 'loading');
    try{
      var response = await DioService.post('unlike_comment_business', {
        "businessCommentId": businessCommentId,
        "businessId": businessId,
        "usersId": AppData().userdetail!.users_id
      });
    }
    catch(e){
      Navigator.of(context).pop();
    }
  }

  Future getMentionComment() async {
    try{
      var response = await DioService.post('get_comment_mentions_business', {
        "businessId": widget.business!.businessId,
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

  Future getAllBusinessComments() async {
    try{
       var response = await DioService.post('get_all_comments_business', {
      "businessId": widget.business!.businessId,
      "usersId": AppData().userdetail!.users_id
    });
       var commentsList = response['comments'] as List;
        businessComments = commentsList.map<BusinessComments>((e) => BusinessComments.fromJson(e)).toList();
        setState(() {});
       Navigator.of(context).pop();
    }
    catch(e){
      print("shahzaib");
      Navigator.of(context).pop();
    }
  }

  Future likeUnlikeBusinessPost() async {
     openLoadingDialog(context, 'loading');
     try{
       var response = await DioService.post('like_unlike_business_post' , {
      "businessId": widget.business!.businessId,
      "usersId": AppData().userdetail!.users_id
     });
       widget.business!.liked = response['data'];
       widget.business!.totalLikes = response['like_count'];
       setState(() {});
       Navigator.of(context).pop();
     //  showSuccessToast(response['data']);
     }
     catch(e){
      Navigator.of(context).pop();
      showSuccessToast(e.toString());
    }
}

  Future sendMessage() async {
    if(mentionName.text.isEmpty) return showErrorToast("Please Write Some Comment");
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
        response   = await  DioService.post("comment_on_business", {
          "businessId": widget.business!.businessId,
          "usersId": AppData().userdetail!.users_id,
          "comment": comment,
          if(selectedId!=null)
           "mentionedUserId": selectedId,
          "commentType":isReply ? "reply" : "comment",
          if(isReply)
          "replyingToCommentId": businessCommentId
        });
        FocusManager.instance.primaryFocus!.unfocus();
        if(!isReply)
        widget.business!.totalPostComments = (int.parse(widget.business!.totalPostComments!) + 1).toString();
        if(isReply){
          isReply=false;
        }
        mentionName.clear();
      }
      catch(e){
        showErrorToast(e.toString());
      }
    await  getAllBusinessComments();
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
      getAllBusinessComments();
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
            BusinessSliderPage(business: widget.business,images: widget.images),
            Expanded(
              child: Stack(
                children: [
                  BusinessActionBar(
                    event: widget.business,
                    child: Column(
                    children: [
                    Expanded(
                    child: Container(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: padding),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    child: Row(
                                      children: [
                                        SvgPicture.asset('assets/icons/comments.svg', color: globalGolden, width: 18, height: 16,),
                                        SizedBox(width: padding / 2),
                                        Text(widget.business!.totalPostComments.toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.5),),
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: ()async {
                                      likeUnlikeBusinessPost();
                                    },
                                    child: Row(
                                      children: [
                                         widget.business!.liked  ? SvgPicture.asset('assets/icons/heart.svg', width: 18):SvgPicture.asset('assets/icons/whiteheart.svg', width: 18),
                                        SizedBox(width: padding / 2,),
                                        Text('${widget.business!.totalLikes} Likes', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.5),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(widget.business!.timeAgo.toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: businessComments.length,
                        itemBuilder: (context,index){
                        BusinessComments commentData=businessComments[index];
                        replyToCommentId=commentData.businessCommentId;
                        return Column(
                          children: [
                            // Padding(
                            //   padding:  EdgeInsets.symmetric(horizontal: padding),
                            //   child: Divider(color: globalLGray),
                            // ),
                            Padding(
                                padding: const EdgeInsets.only(left: padding,right: padding,top:8,bottom: 8.0),
                                child: Container(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap:(){
                                          if(commentData.usersId!=AppData().userdetail!.users_id)
                                            CustomNavigator.navigateTo(context, MessageDetailsPage(
                                              otherUserChatId: commentData.usersId,
                                              userName: commentData.commentUserName!,
                                              profilePic:commentData.commentUserProfile! ,
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
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(commentData.commentUserName!, style: TextStyle(color: globalBlack, fontSize: 18, fontWeight: FontWeight.w600)),
                                                GestureDetector(
                                                  onTap: () {
                                                    showCommentsOptionsForOtherUsersComments(context,commentData,widget.business!.usersId , () async{
                                                      openLoadingDialog(context, 'deleting');
                                                      var response= await DioService.post('delete_comment_business', {
                                                        "businessCommentId": commentData.businessCommentId,
                                                        "usersId": AppData().userdetail!.users_id
                                                      });
                                                      await getAllBusinessComments();
                                                      Navigator.of(context).pop();
                                                      print(response);
                                                    },
                                                      commentData.commentUserName!
                                                    );
                                                  },
                                                  child: Icon(Icons.more_horiz),
                                                ),
                                              ],
                                            ),
                                            Wrap(
                                              children: [
                                                Text(commentData.mentionedUserName, style: TextStyle(color: Colors.blue , fontSize: 14)),
                                                Padding(
                                                  padding: const EdgeInsets.only(left:4.0),
                                                  child: Text(commentData.comment!, style: TextStyle(color: globalBlack, fontSize: 14)),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top:8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  InkWell(
                                                    onTap: () async{
                                                      if(commentData.commentLiked=='true') {
                                                        await   unLikeBusinessComment(commentData.businessId!,commentData.businessCommentId!);
                                                        await  getAllBusinessComments();
                                                      }
                                                      else  {
                                                        await    likeBusinessComment(commentData.businessId!,commentData.businessCommentId!);
                                                        await  getAllBusinessComments();
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
                                                    onTap: () async{
                                                      businessCommentId =commentData.businessCommentId;
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
                                  ),
                                )),
                            BusinessReplyPage(comment:commentData ,business:widget.business,commentReplies: commentData.comment_replies)
                            //  EventCommentReplyList(event: widget.event,commentData:commentData)
                          ],
                        );
                                })
                                  ],
                                ),
                              ),
                            ),
                          ),

                              ],
                            ),
                  ),
                  if(isShown)
                  CommentsMentionUsers(
                    selectedMentionName: (val,mentionNameSelected,mentionedUserId){
                      mentionName=val;
                      this.mentionNameSelected=mentionNameSelected;
                      this.selectedId=mentionedUserId;
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
                  controller: mentionName,
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
