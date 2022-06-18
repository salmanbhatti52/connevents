import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/business-comment-model.dart';
import 'package:connevents/models/business-create-model.dart';
import 'package:connevents/pages/businessCommentsPages/business-Comment-Page-Functions.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/profile-image-picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BusinessReplyPage extends StatefulWidget {
  final  BusinessComments? comment;
  List<BusinessCommentReplies>? commentReplies;
  final Business? business;
   BusinessReplyPage({Key? key,this.commentReplies,this.comment,this.business}) : super(key: key);

  @override
  _BusinessReplyPageState createState() => _BusinessReplyPageState();
}

class _BusinessReplyPageState extends State<BusinessReplyPage> {

  bool viewReply=false;


  Future likeReply(int businessId,int businessCommentId) async {
    openLoadingDialog(context, 'loading');
    try{
      await DioService.post('like_comment_business', {
        "businessCommentId": businessCommentId,
        "businessId": businessId,
        "usersId": AppData().userdetail!.users_id
      });
      // Navigator.of(context).pop();
    }
    catch(e){
      Navigator.of(context).pop();
      showSuccessToast(e.toString());
    }
  }

  Future unLikeReply(int businessId,int businessCommentId) async {
    openLoadingDialog(context, 'loading');
    try{
      await DioService.post('unlike_comment_business', {
        "businessId": businessId,
        "businessCommentId": businessCommentId,
        "usersId": AppData().userdetail!.users_id
      });
      // Navigator.of(context).pop();

    }
    catch(e){
      Navigator.of(context).pop();
      showSuccessToast(e.toString());
    }
  }

  Future getAllCommentsReplies() async {
    try{
      var response = await DioService.post('get_comment_replies_business', {
        "businessId": widget.business!.businessId,
        "usersId": AppData().userdetail!.users_id,
        "businessCommentId":widget.comment!.businessCommentId
      });
      print(response);
      widget.comment!.totalRepliesCount = response['total_comment_replies'];
      var commentsList = response['comments'] as List;
      widget.commentReplies = commentsList.map<BusinessCommentReplies>((e) => BusinessCommentReplies.fromJson(e)).toList();
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
    return widget.commentReplies!.isNotEmpty && !viewReply ?
    ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: 1,
        itemBuilder: (context,index){
          BusinessCommentReplies commentReply  = widget.commentReplies![index];
          print(commentReply.toJson());
          return  Column(
            children: [
              Container(
                decoration: BoxDecoration(color: globallightbg,),
                padding: EdgeInsets.only(left: 56 + padding + padding, right: padding, top: 8, bottom: 8),
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
                                  await DioService.post('delete_comment_business', {
                                    "businessCommentId": commentReply.businessCommentId,
                                    "usersId": AppData().userdetail!.users_id
                                  });
                                  widget.commentReplies!.removeAt(index);
                                  await getAllCommentsReplies();
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
                            padding: const EdgeInsets.only(top: padding / 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap:()async{
                                    if(commentReply.replyLiked=='true') {
                                      await   unLikeReply(commentReply.businessId!,commentReply.businessCommentId!);
                                      await    getAllCommentsReplies();
                                    }
                                    else  {
                                      await    likeReply(commentReply.businessId!,commentReply.businessCommentId!);
                                      await  getAllCommentsReplies();
                                      setState(() {});
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      commentReply.replyLiked=='true'  ? SvgPicture.asset('assets/icons/heart.svg', width: 12):SvgPicture.asset('assets/icons/whiteheart.svg', width: 12),
                                      Padding(
                                        padding: const EdgeInsets.only(left:2.0),
                                        child: Text('${commentReply.totalLikes} Likes', style: TextStyle(color: globalBlack.withOpacity(0.7), fontSize: 8,),
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
    ):
    ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: widget.commentReplies!.length,
        itemBuilder: (context,index){
          BusinessCommentReplies commentReply  = widget.commentReplies![index];
          print(commentReply.toJson());
          return  Column(
            children: [
              Container(
                decoration: BoxDecoration(color: globallightbg,),
                padding: EdgeInsets.only(left: 56 + padding + padding, right: padding,  top: 10, bottom: padding,),
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
                                  await DioService.post('delete_comment_business', {
                                    "businessCommentId": commentReply.businessCommentId,
                                    "usersId": AppData().userdetail!.users_id
                                  });
                                  widget.commentReplies!.removeAt(index);
                                  await getAllCommentsReplies();
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
                            padding: const EdgeInsets.only(top: padding / 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap:()async{
                                    if(commentReply.replyLiked=='true') {
                                      await   unLikeReply(commentReply.businessId!,commentReply.businessCommentId!);
                                      await    getAllCommentsReplies();
                                    }
                                    else  {
                                      await    likeReply(commentReply.businessId!,commentReply.businessCommentId!);
                                      await  getAllCommentsReplies();
                                      setState(() {});
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      commentReply.replyLiked=='true'  ? SvgPicture.asset('assets/icons/heart.svg', width: 12):SvgPicture.asset('assets/icons/whiteheart.svg', width: 12),
                                      Padding(
                                        padding: const EdgeInsets.only(left:2.0),
                                        child: Text('${commentReply.totalLikes} Likes', style: TextStyle(color: globalBlack.withOpacity(0.7), fontSize: 8,),
                                        ),
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
