import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/event-address-model.dart';
import 'package:connevents/models/event-dummy-ticket.dart';
import 'package:connevents/models/event-type-model.dart';
import 'package:connevents/models/ticket-history-model.dart';
import 'package:connevents/pages/home/no-result-available-message.dart';
import 'package:connevents/pages/salesDetails/salesDetailsPage.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/services/event-type-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:flutter/material.dart';
import 'package:connevents/models/create-event-model.dart';
import 'package:flutter_svg/flutter_svg.dart';


class EventDashboard extends StatefulWidget {
  const EventDashboard({Key? key}) : super(key: key);

  @override
  State<EventDashboard> createState() => _EventDashboardState();
}

class _EventDashboardState extends State<EventDashboard> {

    EventDetail  event = EventDetail(  vip: VIP(), earlyBird: EarlyBird(),regular: Regular(), eventAddress: EventAddress(),skippingLine: SkippingLine());

  List<EventDetail> events=[];
  EventTypeList? listOfEventType;
  List<EventTypeCategories> listOfCategoryEvents = [];
  Future<EventTypeList>? futureEventTypeModel;
  Future<EventTypeCategories>? futureCategoryModel;
  bool isAll=false;
  var response;
  String message="";
  String selectedSegment="";
  List<TicketHistoryList> ticketHistoryList=[];
  EventTypes? selectedEventType;


  void getEventType() async {
  futureEventTypeModel = EventTypeService().get();
  await futureEventTypeModel!.then((value) =>   setState(() => listOfEventType = value));
  }

    void ticketHistory({selected, eventTpe}) async {
      final response = await DioService.post('ticket_history', {
        "usersId": AppData().userdetail!.users_id,
        "historyType" : selected == "Upcoming Events" ?  "upcomming" : "previous",
        if(eventTpe!=null)   "eventTypeFilter": eventTpe
      });
      print(response);
      Navigator.of(context).pop();
      if(response['status']=="success"){
        var history= response['data'] as List;
        ticketHistoryList= history.map<TicketHistoryList>((e) => TicketHistoryList.fromJson(e)).toList();
        setState(() {});
        print(response);
      }
      else if(response['status']=="error"){
        message='No Tickets Found. Create your events today';
        setState(() {});
      }

    }


  Future  getEvents() async {
    var  response = await DioService.post('user_event_type_posts', {
        "userId": AppData().userdetail!.users_id,
        if(event.eventTypeData !=null)
        "eventTypeFilter": event.eventTypeData!.eventTypeId,
      });

    print(response);
    if (response['status'] == 'success') {
      var event = response['data'] as List;
       events = event.map<EventDetail>((e) => EventDetail.fromJson(e)).toList();
      setState(() {});
    } else if(response['status'] == 'error'){
      events.clear();
      setState(() {
      message="No Post Created Yet";
      });
    }
}




