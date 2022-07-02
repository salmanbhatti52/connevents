import 'dart:math';
import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/create-event-model.dart';
import 'package:connevents/models/image-videos-model.dart';
import 'package:connevents/pages/eventComments/eventCommentsPage.dart';
import 'package:connevents/pages/eventDetails/widget/carousel-slider-page.dart';
import 'package:connevents/pages/home/in-app-browser.dart';
import 'package:connevents/pages/home/parse-media.dart';
import 'package:connevents/pages/inviteToEvent/inviteToEventPage.dart';
import 'package:connevents/pages/messageDetails/messageDetailsPage.dart';
import 'package:connevents/pages/organizerPortfolio/organizer-portfolio.dart';
import 'package:connevents/pages/purchaseEvent/purchaseEventPage.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/date-time.dart';
import 'package:connevents/utils/fonts.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/confirmation-dialog.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:connevents/widgets/follow-user.dart';
import 'package:connevents/widgets/profile-image-picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailsPage extends StatefulWidget {
  int? dynamicEventPostId;
  bool fromDynamicLink;
  final String link;
   EventDetail? event;
  bool fromPeeks;
  final bool? isBasic;
   List<ImageData>?  images;
   EventDetailsPage({Key? key,this.dynamicEventPostId ,this.fromDynamicLink=false ,this.fromPeeks=false,this.isBasic,this.event,  this.images,this.link=""}) : super(key: key);

  @override
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  int currentSlide = 0;
  DateTime currentDate=DateTime.now();
  int differenceEarlyDate=-1;
  bool isReadMore=false;
  int lines=3;
  int dateTime=0;
  bool isFollow=false;
  String totalFollowers="";
  final key = new GlobalKey<ScaffoldState>();
   final List<Marker>  markers=[];
   late LatLng latLng;

    Future<void> openMap(double latitude, double longitude) async {
      String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
      if (await canLaunch(googleUrl)) {
        await launch(googleUrl);
      } else {
        throw 'Could not open the map.';
      }
    }



    addMarker(double lat, double long){
     int id=Random().nextInt(100);
     setState(() {
     markers.add(Marker(position: LatLng(lat,long) , markerId: MarkerId(id.toString())));
   });
   }

    Future likeEventPost(num eventPostId) async {
      openLoadingDialog(context, 'loading');
      try{
         var response = await DioService.post('like_event', {
        "eventPostId": eventPostId,
        "userId": AppData().userdetail!.users_id
      });
         widget.event!.liked=response['is_liked'];
         widget.event!.totalLikes=response['like_count'];

         setState(() {});
         Navigator.of(context).pop();
        // showSuccessToast(response['data']);
      }
      catch(e){
        Navigator.of(context).pop();
       // showSuccessToast(e.toString());
      }
    }

    Future unLikeEventPost(num eventPostId) async {
      openLoadingDialog(context, 'loading');
      try{
         var response = await DioService.post('unlike_event', {
        "eventPostId": eventPostId,
        "userId": AppData().userdetail!.users_id
      });
         widget.event!.liked=response['is_liked'];
         widget.event!.totalLikes=response['like_count'];
         print("Shahzaib");
         print(widget.event!.totalLikes);
         print(response['like_count']);
         print("Shahzaib");

         setState((){});
         Navigator.of(context).pop();
        // showSuccessToast(response['data']);
      }
      catch(e){
        Navigator.of(context).pop();
       // showSuccessToast(e.toString());
      }
    }

  @override
  void initState() {

    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
    );
    if(widget.fromDynamicLink){
      getEventById();
    }
  }

  Future getEventById() async{
      
      var response =await DioService.post('get_event', {
        "userId" : AppData().userdetail!.users_id,
        "eventId" : widget.dynamicEventPostId,
        "userLat": AppData().userLocation!.latitude,
        "userLong": AppData().userLocation!.longitude
      });
      
      print(response);
      if(response['status']=='success'){
        widget.event   = EventDetail.fromJson(response['data']);
        widget.images = parseMedia(widget.event!);
        widget.fromDynamicLink=false;
        setState(() {});
        print("Event Post Id");
        print(widget.dynamicEventPostId);
        print(widget.event!.toJson());
        print("Event Post Id");
      }else{
        print('No event Post Exist');
      }



  }


  @override
  Widget build(BuildContext context) {
    if(!widget.fromDynamicLink){
      addMarker(widget.event!.locationLat!,widget.event!.locationLong!);
      latLng = LatLng(widget.event!.locationLat!,widget.event!.locationLong!);
      var dateFormate =  DateFormat('yyyy-MM-dd HH:mm:ss');
      if(widget.event!.earlyBird !=null){
        DateTime     earlyBirdClosingDate = DateTime.parse(widget.event!.earlyBird!.closingDate);
        differenceEarlyDate =   daysBetween(DateTime.now(),earlyBirdClosingDate);
        dateTime =   daysBetween(DateTime.now(),DateTime.now());
        print(differenceEarlyDate);
      }
    }


    return Scaffold(
      body: widget.fromDynamicLink ? Center(child: CircularProgressIndicator()) :Container(
        child: Column(
          children: [
            CarouselSliderEventPage(event: widget.event,images: widget.images,onPressed: (){
              Navigator.of(context).pop(true);
            },),
            Expanded(
              child: Container(
                color:widget.event!.dressCodeColor!=null ? Color(int.parse(widget.event!.dressCodeColor!)) : null,
                padding: EdgeInsets.only(top: padding / 2),
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: globallightbg,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Padding(
                              padding: const EdgeInsets.all(padding),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                           CustomNavigator.navigateTo(context, EventCommentsPage(
                                            event: widget.event,
                                            images: widget.images,
                                          ));
                                        },
                                        child: Row(
                                          children: [
                                            SvgPicture.asset('assets/icons/comments.svg', color: globalGolden, width: 18, height: 16,),
                                            SizedBox(width: padding / 2),
                                            Text(widget.event!.totalPostComments.toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.5),),),
                                          ],
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: ()async {
                                      if(widget.event!.liked=='true') {
                                        await   unLikeEventPost(widget.event!.eventPostId!);
                                              }
                                        else  {
                                        await    likeEventPost(widget.event!.eventPostId!);
                                        }
                                        },
                                        child: Row(
                                          children: [
                                            widget.event!.liked=='true' ? SvgPicture.asset('assets/icons/heart.svg', width: 18):SvgPicture.asset('assets/icons/whiteheart.svg', width: 18),
                                            SizedBox(width: padding / 2),
                                            Text('${widget.event!.totalLikes} Likes', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.5),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {},
                                        child: Text(widget.event!.timeAgo.toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(color: globalLGray),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: padding / 2),
                                    child: Row(
                                      children: [
                                        Expanded(child: Text(widget.event!.title, softWrap: true, style:gilroyExtraBold)),
                                       if(widget.event!.eventTicketType=="Paid")
                                         (widget.event!.earlyBird != null && differenceEarlyDate > -1 && widget.event!.earlyBirdAvailable>0 )    || (widget.event!.regular != null && widget.event!.regularAvailable! > 0) ?
                                        Text(differenceEarlyDate > -1  && widget.event!.earlyBirdAvailable > 0  ?   '\$ ${widget.event!.earlyBird!.price}' : '\$ ${widget.event!.regular!.price}', style: TextStyle(color: globalGreen, fontSize: 20, fontWeight: FontWeight.w600),
                                        ):(widget.event!.vip !=null  &&   widget.event!.vipAvailable! > 0) ?  Text('\$ ${widget.event!.vip!.price}') :  Text('\$ ${widget.event!.skippingLine!.price}' ,  style: TextStyle(color: globalGreen, fontSize: 20, fontWeight: FontWeight.w600,))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(bottom: padding),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset('assets/icons/mark.svg', color: globalGreen, width: 16, height: 18,),
                                            SizedBox(width: padding/1.5),
                                            Text('${widget.event!.distanceMiles!}', style: gilroyMedium,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: padding / 2),
                                        Row(
                                          children: [
                                            SvgPicture.asset('assets/icons/calendar.svg', color: globalGreen, width: 22, height: 22),
                                            SizedBox(width: padding/3),
                                            Text('${widget.event!.eventStartDate} – ${widget.event!.eventEndDate}', style: gilroyMedium,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Description' , style: gilroyExtraBold),
                                        SizedBox(height: padding / 7),
                                        Stack(
                                          children: [
                                            GestureDetector(
                                                onLongPress: () async{
                                            await    Clipboard.setData(new ClipboardData(text: widget.event!.description.toString()));
                                                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                     content: Text('Copied')));
                                                },
                                                child: Text(widget.event!.description!,
                                                       overflow: isReadMore ? TextOverflow.visible: TextOverflow.ellipsis,
                                                       maxLines: isReadMore ? null : 3,
                                                       style: gilroyRegular, softWrap: true)
                                            ),
                                            if(widget.event!.description!=null &&   widget.event!.description!.length > 150)
                                            Positioned(
                                              right:0,
                                              bottom:0,
                                              child: InkWell(
                                                  onTap: (){
                                                    setState(() {
                                                    isReadMore = !isReadMore;
                                                        });
                                                  },
                                                  child: Container(
                                                      color:globallightbg,
                                                      child: Text(!isReadMore ?  "..See more"  : "See less",style:TextStyle(color:globalGreen,fontWeight: FontWeight.bold)))),
                                            )
                                          ],
                                        ),
                                         SizedBox(height: padding / 2),
                                        if(widget.event!.eventTicketType=="Paid")
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                              Text('Refund Policy', style: gilroyExtraBold),
                                              SizedBox(height: padding / 6),
                                              Text('ConnEvents fee is nonrefundable. See Terms and Conditions. There is a 10 ticket limit per customer.\n\nBy purchasing tickets to this event, you agree to abide by the rules for entry that are in effect at the time of the event.', style: TextStyle(color: globalBlack,fontSize: 14,fontWeight: FontWeight.w700)),
                                              SizedBox(height: padding / 2),
                                              Text('Contact the organizer to request a refund.', style: TextStyle(color: globalBlack,fontSize: 14)),
                                          ],
                                        ),
                                         if(widget.event!.eventTicketType=="NotMyEvent")
                                            Column(
                                               mainAxisAlignment: MainAxisAlignment.start,
                                               crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                              Text('Disclosure :', style: TextStyle(color: globalBlack, fontSize: 20, fontWeight: FontWeight.bold)),
                                              RichText(text: TextSpan(
                                        style: TextStyle(color: Colors.black ,fontSize: 14,fontWeight: FontWeight.w700),
                                        text: "This event is not being hosted on the ConnEvents service app. Please ",
                                        children: [
                                          TextSpan(text:" Click Go to Website",style: TextStyle(fontWeight: FontWeight.bold),
                                          children: [
                                            TextSpan(
                                              style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700),
                                              text: " button to see the event's date, address and related costs."
                                            )
                                          ])
                                        ]

                                      ))

                                          ],
                                        )


                                      ],
                                    ),
                                  ),
                                  SizedBox(height: padding / 2),
                                  Container(
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  SizedBox(width: padding / 5),
                                                  SvgPicture.asset('assets/icons/clock.svg', width: 14),
                                                  SizedBox(width: padding / 2),
                                                  Text('${widget.event!.eventStartTime} - ${widget.event!.eventEndTime}'  , style: TextStyle(color: globalBlack, fontSize: 16, fontWeight: FontWeight.bold),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: padding / 2),
                                         ElevatedButton(onPressed: (){
                                           openMap(widget.event!.locationLat!,widget.event!.locationLong!);

                                      //     CustomNavigator.navigateTo(context, GoogleMapAddress(event: widget.event!));
                                         },child: Text("Get Location",style: TextStyle(fontWeight: FontWeight.bold))),
                                        SizedBox(height: padding / 2),
                                        Container(
                                          margin: EdgeInsets.only(bottom: padding * 2),
                                          width: double.infinity,
                                          height: 150,
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                  color: globalLGray, blurRadius: 5),
                                            ],
                                          ),
                                          child: GoogleMap(
                                                mapType: MapType.normal,
                                                initialCameraPosition: CameraPosition(
                                                target: LatLng(widget.event!.locationLat!,widget.event!.locationLong!),
                                                zoom: 5.0,
                                              ),
                                              markers: markers.toSet()
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if(widget.event!.eventTicketType != "NotMyEvent")
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: padding),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Organizer' , style: TextStyle(color: globalBlack, fontSize: 18, fontWeight: FontWeight.bold)),
                                        SizedBox(height: padding / 2),
                                        Row(
                                          children: [
                                             GestureDetector(
                                               onTap:(){
                                             //    if((widget.isBasic! && widget.event!.usersId ==AppData().userdetail!.users_id  ))
                                                   CustomNavigator.navigateTo(context, OrganizerPortfolio(
                                                    eventDetail: widget.event,
                                                ));
                                               //  else showErrorToast('You need to upgrade on premium account');
                                               },
                                               child: Row(
                                                 children: [
                                                   SizedBox(
                                                     width: 50,
                                                     height: 50,
                                                     child: ProfileImagePicker(
                                                      onImagePicked: (value){},
                                                      previousImage: widget.event!.organizerProfilePicture),
                                                   ),
                                                   Padding(
                                                     padding: const EdgeInsets.only(left:12.0),
                                                     child: Column(
                                                     crossAxisAlignment: CrossAxisAlignment.start,
                                                     children: [
                                                     Text(widget.event!.organizerUserName!, style: TextStyle(color: globalGreen, fontSize: 14, fontWeight: FontWeight.bold,decoration: TextDecoration.underline)),
                                                ],
                                            ),
                                                   ),
                                                 ],
                                               ),
                                             ),
                                             SizedBox(width: padding),
                                             Expanded(child: SizedBox()),
                                             FollowUser(isFollow: widget.event!.isFollowing,userId: widget.event!.usersId,event: widget.event)
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(padding),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 3.0,
                              color: globalLGray,
                            )
                          ],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 44,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      side: BorderSide(
                                        color: globalGreen,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  onPressed: () => CustomNavigator.navigateTo(context, InviteToEventPage(eventDetail: widget.event!)),
                                  child: Text('INVITE', style: TextStyle(color: globalGreen, fontSize: 16, fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: padding / 2),
                            if(widget.event!.eventTicketType!="MyFreeEvent")
                            Expanded(
                              child: SizedBox(
                                height: 44,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: globalGreen,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      side: BorderSide(
                                        color: globalGreen,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    if(widget.event!.eventTicketType=='Paid'){
                                      if(widget.event!.isAdmin){
                                        showErrorToast("You can't Buy your Own Event Ticket");
                                      }else {
                                        if(widget.event!.isEditableEvent){
                                          showErrorToast("Event Sales Date is not started yet");
                                        }
                                        else{
                                          if(widget.fromPeeks)  {
                                            if(widget.event!.totalAvailableTicketQuantity! < 1)   showConfirmation(context, builder: buyTickets);
                                            else if(daysBetween(DateTime.now(), DateTime.parse(widget.event!.salesEndDatetime!) ) < 0)   showConfirmation(context, builder: salesEndTime);
                                            else CustomNavigator.navigateTo(context, PurchaseEventPage(
                                                images: widget.images,
                                                event: widget.event!,
                                                differenceEarlyBirdDate: this.differenceEarlyDate,
                                              ));
                                          }  else
                                            CustomNavigator.navigateTo(context, PurchaseEventPage(
                                              images: widget.images,
                                              event: widget.event!,
                                              differenceEarlyBirdDate: this.differenceEarlyDate,
                                            )
                                            );
                                        }

                                      }

                                    }
                                    else
                                      CustomNavigator.navigateTo(context, InAppBrowserPage(
                                       link: widget.link,
                                             ));
                                    // Navigator.pushNamed(context, '/purchaseEvent');
                                  },
                                  child: Text(widget.event!.eventTicketType == "Paid" ?  'BUY' : 'VIEW EVENT', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: padding / 2),
                            if(AppData().userdetail!.users_id != widget.event!.usersId)
                            SizedBox(
                              height: 44,
                              width: 44,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(44),
                                    side: BorderSide(
                                      color: globalGreen,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  CustomNavigator.navigateTo(context, MessageDetailsPage(
                                    otherUserChatId: widget.event!.usersId,
                                      userName: widget.event!.organizerUserName!,
                                    profilePic: widget.event!.organizerProfilePicture!,

                                  ));
                                  // Navigator.of(context).pushNamed('/message');
                                },
                                child: SvgPicture.asset('assets/icons/tabs/message.svg', color: globalGreen, width: 22, height: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
