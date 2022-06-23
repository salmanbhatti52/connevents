import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/comments-model.dart';
import 'package:connevents/pages/eventComments/eventCommentsPageFunctions.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/profile-image-picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../business-Comment-Page-Functions.dart';
import 'package:connevents/models/business-create-model.dart';


class BusinessCommentReplyList extends StatefulWidget {
   final Business? business;
   final Comments? commentData;
  const BusinessCommentReplyList({Key? key,this.business,this.commentData}) : super(key: key);

  @override
  _BusinessCommentReplyListState createState() => _BusinessCommentReplyListState();
}

class _BusinessCommentReplyListState extends State<BusinessCommentReplyList> {

   List<Comments> comments=[];
   int? replyToCommentId;
   int? selectedComment;
    var isCommentVisible = false;


   Future getAllComments() async {
      try{
         var response = await DioService.post('get_all_comments', {
        "businessId": widget.business!.businessId,
        "usersId": AppData().userdetail!.users_id
      });
         var commentsList = response['comments'] as List;
          comments = commentsList.map<Comments>((e) => Comments.fromJson(e)).toList();
          setState(() {});
         Navigator.of(context).pop();
      }
      catch(e){
        print("shahzaib");
        Navigator.of(context).pop();
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
      showSuccessToast(response['data']);
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
      showSuccessToast(response['data']);
    }
    catch(e){
      Navigator.of(context).pop();
      showSuccessToast(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Visibility(
           visible: isCommentVisible,
           child: Column(
             children: [
               ListView.builder(
                 physics: NeverScrollableScrollPhysics(),
                 shrinkWrap: true,
                 itemCount: widget.commentData!.comment_replies!.length,
                  itemBuilder: (context,index){
                  CommentReplies commentReply  = widget.commentData!.comment_replies![index];
                    return selectedComment==commentReply.replyingToCommentId ?  Column(
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
                                          onTap: () => showCommentsOptionsForMyComments(context,commentReply,widget.business!.usersId , () async{
                                            openLoadingDialog(context, 'deleting');
                                            var response= await DioService.post('delete_comment', {
                                              "eventCommentId": commentReply.eventCommentId,
                                              "usersId": AppData().userdetail!.users_id
                                            });
                                            await getAllComments();
                                            Navigator.of(context).pop();
                                          }),
                                          child: Icon(Icons.more_horiz,size: 25),
                                        ),
                                      ],
                                    ),
                                    Text(commentReply.comment!, style: TextStyle(color: globalBlack, fontSize: 14,),),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: padding / 2),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap:()async{
                                              if(commentReply.replyLiked=='true') {
                                                await   unLikeReply(commentReply.eventPostId!,commentReply.eventCommentId!);
                                                // openLoadingDialog(context, "loading");
                                                await  getAllComments();
                                              }
                                              else  {
                                                await    likeReply(commentReply.eventPostId!,commentReply.eventCommentId!);
                                                await  getAllComments();

                                                // openLoadingDialog(context, "loading");
                                                //  await   getEvents(isReFresh: true);

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
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Icon(Icons.share, size: 12, color: globalGolden,),
                                              Text(' ${commentReply.totalShares} Shares', style: TextStyle(color: globalBlack.withOpacity(0.7), fontSize: 8,),),
                                            ],
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
                    ) :SizedBox();
               }
               ),
             ],
           ) );
  }
}
