import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/event-guest-list-model.dart';
import 'package:connevents/models/event-type-model.dart';
import 'package:connevents/pages/home/no-result-available-message.dart';
import 'package:connevents/pages/ticket/checkInTicketPage.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/services/event-type-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/connevent-appbar.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TicketLibraryPage extends StatefulWidget {
  const TicketLibraryPage({Key? key}) : super(key: key);
  @override
  _TicketLibraryPageState createState() => _TicketLibraryPageState();
}

class _TicketLibraryPageState extends State<TicketLibraryPage> {

    String message="";
    Future<EventTypeList>? futureEventTypeModel;
    EventTypeList? listOfEventType;
    EventTypes? selectedEventType;

    List<EventGuestList> purchasedTicketsForRefund=[];


    Future myPurchasedTickets() async {

      try{
        var response = await DioService.post('my_purchased_tickets_for_refund', {
          "usersId": AppData().userdetail!.users_id,
        });
        Navigator.of(context).pop();
        if(response['status']=='success'){
          var guest = response['data'] as List;
          purchasedTicketsForRefund = guest.map<EventGuestList>((e) => EventGuestList.fromJson(e)).toList();
          setState(() {});
        } else if(response['status']=='error'){
          message="No Ticket found. Get your ticket in home page ";
          setState(() {});
          //  showErrorToast(response['message']);
        }
      }
      catch(e){
        Navigator.of(context).pop();
      }
    }



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
   myPurchasedTickets();
   getEventType();
     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ConneventAppBar(),
      body: Container(
        decoration: BoxDecoration(color: globallightbg),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.only(left:padding * 2,right:padding * 2,bottom: padding * 2,top:20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ticket Library', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: globalBlack)),
                SizedBox(height: padding),
                purchasedTicketsForRefund.isNotEmpty ?
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: purchasedTicketsForRefund.length,
                    itemBuilder: (context,index){
                      return GestureDetector(
                        onTap: () =>CustomNavigator.navigateTo(context, CheckInTicketPage(
                          fromEventGuestList: false,
                          eventGuest: purchasedTicketsForRefund[index],
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
                              Text(purchasedTicketsForRefund[index].title!,style: TextStyle(color: globalBlack, fontSize: 18)),
                              SizedBox(height: padding / 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset('assets/icons/calendarSmall.svg'),
                                      SizedBox(width: padding / 2),
                                      Text(purchasedTicketsForRefund[index].purchaseDate!),
                                      SizedBox(width: padding),
                                      SvgPicture.asset('assets/icons/clock.svg'),
                                      SizedBox(width: padding / 2),
                                      Text(purchasedTicketsForRefund[index].purchaseTime!),
                                    ],
                                  ),
                                  if(purchasedTicketsForRefund[index].ticket !=null)
                                    Text('${purchasedTicketsForRefund[index].ticket!} (${purchasedTicketsForRefund[index].quantity}) ', style: TextStyle(color:purchasedTicketsForRefund[index].ticket=="VIP" || purchasedTicketsForRefund[index].ticket=='Skipping Line' ?Colors.black: globalBlack, fontSize: 14, fontWeight: FontWeight.w700,)),
                                  Icon(Icons.chevron_right, color: globalLGray),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }):noResultAvailableMessage(message,context)


              ],
            ),
          ),
        ),
      ),
    );
  }


    Widget dropDownContainer({required Widget child}) {
    return Container(
      height: 60,
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
