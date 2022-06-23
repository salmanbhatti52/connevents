import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/peek-model.dart';
import 'package:connevents/pages/eventPeeks/report-peeks.dart';
import 'package:connevents/pages/messageDetails/messageDetailsPage.dart';
import 'package:connevents/pages/reportComment/reportCommentPage.dart';
import 'package:connevents/pages/reportComment/reportReplyPage.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showCommentsOptionsForOtherUsersComments(context,comment,eventUserId, void Function() onTap,userName) {

  final action =
  CupertinoActionSheet(
    actions: <Widget>[
      if(AppData().userdetail!.users_id!=comment.usersId)
        CupertinoActionSheetAction(
        child: Text("Send Message", style: TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.w500,)),
        isDefaultAction: true,
        onPressed: () {
           if(comment.usersId!=AppData().userdetail!.users_id)
             CustomNavigator.navigateTo(context, MessageDetailsPage(
                    userName: userName,
                     otherUserChatId: comment.usersId,
                     profilePic: comment.commentUserProfile!,
             ));
        },
      ),
      if(AppData().userdetail!.users_id == eventUserId && AppData().userdetail!.users_id !=comment.usersId)   CupertinoActionSheetAction(
        child: Text("Delete Comment", style: TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.w500)),
        isDefaultAction: true,
        onPressed: onTap,
      ),if((AppData().userdetail!.users_id ==comment.usersId)) CupertinoActionSheetAction(
        child: Text("Delete Comment",
          style: TextStyle(
            color: Colors.blue,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        isDefaultAction: true,
        onPressed: onTap
      ),

      if(AppData().userdetail!.users_id!=comment.usersId)    CupertinoActionSheetAction(
        child: Text("Report Comment",
          style: TextStyle(color: Colors.blue,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        isDefaultAction: true,
        onPressed: () {
          CustomNavigator.navigateTo(context, ReportCommentPage(comment: comment));
        },
      ),
    ],
  );
  showCupertinoModalPopup(context: context, builder: (context) => action);
}

showCommentsOptionsForMyComments(context,comment,eventUserId, void Function() onTap) {
  final action = CupertinoActionSheet(
    actions: <Widget>[
      if(AppData().userdetail!.users_id!=comment.usersId)    CupertinoActionSheetAction(
        child: Text("Send Message", style: TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.w500,)),
        isDefaultAction: true,
        onPressed: () {},
      ),
      if(AppData().userdetail!.users_id == eventUserId && AppData().userdetail!.users_id !=comment.usersId)   CupertinoActionSheetAction(
        child: Text("Delete Comment", style: TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.w500)),
        isDefaultAction: true,
        onPressed: onTap,
      ),if((AppData().userdetail!.users_id ==comment.usersId)) CupertinoActionSheetAction(
          child: Text("Delete Comment",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          isDefaultAction: true,
          onPressed: onTap
      ),

      if(AppData().userdetail!.users_id!=comment.usersId)    CupertinoActionSheetAction(
        child: Text("Report Comment",
          style: TextStyle(color: Colors.blue,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        isDefaultAction: true,
        onPressed: () {
          CustomNavigator.navigateTo(context, ReportReplyPage(commentReplies: comment));
        },
      ),
    ],
  );
  showCupertinoModalPopup(context: context, builder: (context) => action);
}


showDeletePeeksVideo(context,PeekDetail? peekDetail , void Function() onTap) {
  final action = CupertinoActionSheet(
    actions: <Widget>[
      if((AppData().userdetail!.users_id == peekDetail!.usersId)) CupertinoActionSheetAction(
          child: Text("Delete Video",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          isDefaultAction: true,
          onPressed: onTap
      ),

      if(AppData().userdetail!.users_id != peekDetail.usersId)    CupertinoActionSheetAction(
        child: Text("Report peek",
          style: TextStyle(color: Colors.blue,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        isDefaultAction: true,
        onPressed: () {
          CustomNavigator.navigateTo(context, ReportPeeks(peekDetail:peekDetail));
        },
      ),
    ],
  );
  showCupertinoModalPopup(context: context, builder: (context) => action);
}

