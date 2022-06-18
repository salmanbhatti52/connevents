import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/create-event-model.dart';
import 'package:connevents/pages/home/no-result-available-message.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/connevent-appbar.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'bookRoomPage.dart';

class EventsRoomPage extends StatefulWidget {
  const EventsRoomPage({Key? key}) : super(key: key);

  @override
  State<EventsRoomPage> createState() => _EventsRoomPageState();
}

class _EventsRoomPageState extends State<EventsRoomPage> {
  String message='';

   List<EventDetail>  events=[];

   Future  getEventsRooms() async {
    var   response = await DioService.post('host_room_event_posts', {
        "userId": AppData().userdetail!.users_id,
      });
    Navigator.of(context).pop();
    print(response);
    if (response['status'] == 'success') {
      var event = response['data'] as List;
       events = event.map<EventDetail>((e) => EventDetail.fromJson(e)).toList();
       setState(() {});
    } else if(response['status'] == 'error'){
      message='You have no events scheduled at the moment';
      setState(() {});
      // showErrorToast(response['message']);
    }
}


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        openLoadingDialog(context, "loading");
            getEventsRooms();
         });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: globallightbg,
      appBar: ConneventAppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left:padding * 2,right:padding * 2,bottom: padding * 2,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: Text(AppData().userdetail!.user_name!, style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: globalBlack,)),
                      ),
                      SizedBox(height: padding),
                      if(events.isNotEmpty)
                      Text('Select Event to Create Host Room', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: globalBlack))

                    ],
                  ),
                ),
                SizedBox(height: padding * 2),
                events.isNotEmpty ?
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: events.length,
                  itemBuilder: (context,index){
                   EventDetail event=events[index];
                  return  GestureDetector(
                    onTap: () =>CustomNavigator.navigateTo(context, BookRoomPage(
                      eventPostId: event.eventPostId,
                    )),
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
                          Text(event.title, style: TextStyle(color: globalBlack, fontSize: 18)),
                          SizedBox(height: padding / 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset('assets/icons/calendarSmall.svg'),
                                  SizedBox(width: padding / 2),
                                  Text(event.eventStartDate),
                                  SizedBox(width: padding),
                                  SvgPicture.asset('assets/icons/clock.svg'),
                                  SizedBox(width: padding / 2),
                                  Text(event.eventStartTime),
                                ],
                              ),
                              Icon(Icons.chevron_right,color: globalLGray),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }):
                Center(child: noResultAvailableMessage(message,context))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
