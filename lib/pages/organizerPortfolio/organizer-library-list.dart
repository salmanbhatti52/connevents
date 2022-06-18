import 'package:connevents/models/event-address-model.dart';
import 'package:connevents/models/event-dummy-ticket.dart';
import 'package:connevents/models/event-type-model.dart';
import 'package:connevents/pages/eventGallery/eventGalleryPage.dart';
import 'package:connevents/pages/organizerPortfolio/organizer-event-gallery.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/services/event-type-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:connevents/widgets/drop-down-container.dart';
import 'package:flutter/material.dart';
import 'package:connevents/models/create-event-model.dart';
import 'package:flutter_svg/svg.dart';

class OrganizerLibraryList extends StatefulWidget {
   EventDetail? eventDetail;
   OrganizerLibraryList({Key? key,this.eventDetail}) : super(key: key);

  @override
  _OrganizerLibraryListState createState() => _OrganizerLibraryListState();
}

class _OrganizerLibraryListState extends State<OrganizerLibraryList> {

    List<EventDetail> eventDetail=[];
   String message = "No Event Found";
   String selectedSegment="";
   EventTypeList? listOfEventType;
   Future<EventTypeList>? futureEventTypeModel;

     EventDetail  event = EventDetail(  vip: VIP(), earlyBird: EarlyBird(),regular: Regular(), eventAddress: EventAddress(),skippingLine: SkippingLine());

     Future getOrganizerEventLibrary() async {
    var  response;
    try{
       response = await DioService.post('organizer_portfolio', {
        "usersId": widget.eventDetail!.usersId,
         if(event.eventTypeData !=null)
        "eventTypeFilter": event.eventTypeData!.eventTypeId,
      });
       Navigator.of(context).pop();
      print(response);
      if(response['status']=='success'){
          var event = response['data'] as List;
          eventDetail = event.map<EventDetail>((e) => EventDetail.fromJson(e)).toList();
          setState(() {});}
          else if(response['status']=='error'){
          eventDetail.clear();
          showErrorToast(response['message']);
          setState(() {});
    }
    }
    catch (e){
      showErrorToast(response['message']);
    }}

      void getEventType() async {
        futureEventTypeModel = EventTypeService().get();
        await futureEventTypeModel!.then((value) =>   setState(() => listOfEventType = value));
        }



     @override
  void initState() {
    // TODO: implement initState
    super.initState();
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      openLoadingDialog(context, "loading...");
      getOrganizerEventLibrary();
      getEventType();
       });
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Padding(
            padding: const EdgeInsets.only(top:12.0,bottom:12),
            child: Text('${widget.eventDetail!.organizerUserName} Portfolio', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: globalBlack)),
          ),
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
                        onChanged: (EventTypes?newValue) async {
                          print(newValue);
                          this.event.eventTypeData = newValue;
                          openLoadingDialog(context, "loading");
                           await  getOrganizerEventLibrary();
                           setState(() {});
                        },
                        value: this.event.eventTypeData,
                      ),
               ),
            SizedBox(height: padding),
            SizedBox(height: padding),
            eventDetail.length > 0 ?
             ListView.builder(
               physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: eventDetail.length,
              itemBuilder: (context,index){
                return  GestureDetector(
                  onTap: () {
                    CustomNavigator.navigateTo(context, OrganizerEventGalleryPage(
                      eventDetail:eventDetail[index],
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
                  child: Text(message,style: TextStyle(color: Color(0xffF44336),fontSize: 24)),
                )),
              ],
            )
            ],
          ),
    );
  }
}
