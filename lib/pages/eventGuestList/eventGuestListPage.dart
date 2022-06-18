import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/event-guest-list-model.dart';
import 'package:connevents/pages/eventGuestList/eventGuestListDetail.dart';
import 'package:connevents/pages/ticket/checkInTicketPage.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/connevent-appbar.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EventGuestListPage extends StatefulWidget {
  const EventGuestListPage({Key? key}) : super(key: key);

  @override
  State<EventGuestListPage> createState() => _EventGuestListPageState();
}

class _EventGuestListPageState extends State<EventGuestListPage> {


   List<EventGuestList> eventGuest=[];
   String message='';

   Future searchFilter({String? title}) async {
     eventGuest.clear();
    try{
      var response = await DioService.post('event_guests_list', {
        "usersId": AppData().userdetail!.users_id,
        if(title!=null)
        "searchFilter": title,
      });
         if(response['status']=='success'){
          var guest = response['data'] as List;
          eventGuest = guest.map<EventGuestList>((e) => EventGuestList.fromJson(e)).toList();
          setState(() {});
      } else if(response['status']=='error'){
      //    showErrorToast(response['message']);
      }
    }
    catch(e){
      print("shahzaib");
    }
  }

   Future getEventGuestList() async {
         openLoadingDialog(context, "loading");
    try{
      var response = await DioService.post('event_guests_list', {
        "usersId": AppData().userdetail!.users_id,
      });
          Navigator.of(context).pop();
         if(response['status']=='success'){
          var guest = response['data'] as List;
          if(this.mounted){
           eventGuest = guest.map<EventGuestList>((e) => EventGuestList.fromJson(e)).toList();
          setState(() {});
          }

      } else if(response['status']=='error'){
         message  ='No Guests Found';
         setState(() {});
      }
    }
    catch(e){
      print("shahzaib");
      Navigator.of(context, rootNavigator: true).pop();
    }
  }


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getEventGuestList();
       });
     }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: globallightbg,
      appBar: ConneventAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(bottom:20.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left:padding * 2, right: padding * 2,bottom: padding * 2,top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Event Guests List', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: globalBlack)),
                      SizedBox(height: padding),
                      Container(
                        height: 44,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: globalLGray,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: TextFormField(
                          onChanged: (value){
                            if(value.isEmpty){
                              searchFilter();
                            }
                            else{
                            searchFilter(title:  value);
                            setState(() {});
                            }
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search Username or Ticket Code',
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                EventGuestListDetail(eventGuest: eventGuest,message: message)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
