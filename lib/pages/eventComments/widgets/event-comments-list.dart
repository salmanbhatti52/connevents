import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/comments-model.dart';
import 'package:connevents/models/create-event-model.dart';
import 'package:connevents/pages/eventReplyPage/eventReplyPage.dart';
import 'package:connevents/pages/messageDetails/messageDetailsPage.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:connevents/widgets/profile-image-picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../eventCommentsPageFunctions.dart';

class EventCommentListPage extends StatefulWidget {
  Function? onPressed;

  final EventDetail? event;
   List<Comments> comments;

   EventCommentListPage({Key? key,this.onPressed,this.event,this.comments=const []}) : super(key: key);

  @override
  _EventCommentListPageState createState() => _EventCommentListPageState();
}

class _EventCommentListPageState extends State<EventCommentListPage> {


   int? replyToCommentId;
   int? selectedComment;
    var isCommentVisible = false;

    Future getAllComments() async {
      try{
         var response = await DioService.post('get_all_comments', {
        "eventPostId": widget.event!.eventPostId,
        "usersId": AppData().userdetail!.users_id
      });
       var commentsList = response['comments'] as List;
        widget.comments = commentsList.map<Comments>((e) => Comments.fromJson(e)).toList();
        setState(() {});
       Navigator.of(context).pop();
    }
    catch(e){
      print("shahzaib");
      Navigator.of(context).pop();
    }
    }

    Future likeComment(int eventPostId,int eventCommentId) async {
      openLoadingDialog(context, 'loading');
      try{
          await DioService.post('like_comment', {
          "eventCommentId": eventCommentId,
          "eventPostId": eventPostId,
          "usersId": AppData().userdetail!.users_id
        });
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

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
           physics: NeverScrollableScrollPhysics(),
           shrinkWrap: true,
             itemCount: widget.comments.length,
             itemBuilder: (context,index){
             Comments commentData=widget.comments[index];
             replyToCommentId=commentData.eventCommentId;
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
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   TextButton(
                                     onPressed: () async{
                                       if(commentData.commentLiked=='true') {
                                         await   unLikeComment(commentData.eventPostId!,commentData.eventCommentId!);
                                         // openLoadingDialog(context, "loading");
                                           await  getAllComments();
                                       }
                                       else  {
                                         await    likeComment(commentData.eventPostId!,commentData.eventCommentId!);
                                         await    getAllComments();

                                         // openLoadingDialog(context, "loading");
                                         //  await   getEvents(isReFresh: true);

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
                                     onPressed: () async {

                                     var count  =  await CustomNavigator.navigateTo(context, EventReplyPage(
                                         event: widget.event,
                                         comment: commentData,
                                       ));
                                  if(count!=null)
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
