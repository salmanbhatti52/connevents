import 'package:carousel_slider/carousel_slider.dart';
import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/create-event-model.dart';
import 'package:connevents/pages/eventComments/eventCommentsPage.dart';
import 'package:connevents/pages/eventDetails/eventDetailsPage.dart';
import 'package:connevents/pages/eventPeeks/event-peeks.dart';
import 'package:connevents/pages/home/parse-media.dart';
import 'package:connevents/pages/home/event-preview-screen.dart';
import 'package:connevents/pages/liveStreaming/alert-box/live-streaming-scheduled-alert.dart';
import 'package:connevents/pages/liveStreaming/alert-box/meeting-started-alert.dart';
import 'package:connevents/pages/liveStreaming/broadcast_page.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/date-time.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/confirmation-dialog.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:connevents/widgets/report-event-dialog.dart';
import 'package:connevents/widgets/unicorn-Outline-Button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePageEvents extends StatefulWidget {
  final List<EventDetail> eventDetail;
  bool isShowPeeks;
  bool? isBasic;
  final Function()? onTapEnableLocation;
  final Function()? scroll;
  final Function(String isEventFavourite,num eventPostId)? onTapFavourite;
  final Function(String isEventLiked,num eventPostId) isLiked;
   HomePageEvents({Key? key,this.isBasic,this.isShowPeeks=false,this.scroll,required this.eventDetail,this.onTapFavourite,required this.isLiked,this.onTapEnableLocation}) : super(key: key);
  @override
  State<HomePageEvents> createState() => _HomePageEventsState();
}

class _HomePageEventsState extends State<HomePageEvents> {
  int currentSlide = 0;

