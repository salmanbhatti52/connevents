import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/notification-model.dart';
import 'package:connevents/pages/businessCommentsPages/business-Comment-Page.dart';
import 'package:connevents/pages/businessReplyPage/business-reply-page.dart';
import 'package:connevents/pages/eventComments/eventCommentsPage.dart';
import 'package:connevents/pages/eventReplyPage/eventReplyPage.dart';
import 'package:connevents/pages/home/no-result-available-message.dart';
import 'package:connevents/pages/home/parse-media.dart';
import 'package:connevents/pages/refundRequests/refundRequestsPage.dart';
import 'package:connevents/pages/tabs/tabsPage.dart';
import 'package:connevents/pages/ticketHistory/ticketHistoryPage.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {

  List<Notifications> notificationList=[];
   String message="";

  void notifications() async{
    var response ;
    try {
       response = await DioService.post('get_all_notifications', {
        "usersId": AppData().userdetail!.users_id
      });
       Navigator.of(context).pop();
       if(response['status']=='success'){
         var notifications = response['data'] as List;
         notificationList = notifications.map<Notifications>((e) => Notifications.fromJson(e)).toList();

         setState(() {});
       }
       else{
         message='No Notifications at the moment';
         setState(() {});
       }
    }
    catch(e){
      Navigator.of(context).pop();
    }
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        openLoadingDialog(context, "loading...");
        notifications();
         });
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
              onPressed: () {
                CustomNavigator.pushReplacement(context, TabsPage(index:4));
              },
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
          decoration: BoxDecoration(
            color: globallightbg,
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              padding: EdgeInsets.all(padding * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Notifications', style: TextStyle(color: globalBlack, fontSize: 36, fontWeight: FontWeight.bold,)),
                  SizedBox(height: padding * 2),
                  notificationList.isNotEmpty?
                  ListView.builder(
                    physics:NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: notificationList.length,
                      itemBuilder: (context,index){
                      Notifications notify=notificationList[index];
                    return  GestureDetector(
                      onTap:(){

                        /// Event Navigate Pages
                        if(notify.notificationType=="PostComment" || notify.notificationType=="CommentLike" || notify.notificationType=="CommentMention")
                        CustomNavigator.navigateTo(context, EventCommentsPage(
                          event: notify.eventDetail,
                          images:  parseMedia(notify.eventDetail!),
                          isNotification: true,
                        ));
                        else if(notify.notificationType=="RequestRefund"){
                          CustomNavigator.navigateTo(context, RefundRequestsPage());
                        }
                        else if(notify.notificationType=="TicketPurchase"){
                          CustomNavigator.navigateTo(context, TicketLibraryPage());
                        }
                        // else if(notify.notificationType=="PeekComment"){
                        //   CustomNavigator.navigateTo(context, EventPeeksDetail(
                        //     peekDetail: notify.peekDetails,
                        //     checkedInEventDetail: [], isShown: (bool isshown) {  },
                        //   ));
                        // }
                        else if((notify.commentDetails!=null) && (notify.notificationType=="ReplyLike" || notify.notificationType=="CommentReply")){
                          CustomNavigator.navigateTo(context, EventReplyPage(
                            comment: notify.commentDetails,
                            event: notify.eventDetail,
                          ));
                        }
                        /// Business Navigate Pages

                        else if(notify.notificationType=="BusinessReplyLike" || notify.notificationType=="BusinesscommentReply"){
                          CustomNavigator.navigateTo(context, BusinessReplyPage(
                            comment: notify.businessCommentDetails,
                            business: notify.businessDetail,
                          ));
                        }

                        if(notify.notificationType=="BusinessPostComment" || notify.notificationType=="BusinesscommentLike" || notify.notificationType=="BusinessCommentMention")
                        CustomNavigator.navigateTo(context, BusinessCommentsPage(
                          business: notify.businessDetail,
                          images:  businessParseMedia(notify.businessDetail!),
                          isNotification: true,
                        ));


                      },
                      child: Container(
                        padding: EdgeInsets.only(bottom: padding / 2),
                        margin: EdgeInsets.only(bottom: padding),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: globalLGray,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(notify.senderName!, style: TextStyle(color: globalBlack, fontSize: 18, fontWeight: FontWeight.bold)),
                                if(notify.notificationType=="RequestRefund")
                                Text("\$${notify.refundAmount.toString()}", style: TextStyle(color:Colors.red, fontSize: 18, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(height: padding / 2),
                            Text(notify.message!, style: TextStyle(color: globalBlack, fontSize: 18)),
                            SizedBox(height: padding / 2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset('assets/icons/calendarSmall.svg'),
                                    SizedBox(width: padding / 2),
                                    Text(notify.date!),
                                    SizedBox(width: padding),
                                    SvgPicture.asset('assets/icons/clock.svg'),
                                    SizedBox(width: padding / 2),
                                    Text(notify.time!),
                                  ],
                                ),
                                Icon(Icons.chevron_right, color: globalLGray),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }):
                  noResultAvailableMessage(message,context)
                ],
              ),
            ),
          )),
    );
  }
}
