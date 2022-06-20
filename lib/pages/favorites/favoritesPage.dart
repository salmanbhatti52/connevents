import 'dart:io';
import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/cities-model.dart';
import 'package:connevents/models/create-event-model.dart';
import 'package:connevents/models/distance-model.dart';
import 'package:connevents/models/event-address-model.dart';
import 'package:connevents/models/event-dummy-ticket.dart';
import 'package:connevents/models/event-tags-model.dart';
import 'package:connevents/models/event-type-model.dart';
import 'package:connevents/models/image-videos-model.dart';
import 'package:connevents/models/user-location-model.dart';
import 'package:connevents/pages/home/businessPage/business-page.dart';
import 'package:connevents/pages/home/home-page-events.dart';
import 'package:connevents/pages/home/no-result-available-message.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/connevent-appbar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:connevents/models/business-create-model.dart';


class FavoritesPage extends StatefulWidget {
  bool isShowPeeks;
   FavoritesPage({Key? key,this.isShowPeeks=false}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {

  EventDetail  event = EventDetail( vip: VIP(), earlyBird: EarlyBird(),regular: Regular(), eventAddress: EventAddress(),skippingLine: SkippingLine());

  int currentOffset=0;
  int currentSlide = 0;
  num?  eventPostId;
  String message="";
  int totalPosts=0;
  List<Business> businessDetail=[];
  List<EventDetail> eventDetail=[];
  Future<CreateEventModel>? futureCreateEvent;
  EventTypeList? listOfEventType;
  List<City> listOfCity = [];
  Future<EventTypeList>? futureEventTypeModel;
  Future<EventTypeCategories>? futureCategoryModel;
  Future<CityData>? futureCityModel;
  DateTime selectedDate= DateTime.now();
  String date='';
  String date1='';
  File? firstVideoThumbnail;
  File? secondVideoThumbnail;
  File? thirdVideoThumbnail;
  List<ImageData> images=[];
  List<String> videos=[];
  TextEditingController search=TextEditingController();
  List<City>  searchCountry=[];
  bool isAll=false;
  bool isToday=false;
  DateTime today=DateTime.now();
  var userCurrentLocation;
  Future<EventTagsModel>? futureEventTagsModel;
  List<TagsData> listOfTags = [];
  bool isVisibleTags=false;
  bool isCheckTag=false;
  List<Distance> distance=[];
  List<int> tagsList=[];
  bool isResultAvailable=false;
  late Position userLocation;
  String city='';
  String selectedSegment = 'Events';
  bool showSearchBar = false;
  File? thumb;
  var response;
  int businessCurrentOffset=0;
  int businessTotalPosts=0;
  RefreshController refreshController=RefreshController(initialRefresh: true);


  void isSelectedEvents()async{
    openLoadingDialog(context, "loading");
    selectedSegment="Events";
    isAll=true;
    setState(() {});
    await  getEvents(isReFresh: true);
    Navigator.of(context).pop();
  }

  void isSelectedBusiness()async{
    openLoadingDialog(context, "loading");
    isToday=true;
    selectedSegment = 'nearby';
    setState(() {});
    await  getNearbyBusiness(isReFresh: true);
    Navigator.of(context).pop();
  }


  void onLiked(isLiked,eventPostId) async {
    if(isLiked=='true') {
      await   unLikeEventPost(eventPostId!);
      openLoadingDialog(context, "loading");
      await  getEvents(isReFresh: true);
      Navigator.of(context).pop();
    }
    else  {
      await    likeEventPost(eventPostId!);
      openLoadingDialog(context, "loading");
      await   getEvents(isReFresh: true);
      Navigator.of(context).pop();
    }

  }

  void onFavourite(isFavourite,eventPostId) async {
    openLoadingDialog(context, "loading");
    var res;
    try{
      if(isFavourite=="true"){
        res=    await DioService.post('unfavourite_event_post', {
          "userId":  AppData().userdetail!.users_id,
          "eventPostId": eventPostId
        });
        print(res);
        openLoadingDialog(context,"loading");
        await getEvents(isReFresh: true);
        Navigator.of(context).pop();
      }
      else{
        res=    await DioService.post('favourite_event_post', {
          "userId":  AppData().userdetail!.users_id,
          "eventPostId": eventPostId
        });
        openLoadingDialog(context,"loading");
        await getEvents(isReFresh: true);
        Navigator.of(context).pop();
      }
      showErrorToast(res['data']);
      Navigator.of(context).pop();
    }
    catch(e){
      showErrorToast(e.toString());
      Navigator.of(context).pop();
    }
  }

  Future getUserLocation({lat, long}) async {
    var currentLocation;
    try{
      currentLocation = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      userCurrentLocation=currentLocation;
      setState(() {
        AppData().userLocation    = UserLocation(latitude: userCurrentLocation.latitude, longitude: userCurrentLocation.longitude);
      });
      print("i am here the location");
      print(AppData().userLocation!.toJson());
      print("i am here the location");
      print(userCurrentLocation.longitude);
    }
    catch(e){
      print(e.toString());
    }
  }

  Future likeEventPost(num eventPostId) async {
    openLoadingDialog(context, 'loading');
    try{
      var response = await DioService.post('like_event', {
        "eventPostId": eventPostId,
        "userId": AppData().userdetail!.users_id
      });
      Navigator.of(context).pop();
      showSuccessToast(response['data']);
    }
    catch(e){
      Navigator.of(context).pop();
      showSuccessToast(e.toString());
    }
  }

  Future unLikeEventPost(num eventPostId) async {
    openLoadingDialog(context, 'loading');
    try{
      var response = await DioService.post('unlike_event', {
        "eventPostId": eventPostId,
        "userId": AppData().userdetail!.users_id
      });
      Navigator.of(context).pop();
      showSuccessToast(response['data']);
    }
    catch(e){
      Navigator.of(context).pop();
      showSuccessToast(e.toString());
    }
  }

  Future<bool>  getNearbyBusiness({bool isReFresh=false}) async {
    await getUserLocation();
    DateTime today=DateTime.now();
    bool isData = false;
    if(isReFresh) {
      businessCurrentOffset=0;
    }
    else{
      if(businessDetail.length >= businessTotalPosts){
        refreshController.loadNoData();
        return false;
      }
    }
    response = await DioService.post('get_all_business_favourites', {
      if(userCurrentLocation !=null)
        "userLat":userCurrentLocation.latitude,
      if(userCurrentLocation !=null)
        "userLong":userCurrentLocation.longitude,
      'userId':AppData().userdetail!.users_id,
      'offset': businessCurrentOffset.toString(),
    });

    if (response['status'] == 'success') {
      var event = response['data'] as List;
      List<Business> business = event.map<Business>((e) => Business.fromJson(e)).toList();
      business.map((e) => distance.add(Distance(long: e.businessLong!, lat: e.businessLong!))).toList();
      if(isReFresh)  businessDetail = business;
      else businessDetail.addAll(business);
      print(business.first.toJson());
      businessCurrentOffset = businessCurrentOffset + 5;
      businessTotalPosts= response['total_posts'];
      isData = true;
      //  Navigator.of(context).pop();
      isResultAvailable=true;
      setState(() {});

    } else {
      setState(() {
        businessDetail.clear();
        message="No Result Available";
        print(response['message']);
        isData = false;
      });
    }
    return isData;
  }

  Future<bool>  getEvents({bool isReFresh=false}) async {
    await getUserLocation();
    DateTime today=DateTime.now();
    bool isData = false;
    if(isReFresh) currentOffset=0;
    else{
      if(currentOffset >= totalPosts){
        refreshController.loadNoData();
        return false;
      }
    }
    if(isAll) {
      response = await DioService.post('get_all_favourites', {
        if(userCurrentLocation !=null)
          "userLat":userCurrentLocation.latitude,
          if(userCurrentLocation !=null)
          "userLong":userCurrentLocation.longitude,
        'offset': currentOffset.toString(),
        'userId':AppData().userdetail!.users_id,
        if(tagsList.length > 0)
          "tagsFilter":tagsList
      });

      setState(() => isAll=false);
    }
    else if(isToday){
      final f =  DateFormat('yyyy-MM-dd');
      response = await DioService.post('get_all_favourites', {
        if(userCurrentLocation != null)
          "userLat":userCurrentLocation.latitude,
        if(userCurrentLocation !=null)
          "userLong":userCurrentLocation.longitude,
        'userId':AppData().userdetail!.users_id,
        'offset': currentOffset.toString(),
        "dateFilter": f.format(today),
      });
      setState(() => isToday=false);
    }
    else {
      response = await DioService.post('get_all_favourites', {
        if(userCurrentLocation !=null)
          "userLat":userCurrentLocation.latitude,
        if(userCurrentLocation !=null)
          "userLong":userCurrentLocation.longitude,
        'userId':AppData().userdetail!.users_id,
        'offset': currentOffset.toString(),
      });


    }
    print(response);
    if (response['status'] == 'success') {
      var event = response['data'] as List;
      currentOffset = currentOffset + 5;
      List<EventDetail> events = event.map<EventDetail>((e) => EventDetail.fromJson(e)).toList();
      events.map((e) => distance.add(Distance(long: e.locationLong!, lat: e.locationLat!))).toList();
     // events.sort((b,a)=>a.eventPostId!.compareTo(b.eventPostId!));
      if(isReFresh)  eventDetail = events;
      else eventDetail.addAll(events);
      totalPosts= response['total_posts'];
      isData = true;
      isResultAvailable=true;
      setState(() {});
    } else {
      setState(() {
        eventDetail.clear();
        message="No Favorites Post";
        print(response['message']);
        isData = true;
      });
    }
    return isData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: globallightbg,
      appBar: ConneventAppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(top: 5),
        child: Column(
          children: [
            Expanded(
              child: SmartRefresher(
                controller: refreshController,
                enablePullUp: true,
                header: WaterDropHeader(),
                onRefresh: ()async{
                  final result;
                  if(selectedSegment == 'nearby')
                    result= await getNearbyBusiness(isReFresh: true);
                  else
                    result= await getEvents(isReFresh: true);
                  if(result){
                    refreshController.refreshCompleted();
                  }
                  else refreshController.refreshFailed();
                },
                onLoading: ()async{
                  if(selectedSegment == 'nearby'){
                    final businessResult= await getNearbyBusiness();
                    if(businessResult) refreshController.loadComplete();
                    else refreshController.loadComplete();
                  }
                  else{
                    final eventResult= await getEvents();
                    if(eventResult) refreshController.loadComplete();
                    else refreshController.loadComplete();
                  }

                },
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: padding, horizontal: padding * 2),
                    decoration: BoxDecoration(color: globallightbg),
                    child: Column(
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: globalLightButtonbg,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          clipBehavior: Clip.antiAlias,
                                          decoration: (selectedSegment == 'Events') ?
                                          BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(color: globalGreen),
                                              borderRadius: BorderRadius.circular(30)) :
                                          BoxDecoration(),
                                          child: TextButton(
                                            onPressed: ()=> isSelectedEvents(),
                                            child: Text('Events',style: TextStyle(color: Colors.black, fontSize: 12,
                                            ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          clipBehavior: Clip.antiAlias,
                                          decoration: (selectedSegment == 'nearby') ?
                                          BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(color: globalGreen),
                                              borderRadius: BorderRadius.circular(30)) :
                                          BoxDecoration(),
                                          child: TextButton(
                                              onPressed: () => isSelectedBusiness(),
                                              child: Text("What's Nearby" , style: TextStyle(color: Colors.black, fontSize: 12,
                                              ),
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: padding),

                            ],
                          ),
                        ),

                        selectedSegment=="Events" ?
                        eventDetail.length > 0 ?
                        HomePageEvents(
                          isShowPeeks: widget.isShowPeeks,
                          eventDetail: eventDetail,
                          onTapFavourite: (isFavourite,eventPostId)=>onFavourite(isFavourite,eventPostId),
                          onTapEnableLocation: ()async{
                            openLoadingDialog(context, "loading");
                            await    getEvents(isReFresh: true);
                            Navigator.of(context).pop();
                          },
                          isLiked: (isLiked,eventPostId) => onLiked(isLiked,eventPostId),
                        ): noResultAvailableMessage(message,context)
                            :
                        businessDetail.length > 0 ?
                        NearbyBusinessPage(business: businessDetail) :
                        noResultAvailableMessage(message,context)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ] ,
        ),
      ),
    );
  }
}