 final GlobalKey<RefreshIndicatorState> refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(top:11.0),
        child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: BouncingScrollPhysics(),
            itemCount: widget.eventDetail.length,
            itemBuilder: (context,index){
            EventDetail event= widget.eventDetail[index];
             return  Column(
               children: [
                 Padding(
                   padding: const EdgeInsets.only(top: 4, bottom: padding / 2),
                   child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                      Stack(
                        children: [
                          CarouselSlider(
                            items: parseMedia(event).map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return GestureDetector(
                                    onTap:() {
                                      CustomNavigator.navigateTo(context, EventPreviewScreen(imageUrls: parseMedia(event),imageData: parseMedia(event).firstWhere((element) => element.attachment==i.attachment),eventDetail: event));
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          child: Image.network(
                                            i.attachment,fit: BoxFit.cover,
                                            loadingBuilder: (context, child, loadingProgress) => (loadingProgress  == null) ?
                                            child : Center(child: CircularProgressIndicator()),
                                            errorBuilder : (context, error, stackTrace) =>
                                             Center(
                                             child: Text("No Image Available",style:TextStyle(fontSize:18))
                                         ),
                                )
                                        ),
                                        if(i.type=="video")
                                        Center(child: Icon(Icons.play_arrow_rounded,color: Colors.white,size:100))
                                      ],
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                            options: CarouselOptions(
                                height: 170.0,
                                viewportFraction: 1,
                                enlargeCenterPage: false,
                                enableInfiniteScroll: true,
                                autoPlay: false,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    currentSlide = index;
                                  });
                                }),
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: parseMedia(event).map((url) {
                                  int index = parseMedia(event).indexOf(url);
                                  return Container(
                                    width: 7.0,
                                    height: 7.0,
                                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white, width: 1),
                                      shape: BoxShape.circle,
                                      color: currentSlide == index ? Colors.white : Colors.grey,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: IconButton(
                              onPressed: () =>widget.onTapFavourite!(event.isFavourite!,event.eventPostId!),
                              icon: SvgPicture.asset(event.isFavourite=="true" ?   'assets/icons/favYellow.svg' : 'assets/icons/Fav.svg',width: 40)),
                          ),
                           if(AppData().userdetail!.users_id != event.usersId) Positioned(
                             top: 5,
                             left: 5,
                             child: PopupMenuButton(
                                child: Center(
                                child: Icon(Icons.more_vert,color:Colors.green)),
                                shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.all(
                                   Radius.circular(6.0),
                              ),
                              ),
                                onSelected: (value){
                                if(value==1)
                                showDialog(context: context,builder:(ctx)=> ReportEventDialog(eventPostId: event.eventTypeId));
                                print(value.toString());
                              },
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  height:20,
                                  padding: EdgeInsets.zero,
                                  value: 1,
                                  child: Container(
                                      width: MediaQuery.of(context).size.width/3.6,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left:2.0),
                                        child: Center(child: Text('Report Event',style:TextStyle(fontSize: 17))),
                                      ))),
                              ]
                            )
                          ),
                        ],
                      ),
                       if(event.dressCodeColor !=null)
                        Divider(color: Color(int.parse(event.dressCodeColor!)), thickness: 8, height: 8),
                          Container(
                            padding: EdgeInsets.all(padding / 2),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right:8.0),
                                  child: UnicornOutlineButton(
                                    gradient: LinearGradient(colors: [Colors.black, Colors.redAccent]),
                                    radius: 21,
                                    onPressed: (){
                                      if(event.eventTicketType!="NotMyEvent"){
                                        if(event.isPeeksAvailable)
                                          CustomNavigator.navigateTo(context, EventPeeks(fromHome: true,eventDetail: event));
                                          else
                                          showErrorToast('No Peeks available for this event');
                                      }
                                      },
                                    strokeWidth: 3,
                                    child: CircleAvatar(
                                      radius: 18,
                                     backgroundImage: NetworkImage(event.firstImage),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                              child: Text(event.title,overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),)),
                                        ],
                                      ),
                                      event.distanceMiles !=null ?
                                      Text('${event.distanceMiles!.toStringAsFixed(0)} miles away', style: TextStyle(color: Colors.black, fontSize: 14),):
                                      TextButton(
                                      onPressed: widget.onTapEnableLocation,
                                      child: Text("Enable Location")),
                                    ],
                                  ),
                                ),
                                SizedBox(width: padding / 2),
                                SizedBox(
                                  height: 37,
                                  width: 106,
                                  child: TextButton(
                                    onPressed: () async{
                                      if(event.eventTicketType == "MyFreeEvent"){
                                           CustomNavigator.navigateTo(context, EventDetailsPage(isBasic: widget.isBasic, event: event,images: parseMedia(event)));
                                      }
                                      else if(event.eventTicketType=="Paid") {
                                        print("Date Time");
                                        print(daysBetween(DateTime.now(), DateTime.parse(event.salesEndDatetime!)));
                                            print("Date Time");

                                        if(event.totalAvailableTicketQuantity! < 1)   showConfirmation(context, builder: buyTickets);
                                          else if(daysBetween(DateTime.now(), DateTime.parse(event.salesEndDatetime!)) < 0)   showConfirmation(context, builder: salesEndTime);
                                          else CustomNavigator.navigateTo(context, EventDetailsPage(isBasic: widget.isBasic, event: event,images: parseMedia(event)));
                                      }
                                      else{
                                        CustomNavigator.navigateTo(context, EventDetailsPage(isBasic: widget.isBasic,event: event,link:event.hyperlink,images: parseMedia(event)));
                                        //open Web Page View
                                      }
                                    },
                                    child: Text(event.eventTicketType == "Paid" ? 'Buy Ticket' : event.eventTicketType == "MyFreeEvent" ? "Free ticket" : "Endorsed", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold,),),
                                    style: TextButton.styleFrom(
                                      backgroundColor: globalGreen,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: padding / 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    CustomNavigator.navigateTo(context, EventCommentsPage(
                                      event: event,
                                      images:  parseMedia(event),
                                    ));
                                  },
                                  child: Row(
                                    children: [
                                      SvgPicture.asset('assets/icons/comments.svg', width: 18),
                                      SizedBox(width: padding / 2),
                                      Text(event.totalPostComments.toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.5),),),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                    onTap:() => widget.isLiked(event.liked!,event.eventPostId!),
                                    child:event.liked=='true' ? SvgPicture.asset('assets/icons/heart.svg', width: 18):SvgPicture.asset('assets/icons/whiteheart.svg', width: 18)),
                                    SizedBox(width: padding / 2),
                                    Text("${event.totalLikes.toString()} Like", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.5),),),
                                  ],
                                ),
                                Text(event.timeAgo.toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.5),),),
                                if(event.isRoomCreated)
                                event.isRoomCreated && AppData().userdetail!.users_id == event.usersId ?
                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: globalLGray.withOpacity(0.5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                              onPressed: () async{

                                 DateTime dateTime   =  DateTime.parse("${event.roomDetails!.liveDate}"" ${ event.roomDetails!.liveEndTime}");
                                 print("hours ");
                                var seconds =    secondsBetween(DateTime.now(),dateTime);
                                 print("hours ");
                              print(event.roomDetails!.channelName);
                               DateTime liveStreamingStartingDateTime   =  DateTime.parse("${event.roomDetails!.liveDate}"" ${ event.roomDetails!.liveStartTime}");
                               DateTime liveStreamingEndingDateTime   =  DateTime.parse("${event.roomDetails!.liveDate}"" ${ event.roomDetails!.liveEndTime}");
                                print(liveStreamingStartingDateTime);

                                if(liveStreamingStartingDateTime.isAfter(DateTime.now())  && liveStreamingEndingDateTime.isBefore(DateTime.now())){
                                  showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return LiveStreamingScheduledAlert(liveDate:event.roomDetails!.liveDate ,liveTime: event.roomDetails!.convertedStartTime);
                                  });
                                }
                                else{

                                  print(event.meetingCode);
                                  openLoadingDialog(context, 'loading');
                                  var response = await DioService.post('start_live_stream',{
                                    "hostRoomId":event.roomDetails!.hostRoomId.toString(),
                                    "channelName" : event.roomDetails!.channelName,
                                    "roleId" : "1",
                                    "uId": AppData().userdetail!.users_id.toString(),
                                     "expireTimeInSeconds": seconds ,
                                    "userName": AppData().userdetail!.user_name.toString()
                                  });

                                Navigator.of(context).pop();
                                final  statusCamera  =  await _handleCameraAndMic(Permission.camera);
                                 final statusMicrophone =    await _handleCameraAndMic(Permission.microphone);
                                  //  CustomNavigator.navigateTo(context, VideoRoomPage());
                                 if(statusMicrophone.isGranted && statusCamera.isGranted){
                                  CustomNavigator.navigateTo(context, BroadcastPage(
                                        userId: event.usersId,
                                        rtcToken: response['rtc_token'],
                                        description: event.roomDetails!.description!,
                                        eventHostName: event.organizerUserName,
                                        rtmToken: response['rtm_token'],
                                        userName: AppData().userdetail!.user_name!,
                                        hostRoomId:  event.roomDetails!.hostRoomId!,
                                        channelName: event.roomDetails!.channelName!,
                                        isBroadcaster: true,
                                      ));
                               }
                               else {
                                 return showErrorToast("PLease Allow Permission");
                               }


                                 }

                                    // Navigator.pushNamed(context, '/videoRoom');
                                  },
                                  child: Column(
                                    children: [
                                      Text('Start Hosting', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.5),),),
                                      SizedBox(height: padding / 4,),
                                      SvgPicture.asset('assets/icons/video.svg', width: 30),
                                    ],
                                  ),
                                ) :
                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: globalLGray.withOpacity(0.5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  onPressed: () async {
                                     DateTime dateTime   =  DateTime.parse("${event.roomDetails!.liveDate}"" ${ event.roomDetails!.liveEndTime}");
                                     var seconds =    secondsBetween(DateTime.now(),dateTime);
                                  DateTime liveStreamingStartingDateTime   =  DateTime.parse("${event.roomDetails!.liveDate}"" ${ event.roomDetails!.liveStartTime}");
                                  DateTime liveStreamingEndingDateTime   =  DateTime.parse("${event.roomDetails!.liveDate}"" ${ event.roomDetails!.liveEndTime}");
                                if(liveStreamingStartingDateTime.isAfter(DateTime.now())  && liveStreamingEndingDateTime.isBefore(DateTime.now())){
                                  showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return LiveStreamingScheduledAlert(liveDate:event.roomDetails!.liveDate ,liveTime: event.roomDetails!.convertedStartTime);
                                  });
                                  }
                                else{
                                  openLoadingDialog(context, 'loading');
                                  var response = await DioService.post('start_live_stream',{
                                    "hostRoomId":event.roomDetails!.hostRoomId.toString(),
                                    "channelName" : event.roomDetails!.channelName.toString(),
                                    "roleId" : "2" ,
                                    "uId": AppData().userdetail!.users_id.toString(),
                                     "expireTimeInSeconds": seconds,
                                    "userName": AppData().userdetail!.user_name.toString()
                                  });
                                  Navigator.of(context).pop();
                                  if(response['status']=="success"){
                                    final  statusCamera  =  await _handleCameraAndMic(Permission.camera);
                                    final statusMicrophone =    await _handleCameraAndMic(Permission.microphone);
                                    //  CustomNavigator.navigateTo(context, VideoRoomPage());
                                   if(statusMicrophone.isGranted && statusCamera.isGranted) {
                                   CustomNavigator.navigateTo(context, BroadcastPage(
                                     userId: event.usersId,
                                     rtcToken: response['rtc_token'],
                                     rtmToken: response['rtm_token'],
                                     description: event.roomDetails!.description!,
                                     channelName: event.roomDetails!.channelName!,
                                     hostRoomId:  event.roomDetails!.hostRoomId!,
                                     eventHostName: event.organizerUserName,
                                     isBroadcaster: false,
                                     seconds: seconds,
                                   ));
                                    }

                                 // CustomNavigator.navigateTo(context, VideoRoomPage());
                                 //  CustomNavigator.navigateTo(context, LiveStreamingVideo());
                                 // Navigator.pushNamed(context, '/videoRoom');
                               }
                                  else if(response['status']=="error"){
                                     showDialog(
                                     barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return MeetingStartedAlert(message:response['data']);
                                      });
                                   }
                                }
                                },
                                  child: Column(
                                    children: [
                                      Text('Join Host', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.5),),),
                                      SizedBox(height: padding / 4),
                                      SvgPicture.asset('assets/icons/video.svg', width: 30,   color:  event.roomDetails!.isLiveStreamingStarted! == 'True' ?   Colors.red   : Color(0xffF3960B)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: padding)
                        ],
                      ),
                    ),
                 ),
                 // if(widget.isShowPeeks)
                 // if(index==0 || index % 2==0)
                 //  PeeksVideo()
               ],
             );
            }),
      ),
    );
        }

 Future<PermissionStatus> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    return status;
  }
}

