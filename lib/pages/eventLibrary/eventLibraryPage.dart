import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/create-event-model.dart';
import 'package:connevents/models/event-type-model.dart';
import 'package:connevents/pages/eventGallery/eventGalleryPage.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/services/event-type-service.dart';
import 'package:connevents/utils/fonts.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class EventLibraryPage extends StatefulWidget {
  const EventLibraryPage({Key? key}) : super(key: key);

  @override
  State<EventLibraryPage> createState() => _EventLibraryPageState();
}

class _EventLibraryPageState extends State<EventLibraryPage> {


  int currentOffset=0;
  int totalPosts=0;
  var response;
  String message="";
  EventTypes? eventTypes ;
  RefreshController refreshController=RefreshController(initialRefresh: true);

  EventTypeList? listOfEventType;
  List<EventTypeCategories> listOfCategoryEvents = [];
  Future<EventTypeList>? futureEventTypeModel;
  Future<EventTypeCategories>? futureCategoryModel;
  bool isAll=false;
  List<EventDetail> eventDetail=[];
  bool isBasic=false;


  void getEventType() async {
    futureEventTypeModel = EventTypeService().get();
    await futureEventTypeModel!.then((value) =>   setState(() => listOfEventType = value));
     await getEventLibrary();
    Navigator.of(context).pop();
  }

  Future<bool>  getEventLibrary( {bool isReFresh = false , eventTypeId}) async {
    print(eventTypeId);
    bool isData = false;
    try{
      if(isReFresh) currentOffset=0;
      else{
        if(currentOffset > totalPosts){
          refreshController.loadNoData();
          return false;
        }
      }
      response = await DioService.post('get_event_library_list', {
        "usersId": AppData().userdetail!.users_id,
        if(eventTypeId !=null)
        "eventTypeFilter": eventTypeId,
      });
      print(response);
      if(response['status']=='success'){
      var event = response['data'] as List;
      isBasic=response['is_basic'];
      eventDetail = event.map<EventDetail>((e) => EventDetail.fromJson(e)).toList();
      setState(() {});
      }
      else if(response['status']=='error'){
          eventDetail.clear();
          // showErrorToast(response['message']);
          message='No Event Found';
          setState(() {});

    }
    }
    catch (e){
      showErrorToast(response['message']);
    }

    return isData;
  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        openLoadingDialog(context, "loading");
        getEventType();

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
                Navigator.pop(context);
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
            padding: EdgeInsets.only(left:padding * 2,right:padding * 2,bottom: padding * 2,top:20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Event Catalog', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: globalBlack)),
                SizedBox(height: padding),
                Text('Event Type', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: globalBlack)),
                SizedBox(height: padding),
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
                    onChanged: (EventTypes? newValue) async {
                      print(newValue);
                      eventTypes = newValue;
                      openLoadingDialog(context, "loading");
                      await  getEventLibrary(isReFresh: true,eventTypeId : eventTypes!.eventTypeId);
                      Navigator.of(context).pop();
                      // Navigator.of(context).pop();
                      setState(() {});
                    },
                    value: eventTypes,
                  ),
                ),
                SizedBox(height: padding),
                eventDetail.length > 0 ?
                   ListView.builder(
                     physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: eventDetail.length,
                    itemBuilder: (context,index){
                       return
                         GestureDetector(
                        onTap: () {
                          //isBasic  ?  showErrorToast('You need to upgrade on premium account') :
                          CustomNavigator.navigateTo(context, EventGalleryPage(
                            eventDetail: eventDetail[index],
                            eventPostId: eventDetail[index].eventPostId,
                            isCheckIn: eventDetail[index].userCheckedIn,
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
                              Text(eventDetail[index].title, style: TextStyle(color: globalBlack, fontSize: 18)),
                              SizedBox(height: padding / 3),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset('assets/icons/calendarSmall.svg'),
                                      SizedBox(width: padding / 2),
                                      Text(eventDetail[index].eventStartDate),
                                      SizedBox(width: padding),
                                      SvgPicture.asset('assets/icons/clock.svg'),
                                      SizedBox(width: padding / 2),
                                      Text(eventDetail[index].eventStartTime),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Text(message,style: gilroyBoldRed),
                      )),
                    ],
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dropDownContainer({required Widget child}) {
    return Container(
      height: 50,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: globalLGray,
            blurRadius: 3,
          )
        ],
      ),
      child: child,
    );
  }
}
