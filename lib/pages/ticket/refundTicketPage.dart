import 'dart:math';
import 'dart:typed_data';
import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/create-event-model.dart';
import 'package:connevents/models/event-guest-list-model.dart';
import 'package:connevents/models/purchased-ticket.dart';
import 'package:connevents/pages/tabs/tabsPage.dart';
import 'package:connevents/pages/ticket/ticketPageAlerts.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:ticketview/ticketview.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class RefundTicketPage extends StatefulWidget {
  final EventGuestList? eventGuest;
 final PurchasedTicket? purchasedData;
 final EventDetail? event;
 final String? totalAmount;
   RefundTicketPage({Key? key,this.event,this.eventGuest,this.totalAmount,this.purchasedData}) : super(key: key);

  @override
  State<RefundTicketPage> createState() => _RefundTicketPageState();
}

class _RefundTicketPageState extends State<RefundTicketPage> {
  ScreenshotController screenshotController = ScreenshotController();
  int _counter = 0;
  Uint8List? _imageFile;
  final GlobalKey<State<StatefulWidget>> _printKey = GlobalKey();
  final GlobalKey<State<StatefulWidget>> _printKey1 = GlobalKey();
  final GlobalKey<State<StatefulWidget>> _printKey2 = GlobalKey();


  void _printScreen(index) {
    Printing.layoutPdf(onLayout: (PdfPageFormat format) async {
      final doc = pw.Document();
      final image = await WidgetWraper.fromKey(
        key:index==0 ? _printKey : index==1 ?  _printKey1 : _printKey2,
        pixelRatio: 2.0,
      );
      doc.addPage(pw.Page(
          pageFormat: format,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Expanded(
                child: pw.Image(image),
              ),
            );
          }));
      return doc.save();
    });
  }


  List<int> listOfIds=[];
    final List<Marker>  markers=[];
   late LatLng latLng;

    addMarker(double lat, double long){
     int id=Random().nextInt(100);
     setState(() {
     markers.add(Marker(position: LatLng(lat,long) , markerId: MarkerId(id.toString())));
   });
   }



  @override
  void initState() {
    super.initState();
    widget.purchasedData!.data!.map((e) => listOfIds.add(e.userTicketId!) ).toList();

    if(widget.eventGuest!=null) {
        addMarker(widget.eventGuest!.locationLat!,widget.eventGuest!.locationLong!);
        latLng = LatLng(widget.eventGuest!.locationLat!,widget.eventGuest!.locationLong!);
    }
    else{
        addMarker(widget.event!.locationLat!,widget.event!.locationLong!);
        latLng = LatLng(widget.event!.locationLat!,widget.event!.locationLong!);
    }
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
             InkWell(
                 onTap: ()=>CustomNavigator.pushReplacement(context, TabsPage()),
                 child: Center(child: Padding(
                   padding: const EdgeInsets.only(right:20.0),
                   child: Text('Skip'.toUpperCase(), style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold,)),
                 )))
             ]),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Column(
              children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Container(
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.purchasedData!.data!.length,
                      itemBuilder: (context,index) {
                        return RepaintBoundary(
                          key:index==0 ? _printKey : index==1 ? _printKey1 :_printKey2,
                          child: Padding(
                            padding: const EdgeInsets.only(left:40.0,right: 40.0),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                       width: double.infinity,
                                       child: Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Container(
                                             padding: EdgeInsets.only(top: 35, bottom: 20),
                                             child: Column(
                                            children: [
                                             Container(
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
                                                   child: Column(
                                                     children: [
                                                       Container(
                                                         color:widget.purchasedData!.data![index].ticketName=="VIP" || widget.purchasedData!.data![index].ticketName=='Skipping Line'  ?  Colors.orange: Colors.white,
                                                       padding: EdgeInsets.only(bottom: padding, top: padding * 3),
                                                       child: Column(
                                                       children: [
                                                         Padding(
                                                           padding: const EdgeInsets.symmetric(horizontal: padding),
                                                           child: Row(
                                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                             children: [
                                                               Text(AppData().userdetail!.user_name! , style: TextStyle(color: widget.purchasedData!.data![index].ticketName=="VIP"|| widget.purchasedData!.data![index].ticketName=='Skipping Line' ? Colors.white: globalBlack, fontSize: 14, fontWeight: FontWeight.w700,),),
                                                               Text(widget.event!.title, style: TextStyle(color:widget.purchasedData!.data![index].ticketName=="VIP" || widget.purchasedData!.data![index].ticketName=='Skipping Line'? Colors.white: globalBlack, fontSize: 14, fontWeight: FontWeight.w700)),
                                                             ],
                                                           ),
                                                           ),
                                                             Padding(
                                                               padding: const EdgeInsets.symmetric(vertical: padding / 2.3, horizontal: padding),
                                                               child: Row(
                                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                 children: [
                                                                   Row(
                                                                     children: [
                                                                       SvgPicture.asset('assets/icons/calendarSmall.svg', width: 10, height: 10),
                                                                       SizedBox(width: padding / 2),
                                                                       Text(widget.event!.eventStartDate , style: TextStyle(color: widget.purchasedData!.data![index].ticketName=="VIP" || widget.purchasedData!.data![index].ticketName=='Skipping Line'? Colors.white: globalBlack, fontSize: 14, fontWeight: FontWeight.w700,
                                                                         ),
                                                                       ),
                                                                     ],
                                                                         ),
                                                                   Row(
                                                                   children: [
                                                                   SvgPicture.asset('assets/icons/clock.svg', width: 10, height: 10),
                                                                   SizedBox(width: padding / 2),
                                                                   Text(widget.event!.eventStartTime, style: TextStyle(color: widget.purchasedData!.data![index].ticketName=="VIP" ? Colors.white: globalBlack, fontSize: 14, fontWeight: FontWeight.w700)),
                                                                 ]),
                                                                 ],
                                                               ),
                                                             ),
                                                              Container(
                                                                height:150,
                                                                   width:double.infinity,
                                                                   padding: EdgeInsets.all(padding / 2.5),
                                                                   child: Image.asset('assets/imgs/map.png', fit: BoxFit.cover),
                                                                 ),
                                                       // Container(
                                                       //   height: 150,
                                                       //   padding: EdgeInsets.all(padding / 2),
                                                       //   child: GoogleMap(
                                                       //        mapType: MapType.normal,
                                                       //        initialCameraPosition: CameraPosition(
                                                       //        target: LatLng(widget.eventGuest?.locationLat ?? widget.event!.locationLat!,widget.eventGuest?.locationLong ?? widget.event!.locationLong!),
                                                       //        zoom: 5.0,
                                                       //      ),
                                                       //      markers: markers.toSet()
                                                       //      ),),
                                                           ],
                                                         ),
                                                       ),
                                                       Padding(
                                                         padding: const EdgeInsets.only(top:50.0),
                                                         child: Row(
                                                           mainAxisAlignment: MainAxisAlignment.center,
                                                           children: [
                                                             Text(widget.purchasedData!.data![index].ticketName!,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                                             SizedBox(width: 8.0),
                                                             Text("(${widget.purchasedData!.data![index].quantity.toString()})",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                                           ],
                                                         ),
                                                       ),
                                                       Container(
                                                         height: 200,
                                                         color:widget.purchasedData!.data![index].ticketName=="VIP" || widget.purchasedData!.data![index].ticketName=='Skipping Line'?  Colors.orange: Colors.white,
                                                         child: SfBarcodeGenerator(
                                                           barColor:widget.purchasedData!.data![index].ticketName=="VIP"|| widget.purchasedData!.data![index].ticketName=='Skipping Line' ? Colors.white: Colors.black,
                                                           textSpacing: 12,
                                                           value: widget.purchasedData!.data![index].ticketUniqueNumber!,
                                                           symbology: QRCode(),
                                                           showValue: true,
                                                         ),
                                                       ),
                                                         ],
                                                       ),
                                                     ),
                                                   ),
                                                         ],
                                                       ),
                                                     ),
                                               ],
                                             )),
                                             Positioned(
                                              child: SvgPicture.asset('assets/icons/tick.svg', width: 70, height: 70),
                                              top: 0,
                                              right: 0,
                                              left: 0,
                                            ),
                                          ],
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      SizedBox(width: padding),
                                      SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            backgroundColor: globalGreen,
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                          ),
                                          onPressed: () =>_printScreen(index),
                                          child: SvgPicture.asset('assets/icons/download.svg', color: Colors.white, width: 24, height: 20),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                ],
                              ),
                            ),
                          );
                        }
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width/1.2,
                  child: TextButton(
                    onPressed: () async{
                     await  showDialog(
                            context: context,
                            builder: (BuildContext context) {
                            return RequestRefundAlert(
                              event: widget.event,
                              purchasedData: widget.purchasedData,
                              totalAmount: widget.totalAmount,
                              listOfIds: listOfIds,
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
        )

      ),
    );
  }
}
