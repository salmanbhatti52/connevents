// import 'package:connevents/mixins/data.dart';
// import 'package:connevents/models/business-comment-model.dart';
// import 'package:connevents/models/mention-model.dart';
// import 'package:connevents/pages/businessCommentsPages/business-Comment-Page-Functions.dart';
// import 'package:connevents/pages/emojisPicker/emojis-picker.dart';
// import 'package:connevents/pages/eventReplyPage/widget/event-reply-mention-list.dart';
// import 'package:connevents/pages/messageDetails/messageDetailsPage.dart';
// import 'package:connevents/services/dio-service.dart';
// import 'package:connevents/utils/loading-dialog.dart';
// import 'package:connevents/variables/globalVariables.dart';
// import 'package:connevents/widgets/comment-textfield.dart';
// import 'package:connevents/widgets/custom-navigator.dart';
// import 'package:connevents/widgets/profile-image-picker.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:connevents/models/business-create-model.dart';
//
//
//
// class BusinessReplyPage extends StatefulWidget {
//   final  BusinessComments? comment;
//   List<BusinessCommentReplies> commentReplies;
//   final Business? business;
//   const BusinessReplyPage({Key? key,this.business,this.comment}) : super(key: key);
//
//   @override
//   _BusinessReplyPageState createState() => _BusinessReplyPageState();
// }
//
// class _BusinessReplyPageState extends State<BusinessReplyPage> {
//
//   bool isFocus=false;
//   int currentSlide = 0;
//   var isCommentVisible = false;
//   var isMoreCommentVisible = false;
//   var text;
//   String? isLiked;
//   int? likeCount;
//   int? selectedId;
//   bool isEmojiShown=false;
//
//   int? replyToCommentId;
//   String? comment;
//   List<BusinessCommentReplies> commentReplies=[];
//   List<MentionCommentUserList> mentionCommentList=[];
//   int? selectedComment;
//   late FocusNode myFocusNode;
//   TextEditingController mentionName=TextEditingController();
//   bool isReply=false;
//   bool isShown=false;
//   String mentionNameSelected="";
//
//    Future likeReply(int businessId,int businessCommentId) async {
//     openLoadingDialog(context, 'loading');
//     try{
//         await DioService.post('like_comment_business', {
//         "businessCommentId": businessCommentId,
//         "businessId": businessId,
//         "usersId": AppData().userdetail!.users_id
//       });
//      // Navigator.of(context).pop();
//     }
//     catch(e){
//       Navigator.of(context).pop();
//       showSuccessToast(e.toString());
//     }
//   }
//
//    Future unLikeReply(int businessId,int businessCommentId) async {
//     openLoadingDialog(context, 'loading');
//     try{
//          await DioService.post('unlike_comment_business', {
//         "businessId": businessId,
//         "businessCommentId": businessCommentId,
//         "usersId": AppData().userdetail!.users_id
//       });
//      // Navigator.of(context).pop();
//
//     }
//     catch(e){
//       Navigator.of(context).pop();
//       showSuccessToast(e.toString());
//     }
//   }
//
//
//   Future getMentionComment() async {
//     // openLoadingDialog(context, 'loading');
//     try{
//       var response = await DioService.post('get_comment_mentions_business', {
//         "businessId": widget.business!.businessId,
//         "usersId": AppData().userdetail!.users_id
//       });
//       print(response);
//       // Navigator.of(context).pop();
//       if(response['status']=="success"){
//         var data =response['data'] as List;
//         mentionCommentList=   data.map<MentionCommentUserList>((e) => MentionCommentUserList.fromJson(e)).toList();
//         isShown=true;
//         setState(() {});
//       }
//       else if(response['status']=="error"){
//         print(response['status']);
//       }
//     }
//     catch(e){
//       // Navigator.of(context).pop();
//          print(e.toString());
//       // showSuccessToast(e.toString());
//     }
//   }
//
//   Future getAllCommentsReplies() async {
//     try{
//       var response = await DioService.post('get_comment_replies_business', {
//         "businessId": widget.business!.businessId,
//         "usersId": AppData().userdetail!.users_id,
//         "businessCommentId":widget.comment!.businessCommentId
//       });
//       print(response);
//       widget.comment!.totalRepliesCount = response['total_comment_replies'];
//       var commentsList = response['comments'] as List;
//       commentReplies = commentsList.map<BusinessCommentReplies>((e) => BusinessCommentReplies.fromJson(e)).toList();
//       setState(() {});
//       Navigator.of(context).pop();
//     }
//     catch(e){
//       print("shahzaib");
//       Navigator.of(context).pop();
//     }
//   }
//
//   Future sendMessage() async {
//     if(mentionName.text.isEmpty) return showErrorToast("Please Write Some Comment");
//       print(widget.business!.businessId);
//       List list=   mentionName.text.split(' ');
//       print(list);
//       if(list.contains(mentionNameSelected))
//         list.remove(mentionNameSelected);
//       comment = list.join(" ");
//       openLoadingDialog(context, 'sending');
//       var response;
//         try{
//           response   = await  DioService.post("comment_on_business", {
//             "businessId": widget.business!.businessId,
//             "usersId": AppData().userdetail!.users_id,
//             "comment": comment,
//             if(selectedId!=null)
//             "mentionedUserId": selectedId,
//             "commentType": "reply",
//             "replyingToCommentId": widget.comment!.businessCommentId
//           });
//           FocusManager.instance.primaryFocus!.unfocus();
//           mentionName.clear();
//           setState(() {});
//           print(response);
//         }
//         catch(e){
//           showErrorToast(e.toString());
//         }
//       await  getAllCommentsReplies();
//       print(response);
//   }
//
//
//   @override
//   void initState() {
//     super.initState();
//     SystemChrome.setSystemUIOverlayStyle(
//       SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
//     );
//       WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
//       openLoadingDialog(context, "loading...");
//       getAllCommentsReplies();
//     });
//
//     myFocusNode = FocusNode();
//   }
//
//
//
//   @override
//   void dispose() {
//     myFocusNode.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print(widget.comment!.toJson());
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         automaticallyImplyLeading: false,
//         elevation: 0,
//         title: Row(
//           children: [
//             TextButton(
//               onPressed: () =>  Navigator.of(context).pop(widget.comment!.totalRepliesCount) ,
//               child: Row(
//                 children: [
//                   Icon(Icons.chevron_left),
//                   Text('Back'),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: Container(
//         child: Column(
//           children: [
//             Expanded(
//               child: Stack(
//                 children: [
//                   Column(
//                     children: [
//                     Expanded(
//                     child: Container(
//                     child: SingleChildScrollView(
//                       physics: BouncingScrollPhysics(),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(vertical: padding,),
//                         child: Column(
//                           children: [
//                           Column(
//                           children: [
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: padding),
//                             child: Container(
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   InkWell(
//                                     onTap:(){
//                                       if(widget.comment!.usersId!=AppData().userdetail!.users_id)
//                                         CustomNavigator.navigateTo(context, MessageDetailsPage(
//                                           otherUserChatId: widget.comment!.usersId,
//                                         ));
//                                     },
//                                     child: SizedBox(
//                                       width: 50,
//                                       height: 50,
//                                       child: ProfileImagePicker(
//                                         onImagePicked: (value){},
//                                         previousImage: widget.comment?.commentUserProfile,
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(width: padding),
//                                   Expanded(
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Row(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Text(widget.comment!.commentUserName!, style: TextStyle(color: globalBlack, fontSize: 18, fontWeight: FontWeight.w600)),
//                                           ],
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.only(left:4.0),
//                                           child: Text(widget.comment!.comment!, style: TextStyle(color: globalBlack, fontSize: 14)),
//                                         ),
//                                         Row(
//                                           mainAxisAlignment: MainAxisAlignment.end,
//                                           children: [
//                                             Row(
//                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                               children: [
//                                                 SvgPicture.asset('assets/icons/share.svg', color: globalGolden, width: 10,),
//                                                 Text('${widget.comment!.totalRepliesCount} Replies', style: TextStyle(color: globalBlack.withOpacity(0.7), fontSize: 10,),),
//                                               ],
//                                             ),
//                                             TextButton(
//                                               onPressed: () {},
//                                               child: Text(widget.comment!.commentTimeAgo!, style: TextStyle(color: globalBlack.withOpacity(0.7), fontSize: 10,),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           ListView.builder(
//                             physics: NeverScrollableScrollPhysics(),
//                             shrinkWrap: true,
//                             itemCount:  commentReplies.length,
//                             itemBuilder: (context,index){
//                               BusinessCommentReplies commentReply  = commentReplies[index];
//                               print(commentReply.toJson());
//                               return  Column(
//                                 children: [
//                                   Container(
//                                     decoration: BoxDecoration(color: globallightbg,),
//                                     padding: EdgeInsets.only(left: 56 + padding + padding, right: padding, top: padding, bottom: padding,),
//                                     child: Row(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         SizedBox(
//                                           width: 50,
//                                           height: 50,
//                                           child: ProfileImagePicker(
//                                             onImagePicked: (value){},
//                                             previousImage: commentReply.replyUserProfile,
//                                           ),
//                                         ),
//                                         SizedBox(width: padding),
//                                         Expanded(
//                                           child: Column(crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                               Row(
//                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                 children: [
//                                                   Text(commentReply.replyUserName!, style: TextStyle(color: globalBlack, fontSize: 18, fontWeight: FontWeight.w600,),),
//                                                   GestureDetector(
//                                                     onTap: () => showCommentsOptionsForMyComments(context,commentReply,widget.business!.usersId , () async{
//                                                       openLoadingDialog(context, 'deleting');
//                                                          await DioService.post('delete_comment_business', {
//                                                         "businessCommentId": commentReply.businessCommentId,
//                                                         "usersId": AppData().userdetail!.users_id
//                                                       });
//                                                        commentReplies.removeAt(index);
//                                                        await getAllCommentsReplies();
//                                                         setState(() {});
//                                                       Navigator.of(context).pop();
//                                                     }),
//                                                     child: Icon(Icons.more_horiz,size: 25),
//                                                   ),
//                                                 ],
//                                               ),
//                                               Wrap(
//                                                 children: [
//                                                   Text(commentReply.mentionedUserName, style: TextStyle(color: Colors.blue, fontSize: 14)),
//                                                   Padding(
//                                                     padding: const EdgeInsets.only(left:2.0),
//                                                     child: Text(commentReply.comment!, style: TextStyle(color: globalBlack, fontSize: 14)),
//                                                   ),
//                                                 ],
//                                               ),
//                                               Padding(
//                                                 padding: const EdgeInsets.symmetric(vertical: padding / 2),
//                                                 child: Row(
//                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                   children: [
//                                                     InkWell(
//                                                       onTap:()async{
//                                                         if(commentReply.replyLiked=='true') {
//                                                           await   unLikeReply(commentReply.businessId!,commentReply.businessCommentId!);
//                                                           await    getAllCommentsReplies();
//                                                         }
//                                                         else  {
//                                                           await    likeReply(commentReply.businessId!,commentReply.businessCommentId!);
//                                                            await  getAllCommentsReplies();
//                                                            setState(() {});
//                                                         }
//                                                       },
//                                                       child: Row(
//                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                         children: [
//                                                           commentReply.replyLiked=='true'  ? SvgPicture.asset('assets/icons/heart.svg', width: 12):SvgPicture.asset('assets/icons/whiteheart.svg', width: 12),
//                                                           Text('${commentReply.totalLikes} Likes', style: TextStyle(color: globalBlack.withOpacity(0.7), fontSize: 8,),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                     Text(commentReply.replyTimeAgo!, style: TextStyle(color: globalBlack.withOpacity(0.7), fontSize: 10,
//                                                     ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               );
//                             }
//                         )
//           ],
//                       )
//                       ],
//                     ),
//                     ),
//                   ),
//               ),
//                           ),
//
//                         ],
//                       ),
//                   if(isShown)
//                   EventReplyMentionList(
//                     selectedMentionName: (val){
//                       mentionName=val;
//                       setState(() {});
//                     },
//                     isShown: (val){
//                       isShown=val;
//                       setState(() {});
//                     },
//                     mentionCommentList: mentionCommentList,
//                   ),
//                 ],
//               ),
//             ),
//             EventCommentTextField(
//               controller: mentionName,
//              // autoFocus: true,
//               onTapEmoji: (){
//               FocusScopeNode currentFocus = FocusScope.of(context);
//                if (!currentFocus.hasPrimaryFocus) {
//                 currentFocus.unfocus();
//               }
//                 isEmojiShown=!isEmojiShown;
//                 setState(() {});
//               },
//               onTap: (){
//                 FocusScopeNode currentFocus = FocusScope.of(context);
//                if (!currentFocus.hasPrimaryFocus) {
//                  currentFocus.unfocus();
//               }
//                if(isEmojiShown)
//                 isEmojiShown=false;
//                 setState(() {});
//               },
//               onChanged: (value) => setState(() {
//                 if(value=="@") getMentionComment();
//                 else isShown=false;
//                 comment=value;}),
//               focusNode: myFocusNode,
//               onTapIcon: () => sendMessage(),
//             ),
//              if(isEmojiShown)
//                 EmojisPickerPage(
//                   emoji: (val){
//                     mentionName.text = mentionName.text + val  ;
//                     setState(() {});
//                   },
//                 ),
//
//           ],
//         ),
//       ),
//     );
//   }
// }
