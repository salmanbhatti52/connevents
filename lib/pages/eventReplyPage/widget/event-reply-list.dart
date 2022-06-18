// import 'package:connevents/mixins/data.dart';
// import 'package:connevents/models/comments-model.dart';
// import 'package:connevents/models/create-event-model.dart';
// import 'package:connevents/pages/eventComments/eventCommentsPageFunctions.dart';
// import 'package:connevents/services/dio-service.dart';
// import 'package:connevents/utils/loading-dialog.dart';
// import 'package:connevents/variables/globalVariables.dart';
// import 'package:connevents/widgets/profile-image-picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
//
// class EventReplyListPage extends StatefulWidget {
//    final  Comments? comment;
//    Function(int totalRepliesCount) totalRepliesCount;
//    final EventDetail? event;
//    EventReplyListPage({Key? key,required this.totalRepliesCount,this.event,this.comment}) : super(key: key);
//
//   @override
//   _EventReplyListPageState createState() => _EventReplyListPageState();
// }
//
// class _EventReplyListPageState extends State<EventReplyListPage> {
//
//
//   List<CommentReplies> commentReplies=[];
//
//
//
//   Future getAllCommentsReplies() async {
//     try{
//       var response = await DioService.post('get_comment_replies', {
//         "eventPostId": widget.event!.eventPostId,
//         "usersId": AppData().userdetail!.users_id,
//         "eventCommentId":widget.comment!.eventCommentId
//       });
//       print(response);
//       widget.totalRepliesCount(response['total_comment_replies']);
//       var commentsList = response['comments'] as List;
//       commentReplies = commentsList.map<CommentReplies>((e) => CommentReplies.fromJson(e)).toList();
//       print("list of comments Replies");
//       print(commentReplies.first.toJson());
//       print("list of comments Replies");
//       setState(() {});
//       Navigator.of(context).pop();
//     }
//     catch(e){
//       print("shahzaib");
//       Navigator.of(context).pop();
//     }
//   }
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         physics: NeverScrollableScrollPhysics(),
//         shrinkWrap: true,
//         itemCount: commentReplies.length,
//         itemBuilder: (context,index){
//           CommentReplies commentReply  = commentReplies[index];
//           print(commentReply.replyLiked);
//           return  Column(
//             children: [
//               Container(
//                 decoration: BoxDecoration(color: globallightbg,),
//                 padding: EdgeInsets.only(left: 56 + padding + padding, right: padding, top: padding, bottom: padding,),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       width: 50,
//                       height: 50,
//                       child: ProfileImagePicker(
//                         onImagePicked: (value){},
//                         previousImage: commentReply.replyUserProfile,
//                       ),
//                     ),
//                     SizedBox(width: padding),
//                     Expanded(
//                       child: Column(crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(commentReply.replyUserName!, style: TextStyle(color: globalBlack, fontSize: 18, fontWeight: FontWeight.w600,),),
//                               GestureDetector(
//                                 onTap: () => showCommentsOptionsForMyComments(context,commentReply,widget.event!.usersId , () async{
//                                   openLoadingDialog(context, 'deleting');
//                                   var response= await DioService.post('delete_comment', {
//                                     "eventCommentId": commentReply.eventCommentId,
//                                     "usersId": AppData().userdetail!.users_id
//                                   });
//                                   commentReplies.removeAt(index);
//                                   await  getAllCommentsReplies();
//                                   setState(() {});
//                                   Navigator.of(context).pop();
//                                 }),
//                                 child: Icon(Icons.more_horiz,size: 25),
//                               ),
//                             ],
//                           ),
//                           Wrap(
//                             children: [
//                               Text(commentReply.mentionedUserName, style: TextStyle(color: Colors.blue, fontSize: 14)),
//                               Padding(
//                                 padding: const EdgeInsets.only(left:2.0),
//                                 child: Text(commentReply.comment!, style: TextStyle(color: globalBlack, fontSize: 14)),
//                               ),
//                             ],
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(vertical: padding / 2),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 InkWell(
//                                   onTap:()async{
//                                     if(commentReply.replyLiked=='true') {
//                                       await   unLikeReply(commentReply.eventPostId!,commentReply.eventCommentId!);
//
//                                     }
//                                     else  {
//                                       await    likeReply(commentReply.eventPostId!,commentReply.eventCommentId!);
//                                     }
//                                   },
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       commentReply.replyLiked=='true'  ? SvgPicture.asset('assets/icons/heart.svg', width: 12):SvgPicture.asset('assets/icons/whiteheart.svg', width: 12),
//                                       Text(' ${commentReply.totalLikes} Likes', style: TextStyle(color: globalBlack.withOpacity(0.7), fontSize: 8,),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Text(commentReply.replyTimeAgo!, style: TextStyle(color: globalBlack.withOpacity(0.7), fontSize: 10,
//                                 ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         }
//     );
//   }
// }
