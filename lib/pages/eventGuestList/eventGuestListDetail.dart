import 'package:connevents/models/event-guest-list-model.dart';
import 'package:connevents/pages/home/no-result-available-message.dart';
import 'package:connevents/pages/ticket/checkInTicketPage.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EventGuestListDetail extends StatefulWidget {
  final  List<EventGuestList>? eventGuest;
  final String message;
  const EventGuestListDetail({Key? key,this.eventGuest,this.message=''}) : super(key: key);

  @override
  _EventGuestListDetailState createState() => _EventGuestListDetailState();
}

class _EventGuestListDetailState extends State<EventGuestListDetail> {
  @override
  Widget build(BuildContext context) {
    return  widget.eventGuest!.isNotEmpty ? ListView.builder(
          physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.eventGuest!.length,
            itemBuilder: (context,index){
            EventGuestList guest=widget.eventGuest![index];
              return   Container(
                padding: EdgeInsets.only(left: padding * 2, right: padding),
                child: Column(
                  children: [
                      GestureDetector(
                        onTap: () {
                          CustomNavigator.navigateTo(context, CheckInTicketPage(
                            fromEventGuestList: true,
                            eventGuest: guest,
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(guest.ticketUniqueNumber!, style: TextStyle(color: globalBlack, fontSize: 18)),
                                  Text(guest.ticket!, style: TextStyle(color: globalBlack, fontSize: 18)),
                                ],
                              ),
                              SizedBox(height: padding / 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SvgPicture.asset('assets/icons/calendarSmall.svg'),
                                      SizedBox(width: padding / 2),
                                      Text(guest.purchaseDate!),
                                      SizedBox(width: padding),
                                      SvgPicture.asset('assets/icons/clock.svg'),
                                      SizedBox(width: padding / 2),
                                      Text(guest.purchaseTime!),
                                    ],
                                  ),
                                  Icon(Icons.chevron_right, color: globalLGray),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              );


                    }) :
    Center(child: noResultAvailableMessage(widget.message,context));
  }
}
