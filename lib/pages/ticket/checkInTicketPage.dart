import 'dart:math';

import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/event-guest-list-model.dart';
import 'package:connevents/pages/ticket/ticketPageAlerts.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:ticketview/ticketview.dart';

class CheckInTicketPage extends StatefulWidget {
  bool fromEventGuestList;
 final EventGuestList? eventGuest;

  CheckInTicketPage({Key? key, this.fromEventGuestList=false,this.eventGuest}) : super(key: key);

  @override
  State<CheckInTicketPage> createState() => _CheckInTicketPageState();
}

class _CheckInTicketPageState extends State<CheckInTicketPage> {


   Future scanCode() async {
   openLoadingDialog(context, 'loading');
   try{
     var response = await DioService.post('checkin', {
       "ticketUniqueNumber": widget.eventGuest!.ticketUniqueNumber,
       'usersId':AppData().userdetail!.users_id
     });
     Navigator.of(context).pop();

     if(response['status']=='success'){
       widget.eventGuest!.isCheckedIn=true;
       showSuccessToast(response['data']);
       Navigator.of(context).pop();
     }
     else {
       showSuccessToast(response['message']);
     }
   }
   catch(e){
     Navigator.of(context).pop();
     //showSuccessToast(e.toString());
   }
 }

  final List<Marker>  markers=[];
   late LatLng latLng;

    addMarker(double lat, double long){
     int id=Random().nextInt(100);
     setState(() {
     markers.add(Marker(position: LatLng(lat,long) , markerId: MarkerId(id.toString())));
   });
   }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   addMarker(widget.eventGuest!.locationLat!,widget.eventGuest!.locationLong!);
  //   latLng = LatLng(widget.eventGuest!.locationLat!,widget.eventGuest!.locationLong!);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: globallightbg,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Row(
            children: [
              Icon(Icons.chevron_left, color: globalGreen),
              Text('Back', style: TextStyle(color: globalGreen, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(padding * 2),
        decoration: BoxDecoration(color: globallightbg),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Container(
                            padding: EdgeInsets.only(top: 35, bottom: 10),
                            child: Column(
                              children: [
                                Container(
                                  height:509,
                                  decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: globalLGray.withOpacity(0.5),
                                      blurRadius: 5,
                                    )
                                  ]),
                                  clipBehavior: Clip.antiAlias,
                                  child: TicketView(
                                    backgroundColor: Colors.transparent,
                                    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                                    triangleAxis: Axis.vertical,
                                    drawArc: true,
                                    drawTriangle: true,
                                    drawBorder: true,
                                    drawDivider: true,
                                    dividerColor: globalLGray,
                                    drawShadow: false,
                                    trianglePos: .5,
                                    borderRadius: 0.1,
                                    triangleSize: Size(40, 20),
                                    child: Container(
                                      color:widget.eventGuest!.ticket=="VIP" || widget.eventGuest!.ticket=='Skipping Line'  ?  Colors.orange: Colors.white,

                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              padding: EdgeInsets.only(bottom: padding, top: padding * 3),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: padding),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(widget.eventGuest!.userName!, style: TextStyle(color:widget.eventGuest!.ticket=="VIP" || widget.eventGuest!.ticket=='Skipping Line'?Colors.white : globalBlack, fontSize: 14, fontWeight: FontWeight.w700,)),
                                                        Text(widget.eventGuest!.title!, style: TextStyle(color:widget.eventGuest!.ticket=="VIP" || widget.eventGuest!.ticket=='Skipping Line' ? Colors.white: globalBlack, fontSize: 14, fontWeight: FontWeight.w700,),),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: padding / 2, horizontal: padding),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            SvgPicture.asset('assets/icons/calendarSmall.svg', width: 10, height: 10),
                                                            SizedBox(width: padding / 2),
                                                            Text(widget.eventGuest!.eventStartDate!, style: TextStyle(color: widget.eventGuest!.ticket=="VIP" || widget.eventGuest!.ticket=='Skipping Line'? Colors.white: globalBlack,fontSize: 14, fontWeight: FontWeight.w700,)),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            SvgPicture.asset('assets/icons/clock.svg', width: 10, height: 10),
                                                            SizedBox(width: padding / 2),
                                                            Text(widget.eventGuest!.eventStartTime!, style: TextStyle(color: widget.eventGuest!.ticket=="VIP" || widget.eventGuest!.ticket=='Skipping Line'? Colors.white: globalBlack, fontSize: 14, fontWeight: FontWeight.w700),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                   Container(
                                                     padding: EdgeInsets.all(padding / 2),
                                                     child: Image.asset('assets/imgs/map.png', fit: BoxFit.cover)),
                                                 if(widget.eventGuest!.ticket !=null)
                                                 Text('${widget.eventGuest!.ticket!} (${widget.eventGuest!.quantity}) ', style: TextStyle(color:widget.eventGuest!.ticket=="VIP" || widget.eventGuest!.ticket=='Skipping Line' ?Colors.white: globalBlack, fontSize: 14, fontWeight: FontWeight.w700,)),

                                                ],
                                              ),
                                            ),
                                          ),
                                           if(widget.eventGuest!.ticketUniqueNumber!=null)
                                           Container(
                                                color:widget.eventGuest!.ticket=="VIP" || widget.eventGuest!.ticket=='Skipping Line' ?  Colors.orange :Colors.white,
                                                 height: 220,
                                                 child: SfBarcodeGenerator(
                                                   barColor:widget.eventGuest!.ticket=="VIP" || widget.eventGuest!.ticket=='Skipping Line' ? Colors.white:globalBlack,
                                                   textStyle: TextStyle(color:widget.eventGuest!.ticket=="VIP" || widget.eventGuest!.ticket=='Skipping Line' ?Colors.white:Colors.black),
                                                   textSpacing: 12,
                                                   value: widget.eventGuest!.ticketUniqueNumber!,
                                                   symbology: QRCode(),
                                                   showValue: true,
                                                 ),
                                               ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            child: SvgPicture.asset('assets/icons/tick.svg', width: 86, height: 86),
                            top: 0,
                            right: 0,
                            left: 0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            widget.fromEventGuestList ?
            SizedBox(
              width: double.infinity,
              height: 40,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor:widget.eventGuest!.isCheckedIn! ? Colors.red : globalGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  if(!widget.eventGuest!.isCheckedIn!)
                       scanCode();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text( widget.eventGuest!.isCheckedIn! ? 'Checked In' :  'CHECK IN', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            )
           : Container(
                height: 50,
                width: MediaQuery.of(context).size.width/1.2,
                child: TextButton(
                  onPressed: () async{
                    await  showDialog(
                          context: context,
                          builder: (BuildContext context) {
                          return RequestRefundAlert(
                            eventGuest: widget.eventGuest,
                          );
                        });
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Request Refund'.toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
