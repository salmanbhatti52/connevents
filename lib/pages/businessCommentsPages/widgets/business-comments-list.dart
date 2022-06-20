import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/business-comment-model.dart';
import 'package:connevents/pages/businessReplyPage/business-reply-page.dart';
import 'package:connevents/pages/messageDetails/messageDetailsPage.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:connevents/widgets/profile-image-picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../business-Comment-Page-Functions.dart';
import 'package:connevents/models/business-create-model.dart';


class BusinessCommentListPage extends StatefulWidget {

  final Business? business;
   List<BusinessComments> businessComments;
   BusinessCommentListPage({Key? key,this.business,this.businessComments=const []}) : super(key: key);

  @override
  _BusinessCommentListPageState createState() => _BusinessCommentListPageState();
}

class _BusinessCommentListPageState extends State<BusinessCommentListPage> {


   int? replyToCommentId;
   int? selectedComment;

    var isCommentVisible = false;


   Future getAllBusinessComments() async {
    try{
       var response = await DioService.post('get_all_comments_business', {
      "businessId": widget.business!.businessId,
      "usersId": AppData().userdetail!.users_id
    });
       var commentsList = response['comments'] as List;
       widget.businessComments = commentsList.map<BusinessComments>((e) => BusinessComments.fromJson(e)).toList();
        setState(() {});
       Navigator.of(context).pop();
    }
    catch(e){
      print("shahzaib");
      Navigator.of(context).pop();
    }
  }

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



  @override
  Widget build(BuildContext context) {
    return ListView.builder(
           physics: NeverScrollableScrollPhysics(),
           shrinkWrap: true,
             itemCount: widget.businessComments.length,
             itemBuilder: (context,index){
             BusinessComments commentData=widget.businessComments[index];
             replyToCommentId=commentData.businessCommentId;
               return Column(
                 children: [
                   Padding(
                     padding:  EdgeInsets.symmetric(horizontal: padding),
                     child: Divider(color: globalLGray),
                   ),
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: padding),
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
                                   Padding(
                                     padding: const EdgeInsets.only(left:4.0),
                                     child: Text(commentData.comment!, style: TextStyle(color: globalBlack, fontSize: 14)),
                                   ),
                                 ],
                               ),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   TextButton(
                                     onPressed: () async{
                                       print(commentData.commentLiked);

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
                                   TextButton(
                                     onPressed: () async{
                                  var count =     await   CustomNavigator.navigateTo(context, BusinessReplyPage(
                                         business: widget.business,
                                         comment: commentData,
                                       ));
                                      commentData.totalRepliesCount=count;
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

                                   TextButton(
                                     onPressed: () {},
                                     child: Text(commentData.commentTimeAgo!, style: TextStyle(color: globalBlack.withOpacity(0.7), fontSize: 10,),
                                     ),
                                   ),
                                 ],
                               ),
                             ],
                           ),
                         ),
                                 ],
                               ),
                             )),
                          //  EventCommentReplyList(event: widget.event,commentData:commentData)
                         ],
                       );
                     });
  }
}
