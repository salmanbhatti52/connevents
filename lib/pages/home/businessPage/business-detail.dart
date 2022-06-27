import 'dart:math';
import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/image-videos-model.dart';
import 'package:connevents/pages/businessCommentsPages/business-Comment-Page.dart';
import 'package:connevents/pages/home/in-app-browser.dart';
import 'package:connevents/pages/inviteToEvent/inviteToEventPage.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/fonts.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:connevents/widgets/profile-image-picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:connevents/models/business-create-model.dart';

import 'business-carousel-slider.dart';


class BusinessDetailsPage extends StatefulWidget {
  final String link;
  final Business? business;
  final List<ImageData>?  images;
  const BusinessDetailsPage({Key? key, this.business,  this.images,this.link=""}) : super(key: key);

  @override
  _BusinessDetailsPageState createState() => _BusinessDetailsPageState();
}

class _BusinessDetailsPageState extends State<BusinessDetailsPage> {
  int currentSlide = 0;
  DateTime currentDate=DateTime.now();
  int differenceEarlyDate=-1;
  int dateTime=0;
  String? isLiked;
  bool isReadMore=false;
  int lines=3;
  bool isFollow=false;
  final key = new GlobalKey<ScaffoldState>();
   final List<Marker>  markers=[];
   late LatLng latLng;


  Future likeBusinessPost(num eventPostId) async {
    openLoadingDialog(context, 'loading');
    try{
      var response = await DioService.post('like_unlike_business_post' , {
        "businessId": eventPostId,
        "usersId": AppData().userdetail!.users_id
      });
      widget.business!.liked=response['data'];
      if(widget.business!.liked)   widget.business!.totalLikes = (int.parse(widget.business!.totalLikes!)+1).toString() ;
      else widget.business!.totalLikes = (int.parse(widget.business!.totalLikes!)-1).toString();

      setState(() {});

      Navigator.of(context).pop();
      //  showSuccessToast(response['data']);
    }
    catch(e){
      Navigator.of(context).pop();
      showSuccessToast(e.toString());
    }
  }

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




  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
    );
  }

  @override
  Widget build(BuildContext context) {
    addMarker(widget.business!.businessLat!,widget.business!.businessLong!);
    latLng = LatLng(widget.business!.businessLat!,widget.business!.businessLong!);

    return Scaffold(
      body: Container(
        child: Column(
          children: [
            BusinessSliderPage(business: widget.business,images: widget.images),
            Expanded(
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
                                        CustomNavigator.navigateTo(context, BusinessCommentsPage(
                                          business: widget.business,
                                          images: widget.images,
                                        ));
                                      },
                                      child: Row(
                                        children: [
                                          SvgPicture.asset('assets/icons/comments.svg', color: globalGolden, width: 18, height: 16,),
                                          SizedBox(width: padding / 2),
                                          Text(widget.business!.totalPostComments.toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.5),),),
                                        ],
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: ()async {
                                        likeBusinessPost(widget.business!.businessId!);
                                      },
                                      child: Row(
                                        children: [
                                          widget.business!.liked ? SvgPicture.asset('assets/icons/heart.svg', width: 18):SvgPicture.asset('assets/icons/whiteheart.svg', width: 18),
                                          SizedBox(width: padding / 2),
                                          Text('${widget.business!.totalLikes} Likes', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.5),
                                          ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      child: Text(widget.business!.timeAgo.toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.5),
                                      ),
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(color: globalLGray),
                                Padding(
                                  padding: const EdgeInsets.only(top: padding / 2),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(widget.business!.title, softWrap: true, style: gilroyExtraBold),
                                      Padding(
                                        padding: const EdgeInsets.only(right:8.0),
                                        child: SizedBox(
                                          width: 35,
                                          height: 35,
                                          child: ProfileImagePicker(
                                            onImagePicked: (value){},
                                            previousImage: widget.business!.businessLogo,
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: padding/7,bottom: padding/5),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset('assets/icons/mark.svg', color: globalGreen, width: 18, height: 20,),
                                          SizedBox(width: padding /2),
                                          Text('${widget.business!.distanceMiles!}', style: TextStyle(color: globalBlack, fontSize: 16,),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: padding / 2),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Description', style: gilroyExtraBold),
                                      SizedBox(height: padding / 2),
                                     Stack(
                                          children: [
                                            GestureDetector(
                                                onLongPress: () async{
                                            await    Clipboard.setData(new ClipboardData(text: widget.business!.description.toString()));
                                                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                     content: Text('Copied')));
                                                },
                                                child: Text(widget.business!.description.toString(),
                                                       overflow: isReadMore ? TextOverflow.visible: TextOverflow.ellipsis,
                                                       maxLines: isReadMore ? null : 3,
                                                       style: gilroyRegular, softWrap: true)
                                            ),
                                            if(widget.business!.description.length > 150)
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
                                                      child: Text(!isReadMore ?  "..See more"  : "Less more",style:TextStyle(color:globalGreen,fontWeight: FontWeight.bold)))),
                                            )
                                          ],
                                        ),
                                      SizedBox(height: padding / 1.2),
                                      Text('Disclosure :', style: gilroyBold),
                                      SizedBox(height: padding / 2),
                                      RichText(text: TextSpan(
                                        style: gilroyLight,
                                        text: "This is not a ConnEvents provided service or event; therefore, we don't require anything from the user. All concerns and requests should be addressed directly to the organizer. Click",
                                        children: [
                                          TextSpan(text:" Go to Website",style: TextStyle(fontWeight: FontWeight.bold),
                                          children: [
                                            TextSpan(
                                              style: TextStyle(fontWeight: FontWeight.normal),
                                              text: " for all available information."
                                            )
                                          ])
                                        ]

                                      ))
                                    //  Text("This is not a ConnEvents provided service or event; therefore, we don't require anything from the user. All concerns and requests should be addressed directly to the organizer. Click Go to Website for all available information.", style: TextStyle(color: globalBlack, fontSize: 12, fontWeight: FontWeight.w700)),
                                    ],
                                  ),
                                ),
                                SizedBox(height: padding / 2),
                                Container(
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      SizedBox(height: padding / 2),
                                       ElevatedButton(onPressed: (){
                                         openMap(widget.business!.businessLat!,widget.business!.businessLong!);
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
                                              target: LatLng(widget.business!.businessLat!,widget.business!.businessLong!),
                                              zoom: 5.0,
                                            ),
                                            markers: markers.toSet()
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
                                onPressed: () => CustomNavigator.navigateTo(context, InviteToEventPage()),
                                child: Text('Share', style: TextStyle(color: globalGreen, fontSize: 16, fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: padding / 2),
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
                                  print(widget.link);
                                  if(widget.link.contains("https://")|| widget.link.contains("http://"))
                                    CustomNavigator.navigateTo(context, InAppBrowserPage(link: widget.link));
                                  else
                                    CustomNavigator.navigateTo(context, InAppBrowserPage(link: "https://"+widget.link));
                                },
                                child: Text('Go To Website', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold,
                                  ),
                                ),
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
          ],
        ),
      ),
    );
  }
}