    @override
  void initState() {
    super.initState();
    selectedSegment = 'Previous Events';
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        openLoadingDialog(context, "loading");
        getEvents();
        getEventType();
        ticketHistory(selected: selectedSegment);
        getEventType();
         });

  }
  void dispose() {

   super.dispose();
 }
 @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppData().userdetail!.user_name!, style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: globalBlack,)),
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
                      onChanged: (EventTypes?newValue) async {
                        print(newValue);
                        this.event.eventTypeData = newValue;
                        openLoadingDialog(context, "loading");
                             await  getEvents();
                             setState(() {});
                      },
                      value: this.event.eventTypeData,
                    ),
             ),
            ],
          ),
        ),
          SizedBox(height: padding * 2),
          if(events.length>0)
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: events.length,
              itemBuilder: (context,index){
                return GestureDetector(
                  onTap: () {
                    CustomNavigator.navigateTo(context, SalesDetailsPage(
                      event: events[index],
                    ));
                  },
                  child: Container(
                    padding: EdgeInsets.only(bottom: padding / 3),
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
                        Text(events[index].title,style: TextStyle(color: globalBlack, fontSize: 18),
                        ),
                        SizedBox(height: padding / 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset('assets/icons/calendarSmall.svg'),
                                SizedBox(width: padding / 2),
                                Text(events[index].eventStartDate),
                                SizedBox(width: padding),
                                SvgPicture.asset('assets/icons/clock.svg'),
                                SizedBox(width: padding / 2),
                                Text(events[index].eventStartTime),
                              ],
                            ),
                            Icon(Icons.chevron_right, color: globalLGray),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
          // : Column(
          //   children: [
          //     Center(child: Text(message,style: gilroyBoldRed)),
          //   ],
          // ),

        Column(
          children: [
            SizedBox(height: padding ),
            Text('Purchased Tickets', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.green)),
            SizedBox(height: padding ),
            Container(
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
                      decoration: (selectedSegment == 'Previous Events')
                          ? BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: globalGreen),
                        borderRadius: BorderRadius.circular(30),
                      )
                          : BoxDecoration(),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            selectedSegment = 'Previous Events';
                            ticketHistoryList.clear();
                            openLoadingDialog(context, 'loading');
                            ticketHistory(selected: selectedSegment);
                          });
                        },
                        child: Text('Previous Events', style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: (selectedSegment == 'Upcoming Events')
                          ? BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: globalGreen),
                        borderRadius: BorderRadius.circular(30),
                      )
                          : BoxDecoration(),
                      child: TextButton(
                          onPressed: () {
                            setState(() {
                              selectedSegment = 'Upcoming Events';
                              openLoadingDialog(context, 'loading');
                              ticketHistoryList.clear();
                              ticketHistory(selected: selectedSegment);
                            });
                          },
                          child: Text('Upcoming Events', style: TextStyle(color: Colors.black, fontSize: 12))),
                    ),
                  ),
                ],
              ),
            ),
            // SizedBox(height: padding),
            // Text('Event Type', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: globalBlack)),
            //  SizedBox(height: padding),
            // dropDownContainer(
            //   child: DropdownButton<EventTypes>(
            //         underline: Container(),
            //         isExpanded: true,
            //         iconEnabledColor: Colors.black,
            //         focusColor: Colors.black,
            //         hint: Text("Select Event Type"),
            //         icon: Icon(Icons.arrow_drop_down_rounded),
            //         items: listOfEventType?.event_types?.map((value) {
            //           return new DropdownMenuItem<EventTypes>(
            //             value: value,
            //             child: Text(value.eventType.toString()),
            //           );
            //         }).toList(),
            //         onChanged: (EventTypes? newValue){
            //           selectedEventType = newValue;
            //           setState(() {});
            //           ticketHistoryList.clear();
            //           openLoadingDialog(context, 'loading');
            //           ticketHistory(selected: selectedSegment,eventTpe: selectedEventType!.eventTypeId);
            //         },
            //         value: selectedEventType,
            //       )),

            ticketHistoryList.isNotEmpty?
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: ticketHistoryList.length,
                  itemBuilder:(context,index){
                    TicketHistoryList ticket =ticketHistoryList[index];
                    return Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:20.0),
                            child: Text(ticket.eventTitle! , style: TextStyle(color: globalBlack, fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(height: padding / 2),
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    SvgPicture.asset('assets/icons/calendarSmall.svg',width: 10),
                                    SizedBox(width: padding / 2),
                                    Text(ticket.purchaseDate!, style: TextStyle(color: globalBlack, fontSize: 14, fontWeight: FontWeight.bold)),
                                    SizedBox(width: padding),
                                    SvgPicture.asset('assets/icons/clock.svg', width: 10),
                                    SizedBox(width: padding / 2),
                                    Text(ticket.purchaseTime!, style: TextStyle(color: globalBlack, fontSize: 14, fontWeight: FontWeight.bold))
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset('assets/icons/tag.svg', width: 10),
                                  SizedBox(width: padding / 2),
                                  Text('\$${ticket.amount}', style: TextStyle(color: globalBlack, fontSize: 14, fontWeight: FontWeight.bold)),
                                  SizedBox(width: padding),
                                  Icon(Icons.chevron_right, color: globalLGray),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: padding / 2),
                          Container(
                            margin: EdgeInsets.only(bottom: padding * 2),
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(color: globalLGray, blurRadius: 5),
                              ],
                            ),
                            child: Image.asset('assets/imgs/map.png', fit: BoxFit.cover),
                          ),
                        ],
                      ),
                    );
                  }):
            Padding(
              padding: const EdgeInsets.only(bottom:50.0),
              child: noResultAvailableMessage(message,context),
            )
          ],
        ),




      ],
    );
  }
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