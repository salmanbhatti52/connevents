import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
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
import 'package:connevents/pages/home/date-category.dart';
import 'package:connevents/pages/home/home-header/city-dialog-page.dart';
import 'package:connevents/pages/home/home-page-events.dart';
import 'package:connevents/pages/home/no-result-available-message.dart';
import 'package:connevents/pages/home/show-search-bar.dart';
import 'package:connevents/provider/provider-data.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/services/event-tags-service.dart';
import 'package:connevents/services/event-type-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/categories-button.dart';
import 'package:connevents/widgets/drop-down-container.dart';
import 'package:connevents/widgets/filter-container.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/src/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:connevents/models/business-create-model.dart';


class HomePage extends StatefulWidget {
    Function(String val)? unreadMessage;
   HomePage({Key? key,this.unreadMessage}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  EventDetail  event = EventDetail(  vip: VIP(), earlyBird: EarlyBird(),regular: Regular(), eventAddress: EventAddress(),skippingLine: SkippingLine());

  int eventCurrentOffset=0;
  int businessCurrentOffset=0;
  int currentSlide = 0;
  num?  eventPostId;
  String message="";
  int eventTotalPosts=0;
  int businessTotalPosts=0;
  List<EventDetail> eventDetail=[];
  List<Business> businessDetail=[];
  Future<CreateEventModel>? futureCreateEvent;
  EventTypeList? listOfEventType;
  List<City> listOfCity = [];
  Future<EventTypeList>? futureEventTypeModel;
  Future<EventTypeCategories>? futureCategoryModel;
  Future<CityData>? futureCityModel;
  DateTime selectedDate= DateTime.now();
  String date='';
  String date1='';
  int count = 0;
  File? firstVideoThumbnail;
  File? secondVideoThumbnail;
  File? thirdVideoThumbnail;
  List<ImageData> images=[];
  List<String> videos=[];
  String? search;
  List<City>  searchCountry=[];
  bool isEvent=false;
  bool isBusiness=false;
  DateTime today=DateTime.now();
  Future<EventTagsModel>? futureEventTagsModel;
  List<TagsData> listOfTags = [];
  bool isVisibleTags=false;
  bool isCheckTag=false;
  List<Distance> distance=[];
  List<int> tagsList=[];
  bool isResultAvailable=false;
  var response;
  List <Placemark>? placeMark;
  late Position userLocation;
  String city='';
  String selectedSegment = 'Events';
  bool showSearchBar = false;
  String? _tempDir;
  File? thumb;
  bool hasInternet=false;
  bool isServiceEnabled=true;
  bool isBasic = false;
  RefreshController refreshController=RefreshController(initialRefresh: true);
  ConnectivityResult connectivityResult= ConnectivityResult.none;



  void showDate() async {
    date = "";
    date1 = "";
    setState(() {});
    openLoadingDialog(context, "loading");
    if(selectedSegment == 'nearby')
    await getNearbyBusiness(isReFresh: true);
    else
    await getEvents(isReFresh: true);
    Navigator.of(context).pop();
  }

  void tapSearch() async {
    openLoadingDialog(context, "loading");
    if(selectedSegment == 'nearby')
    await getNearbyBusiness(isReFresh: true);
    else
    await getEventSearchBarFilter(isReFresh: true);
     Navigator.of(context).pop();
     setState(() {
     showSearchBar = !showSearchBar;
     });
  }

  void isSelectedEvents()async{
    search="";
    showSearchBar=false;
    openLoadingDialog(context, "loading");
    selectedSegment="Events";
    isEvent=true;
    setState(() {});
    await  getEvents(isReFresh: true);
    Navigator.of(context).pop();
  }

  void isSelectedBusiness()async{
    search="";
    showSearchBar=false;
    openLoadingDialog(context, "loading");
    selectedSegment="nearby";
    isBusiness=true;
    setState(() {});
    await  getNearbyBusiness(isReFresh: true);
    Navigator.of(context).pop();
  }

  Future filterEvents(listOfTags,value) async {
    setState((){
     listOfTags.isSelected=value!;
     if(listOfTags.isSelected) tagsList.add(listOfTags.tagId!);
     else tagsList.remove(listOfTags.tagId!);
     print(tagsList.toList());
   });
   openLoadingDialog(context, "loading");
   await getEvents(isReFresh: true);
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

  void onFavouriteEvent(isFavourite,eventPostId) async {
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

  void onFavouriteBusiness(isFavourite,businessId) async {
      openLoadingDialog(context, "loading");
      var res;
      try{
      if(isFavourite){
          res=    await DioService.post('unfavourite_business' , {
         "userId":  AppData().userdetail!.users_id,
         "businessId": businessId
      });
      await getNearbyBusiness(isReFresh: true);
      }
      else{
          res=    await DioService.post('favourite_business', {
         "userId":  AppData().userdetail!.users_id,
         "businessId": businessId
      });
           await getNearbyBusiness(isReFresh: true);
      }
         showErrorToast(res['data']);
         Navigator.of(context).pop();
      }
      catch(e){
       // showErrorToast(e.toString());
         Navigator.of(context).pop();
      }
    }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  }


  // Future getUserLocation({lat, long}) async {
  //     var currentLocation;
  //     try{
  //       // AppData().userLocation=UserLocation();
  //       currentLocation = await  Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  //       userCurrentLocation=currentLocation;
  //       print(userCurrentLocation.latitude);
  //       print(userCurrentLocation.longitude);
  //       placeMark= await placemarkFromCoordinates(userCurrentLocation.latitude, userCurrentLocation.longitude);
  //       AppData().userLocation    =  UserLocation(latitude: userCurrentLocation.latitude, longitude: userCurrentLocation.longitude,address: "${placeMark!.first.subLocality} ${placeMark!.first.locality}");
  //       print("Location is this ${AppData().userLocation!.address}");
  //       setState(() {});
  //   }
  //   catch(e){
  //     print("i am here");
  //     print(e.toString());
  //   }
  //        // }
  //
  // }

  Future likeEventPost(num eventPostId) async {
   openLoadingDialog(context, 'loading');
   try{
      await DioService.post('like_event', {
    "eventPostId": eventPostId,
    "userId": AppData().userdetail!.users_id
   });
     Navigator.of(context).pop();
   //  showSuccessToast(response['data']);
   }
   catch(e){
    Navigator.of(context).pop();
    showSuccessToast(e.toString());
  }
}

  Future unLikeEventPost(num eventPostId) async {
   openLoadingDialog(context, 'loading');
   try{
     await DioService.post('unlike_event', {
    "eventPostId": eventPostId,
    "userId": AppData().userdetail!.users_id
   });
     Navigator.of(context).pop();
    // showSuccessToast(response['data']);
  }
   catch(e){
    Navigator.of(context).pop();
    showSuccessToast(e.toString());
  }
}

  Future<bool>  getEventSearchBarFilter({bool isReFresh=false}) async {
    // await getUserLocation();
    bool isData = false;
    if(isReFresh) {
      eventCurrentOffset=0;
    }
    else{
      if(eventDetail.length >= eventTotalPosts){
        refreshController.loadNoData();
        return false;
      }
    }
      response = await DioService.post('event_search_bar_filter', {
        if(AppData().userLocation !=null)   "userLat":AppData().userLocation!.latitude,
        if(AppData().userLocation !=null)        "userLong":AppData().userLocation!.longitude,
        'offset': eventCurrentOffset.toString(),
        'userId':AppData().userdetail!.users_id,
        'searchFilter' : search
      });

    if (response['status'] == 'success') {
      var event = response['data'] as List;
      List<EventDetail> events = event.map<EventDetail>((e) => EventDetail.fromJson(e)).toList();
      events.map((e) => distance.add(Distance(long: e.locationLong!, lat: e.locationLat!))).toList();
      // events.sort((b,a)=>a.eventPostId!.compareTo(b.eventPostId!));
      print(events.first.title);
      if(isReFresh)  eventDetail = events;
      else eventDetail.addAll(events);
      print(events.length);
      eventCurrentOffset = eventCurrentOffset + 5;
      eventTotalPosts= response['total_posts'];
      isData = true;
      context.read<ProviderData>().getUnreadMessages;
      setState(() {});
      //  Navigator.of(context).pop();
      isResultAvailable=true;
      setState(() {});

    } else {
      setState(() {
        eventDetail.clear();
        message="No Result Available";
        print(response['message']);
        isData = false;
      });
    }
    return isData;
  }


  void getEventsTags() async {
      futureEventTagsModel = EventTagsService().get();
      await futureEventTagsModel!.then((value) {
        if(this.mounted){
          listOfTags = value.data!;
           setState(() {});
        }
      });

  }

  Future _selectDate(BuildContext context) async {
   showDatePicker(
    context: context,
    initialDate: selectedDate,
    initialDatePickerMode: DatePickerMode.day,
    firstDate: DateTime(2015),
    lastDate: DateTime(2101))
    .then((value)async {
    setState(() {
    selectedDate = value!;
    print(selectedDate);
    var dateFormat = DateFormat.yMMMd();
    final f = new DateFormat('yyyy-MM-dd');
    date = dateFormat.format(selectedDate);
    date1 = f.format(selectedDate);
    print(date1);
  });
   openLoadingDialog(context, "loading");
   await getEvents(isReFresh: true);
   Navigator.of(context).pop();
});

}

  void getEventType() async {
      futureEventTypeModel = EventTypeService().get();
      await futureEventTypeModel!.then((value) =>   setState(() => listOfEventType = value));
  }

  void getCities() async {
    final response = await http.get(Uri.parse("https://admin.connevents.com/api/get_event_cities"));
    var result = jsonDecode(response.body);
    if (result != null) {
    var data = result['data']['cities'] as List;
    List<City> detail = data.map<City>((e) => City.fromJson(e)).toList();
    setState(() {
      listOfCity = detail;
    });
    print(listOfCity.length);
  }
}


  Future<bool>  getNearbyBusiness({bool isReFresh=false}) async {
   // await getUserLocation();
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
    response = await DioService.post('business_search_filter', {
      if(AppData().userLocation !=null)
      "userLat":AppData().userLocation!.latitude,
      if(AppData().userLocation !=null)
     "userLong":AppData().userLocation!.longitude,
      'userId':AppData().userdetail!.users_id,
      'offset': businessCurrentOffset.toString(),
      if(city.isNotEmpty) "cityFilter": city,
      if(date1.isNotEmpty) "dateFilter": date1,
      if(event.eventTypeData != null) "eventTypeFilter": event.eventTypeData!.eventTypeId,
      if(event.category != null) "categoryFilter": event.category!.categoryId,
      if(search!=null) "titleFilter": search,
      if(tagsList.length > 0)       "tagsFilter":tagsList
    });

  if (response['status'] == 'success') {
    var event = response['data'] as List;
    List<Business> business = event.map<Business>((e) => Business.fromJson(e)).toList();
    business.map((e) => distance.add(Distance(long: e.businessLong!, lat: e.businessLong!))).toList();
   // business.sort((b,a)=>b.distanceMiles!.compareTo(a.distanceMiles!));
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
   //await getUserLocation();
    bool isData = false;
    if(isReFresh) {
      eventCurrentOffset=0;
    }
    else{
      if(eventDetail.length >= eventTotalPosts){
        refreshController.loadNoData();
        return false;
      }
    }
    if(isEvent) {
    response = await DioService.post('event_search_filter', {
      if(AppData().userLocation !=null)   "userLat":AppData().userLocation!.latitude,
      if(AppData().userLocation !=null)        "userLong":AppData().userLocation!.longitude,
      'offset': eventCurrentOffset.toString(),
      'userId':AppData().userdetail!.users_id,

    if(tagsList.length > 0)       "tagsFilter":tagsList
    });
    setState(() =>isEvent=false);
  }
   else {
    response = await DioService.post('event_search_filter', {
      if(AppData().userLocation !=null)
      "userLat":AppData().userLocation!.latitude,
      if(AppData().userLocation !=null)
     "userLong":AppData().userLocation!.longitude,
      'userId':AppData().userdetail!.users_id,
      'offset': eventCurrentOffset.toString(),
      if(city.isNotEmpty) "cityFilter": city,
      if(date1.isNotEmpty) "dateFilter": date1,
      if(event.eventTypeData != null) "eventTypeFilter": event.eventTypeData!.eventTypeId,
      if(event.category != null) "categoryFilter": event.category!.categoryId,
      if(search!=null) "titleFilter": search,
      if(tagsList.length > 0)       "tagsFilter":tagsList
    });


  }

   print(response);

  if (response['status'] == 'success') {
    var event = response['data'] as List;
     isBasic = response['is_basic'];

     if(this.mounted){
       List<EventDetail> events = event.map<EventDetail>((e) => EventDetail.fromJson(e)).toList();
       events.map((e) => distance.add(Distance(long: e.locationLong!, lat: e.locationLat!))).toList();
       // events.sort((b,a)=>a.eventPostId!.compareTo(b.eventPostId!));
       print(events.first.title);
       if(isReFresh)  eventDetail = events;
       else eventDetail.addAll(events);
       print(events.length);
       eventCurrentOffset = eventCurrentOffset + 5;
       eventTotalPosts= response['total_posts'];
       isData = true;
       context.read<ProviderData>().getUnreadMessages;
       setState(() {});
       //  Navigator.of(context).pop();
       isResultAvailable=true;
       setState(() {});
     }


  } else {
    setState(() {
      eventDetail.clear();
      message="No Result Available";
      print(response['message']);
      isData = false;
    });
  }
  return isData;
  }

  Future<File> getThumbnailPath(String url) async {
  await getTemporaryDirectory().then((d) => _tempDir = d.path);
  final thumb = await VideoThumbnail.thumbnailFile(
      video: url,
      thumbnailPath: _tempDir,
      imageFormat: ImageFormat.JPEG,
      quality: 80);
  final file = File(thumb!);
  return file;
}

  Future<bool>  checkConnectivity() async {
    hasInternet  = await  InternetConnectionChecker().hasConnection;
    setState(() {});
    return hasInternet;
    }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future<bool> isConnected = checkConnectivity();
    isConnected.then((value) {
    if(value){
      getEventType();
      getEventsTags();
    }
    else showErrorToast("Please Check Your Internet Connection");
  });
  // WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
  //     openLoadingDialog(context, "loading...");
  //
  //      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: globallightbg,
      body:Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: padding, horizontal: padding * 2),
              child: showSearchBar ? ShowSearchBar(
                     onSearch: (val){
                       search=val;
                       tapSearch();
                     },
                     onClose: (){
                       setState(() {
                      showSearchBar = !showSearchBar;
                    });
                },
              )
              : Container(
                height: 25,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                  CityDialogBox(
                    width: selectedSegment == 'nearby' ? 140: null,
                    city: (val) async{
                       city=val;
                       setState(() {});
                     if(selectedSegment == 'nearby')
                     await getNearbyBusiness(isReFresh: true);
                     else
                     await getEvents(isReFresh: true);
                      if(city.isNotEmpty){
                         Navigator.of(context).pop();
                         Navigator.of(context).pop();
                      }else Navigator.of(context).pop();
                    },
                  ),
                 if(selectedSegment == 'Events')
                  CategoriesButton(
                  onPressed: () =>_selectDate(context),
                  child: DateCategory(
                      date: date,
                      onTap:() =>showDate())),
                  if(selectedSegment == 'Events')
                CategoriesButton(
                  onPressed:(){
                  showDialog(
                  context: context,
                  builder: (BuildContext context) {
                  return StatefulBuilder(
                  builder: (context, setState){
                  return Dialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    child: Container(
                    height: 350,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                    child: Stack(
                       children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text("Select Categories", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),),),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 8),
                                Text("Select Event Type", style: TextStyle(fontSize: 18),),
                                SizedBox(height: 10,),
                                dropDownContainer(
                                  child: DropdownButton<EventTypes>(
                                    underline: Container(),
                                    isExpanded: true,
                                    iconEnabledColor: Colors.black,
                                    focusColor: Colors.black,
                                    hint: Text("Select Event Type"),
                                    icon: Icon(Icons.arrow_drop_down_rounded),
                                    items: listOfEventType?.event_types?.map((value) {
                                      return new DropdownMenuItem<EventTypes>(
                                        value: value,
                                        child: Text(value.eventType.toString()),
                                      );
                                    }).toList(),
                                    onChanged: (EventTypes? newValue){
                                      print(newValue);
                                      this.event.eventTypeData = newValue;
                                      event.category=null;
                                      setState(() {});
                                    },
                                    value: this.event.eventTypeData,
                                  ),
                          ),
                        SizedBox(height: 15),

                        Text("Select Category", style: TextStyle(fontSize: 18),),
                        SizedBox(height: 10,),
                        dropDownContainer(
                          child: DropdownButton<EventTypeCategories>(
                            underline: Container(),
                            isExpanded: true,
                            iconEnabledColor: Colors.black,
                            focusColor: Colors.black,
                            hint: Text("Select Category"),
                            icon: Icon(Icons.arrow_drop_down_rounded),
                            items: event.eventTypeData?.categories?.map((value) {
                              return new DropdownMenuItem<EventTypeCategories>(
                                value: value,
                                child: Text(value.category.toString()),
                              );
                            }).toList(),
                            onChanged: (newValue) => setState(() => event.category = newValue!),
                            value: event.category,
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.only(top: 9.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: globalGreen,
                          child: Text("GO", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                          onPressed:()async{
                            openLoadingDialog(context, "loading");
                                if(selectedSegment == 'nearby')
                            await getNearbyBusiness(isReFresh: true);
                            else
                           await  getEvents(isReFresh: true);
                           Navigator.of(context).pop();
                           Navigator.of(context).pop();
                          },
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                          ),
                        ),
                      ),
                    ),
                  ),

                  ],
                    )],
                    ),
                  ),
                    Positioned(
                      top: 5,
                      right: 5,
                      child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close, size: 35, color: globalGreen),
                      ),
                    ),
                        ]))
                        ); }
                    );

            });
            },
                  child: Row(
                  children: [
                  Text('Category', style: TextStyle(color: Colors.black, fontSize: 12)),
                  Padding(
                   padding: const EdgeInsets.only(left:4.0),
                   child: SvgPicture.asset('assets/icons/downArrow.svg', color: globalGreen, width: 10)),
                ],
                )),
                  Container(
                    width: selectedSegment == 'nearby' ? MediaQuery.of(context).size.width*0.37: null,
                    child: CategoriesButton(
                      onPressed: ()=> setState(() => showSearchBar = !showSearchBar),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right:4.0),
                            child: Text('Search', style: TextStyle(color: Colors.black, fontSize: 12)),
                          ),
                          SvgPicture.asset('assets/icons/search.svg', color: globalGreen, width: 10),
                        ],
                      ),
                    ),
                  ),
                 ]))),
            Expanded(
             child: SmartRefresher(
               controller: refreshController,
               enablePullUp: true,
               header: WaterDropHeader(),
               onRefresh: ()async{
                 final result;
                 if(selectedSegment == 'nearby')
                 result= await getNearbyBusiness(isReFresh: true);
                 else{
                   result= await getEvents(isReFresh: true);
                 }
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
            physics:NeverScrollableScrollPhysics(),
            child: Container(
              padding: EdgeInsets.only(left:padding * 2,right: padding * 2),
              decoration: BoxDecoration(color: globallightbg),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     isVisibleTags ? Expanded(
                       child: Visibility(
                         visible: isVisibleTags,
                         child: Wrap(
                           children: [
                             for (var i = 0; i < listOfTags.length; i++)
                               Wrap(
                                 children: [
                                   filterContainer(
                                      Checkbox(
                                       checkColor: Colors.transparent,
                                       fillColor: MaterialStateProperty.resolveWith((states) => globalGreen),
                                       value: listOfTags[i].isSelected,
                                         onChanged: (value) {
                                         filterEvents(listOfTags[i],value);
                                       },
                                     ),
                                   ),
                                   SizedBox(width: padding / 2),
                                   Text(listOfTags[i].tagName.toString(), style: TextStyle(height: 2, color: globalBlack, fontSize: 12,)),
                                   SizedBox(width: padding),
                                 ],
                               ),
                           ],
                         ),
                       ),
                     ):
                      Expanded(
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                          color: globalLightButtonbg,
                          borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: (selectedSegment == 'Events') ? BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: globalGreen),
                                  borderRadius: BorderRadius.circular(30))
                                  : BoxDecoration(),
                                  child: TextButton(
                                    onPressed: () => isSelectedEvents(),
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
                                  borderRadius: BorderRadius.circular(30))
                                  : BoxDecoration(),
                                  child: TextButton(
                                  onPressed: () => isSelectedBusiness(),
                                  child: Text("What's Nearby", style: TextStyle(color: Colors.black, fontSize: 12,
                                    ),
                                  )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                        SizedBox(width: padding),
                        if(selectedSegment == 'Events')
                        GestureDetector(
                          onTap: () {
                            if(isVisibleTags) setState(() => isVisibleTags=false);
                            else setState(()=> isVisibleTags=true);
                          },
                          child: SvgPicture.asset('assets/filter.svg', width: 22,
                          ),
                        ),
                      ],
                    ),
                  if(isVisibleTags && tagsList.isNotEmpty)
                  Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                          onTap:() async{
                            isVisibleTags=false;
                            tagsList.clear();
                            listOfTags.map((e) => e.isSelected=false).toList();
                            setState(() {});
                            openLoadingDialog(context, 'loading');
                            await  getEvents(isReFresh: true);
                            Navigator.of(context).pop();
                          },
                          child: Text("Clear Filter", style: TextStyle(color: Color(0xffF3960B),decoration: TextDecoration.underline,)))),
                  if(AppData().userLocation != null)
                  selectedSegment=="Events" ?
                  eventDetail.length > 0 ?
                  HomePageEvents(
                  //isShowPeeks: true,
                  isBasic: isBasic,
                  eventDetail: eventDetail,
                  onTapFavourite: (isFavourite,eventPostId)=>onFavouriteEvent(isFavourite,eventPostId),
                  onTapEnableLocation: ()  async {
                  openLoadingDialog(context, "loading");
                  await    getEvents(isReFresh: true);
                  Navigator.of(context).pop();
                  },
                  isLiked: (isLiked,eventPostId) => onLiked(isLiked,eventPostId),
                  ):
                  noResultAvailableMessage(message,context):
                  businessDetail.length > 0 ?
                  NearbyBusinessPage(
                  business: businessDetail,
                  onTapFavourite: (isFavourite,businessId)=>onFavouriteBusiness(isFavourite,businessId),

                  ):noResultAvailableMessage(message,context)
                  else  Container(
                    height: MediaQuery.of(context).size.height*0.8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                              var permission  = await Geolocator.requestPermission();
                                count++;
                             if(permission== LocationPermission.deniedForever && count == 2){
                              var permission  = await Geolocator.openAppSettings();
                            }
                            if(permission == LocationPermission.whileInUse || permission== LocationPermission.always){
                              count=0;
                              openLoadingDialog(context , "loading");
                              await    getEvents(isReFresh: true);
                              Navigator.of(context).pop();
                            }

                        },
                          child: Text("Enable Location")),
                      ],
                    ),
                  )

                ],
              ),
            ),
          ),
        ),
      )

          ],
        ),
      )
    );
  }
}
