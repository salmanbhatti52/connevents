import 'package:connevents/models/create-event-model.dart';
import 'package:connevents/models/ticket-sale-info-model.dart';
import 'package:connevents/pages/editEvent/editcreate/editCreatePage.dart';
import 'package:connevents/pages/salesDetails/salesDetailsPageAlerts.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/percent_indicator.dart';

class SalesDetailsPage extends StatefulWidget {
final  EventDetail event;

  const SalesDetailsPage({Key? key,required this.event}) : super(key: key);

  @override
  State<SalesDetailsPage> createState() => _SalesDetailsPageState();
}

class _SalesDetailsPageState extends State<SalesDetailsPage> {

  List<String> ticketTypes=[
    "Early Bird",
    "Skipping Line",
    "VIP",
    "Regular",
  ];
  String? selectedTicket="Early Bird";
  TicketSaleInfo ticketSalesInfo = TicketSaleInfo();

  Future ticketSales() async {
    // try{
       var  res = await DioService.post('ticket_sales', {
           "eventPostId": widget.event.eventPostId,
           "ticket":selectedTicket
    });
    if(res['status']=="success"){
      print(res['data']);
       ticketSalesInfo   = TicketSaleInfo.fromJson(res['data']);
       setState(() {});
       print(ticketSalesInfo.toJson());
       Navigator.of(context).pop();
    }
    else {
      Navigator.of(context).pop();
    }

    // }catch(e){
    //   Navigator.of(context).pop();
    //   showErrorToast(e.toString());
    // }
}



@override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.event.eventTicketType=="Paid")
    if(!widget.event.isSocialEvent){
       WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        openLoadingDialog(context, "loading...");
        ticketSales();
         });
    }

  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
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
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: globallightbg,
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: padding, horizontal: padding * 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              children: [
                                Text(widget.event.title, style: TextStyle(color: globalBlack, fontSize: 36, fontWeight: FontWeight.bold,)),
                                SizedBox(width: padding),

                                SizedBox(
                                  width: 55,
                                  height: 24,
                                  child: TextButton(
                                    onPressed: () {
                                      widget.event.isEditableEvent ?
                                        CustomNavigator.navigateTo(context, EditCreatePage(event: widget.event)):
                                          showErrorToast("You can't edit this event");
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: globalGreen,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      padding: EdgeInsets.zero,
                                    ),
                                    child: Text('Edit', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold,)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: padding / 2),
                            Row(
                              children: [
                                SvgPicture.asset('assets/icons/calendarSmall.svg'),
                                SizedBox(width: padding / 2),
                                Text(widget.event.eventStartDate),
                                SizedBox(width: padding),
                                SvgPicture.asset('assets/icons/clock.svg'),
                                SizedBox(width: padding / 2),
                                Text("${widget.event.eventStartTime}"),
                                Text('-'),
                                Text("${widget.event.eventEndTime}", style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                            if(widget.event.eventTicketType=="Paid")
                            SizedBox(height: padding * 2),
                            if(widget.event.eventTicketType=="Paid")
                            Text('Tickets Type ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: globalBlack)),
                             if(widget.event.eventTicketType=="Paid")
                             SizedBox(height: padding),
                              if(widget.event.eventTicketType=="Paid")
                              dropDownContainer(
                               child: DropdownButton<String>(
                                underline: Container(),
                                isExpanded: true,
                                iconEnabledColor: Colors.black,
                                focusColor: Colors.black,
                                hint: Text("Select Event Type"),
                                icon: Icon(Icons.arrow_drop_down_rounded),
                                items: ticketTypes.map((String value) {
                                  return  DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (newValue) async{
                                  selectedTicket = newValue.toString();
                                   openLoadingDialog(context, 'loading');
                                  await ticketSales();

                                  setState(() {});
                                },
                                value: selectedTicket,
                              ),
                       ),
                            if(widget.event.eventTicketType=="Paid")
                            SizedBox(height: padding * 2),
                            if(widget.event.eventTicketType=="Paid")
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Total Sales', style: TextStyle(color: globalBlack, fontSize: 14, fontWeight: FontWeight.bold)),
                                Text('\$ ${ticketSalesInfo.totalSales ?? 0}', style: TextStyle(color: globalGreen, fontSize: 25, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            if(widget.event.eventTicketType=="Paid")
                            SizedBox(height: padding),
                          ],
                        ),
                      ),
                      if(widget.event.eventTicketType=="Paid")
                      Container(
                        padding: EdgeInsets.all(padding * 2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: globalLGray, blurRadius: 5),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('Tickets Sold', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: globalBlack)),
                                  SizedBox(height: padding / 2),
                                  CircularPercentIndicator(
                                    radius: 100.0,
                                    lineWidth: 3,
                                    percent: ((ticketSalesInfo.soldTickets)  / (num.tryParse(ticketSalesInfo.totalQuantity.toString())??0)).floorToDouble()  ,
                                    center: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        new Text("${(ticketSalesInfo.soldTickets)  }", style: TextStyle(color: globalGreen, fontSize: 18, fontWeight: FontWeight.bold)),
                                        new Text(
                                          "/${ticketSalesInfo.totalQuantity ?? 0}",
                                          style: TextStyle(
                                            color: globalBlack.withOpacity(0.5),
                                            fontSize: 14, fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    progressColor: Colors.green,
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('Total Check in', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: globalBlack,)),
                                  SizedBox(height: padding / 2),
                                  CircularPercentIndicator(
                                    radius: 100.0,
                                    lineWidth: 3,
                                    percent: (ticketSalesInfo.checkins)  / (num.tryParse(ticketSalesInfo.totalCheckins.toString())??0),
                                    center: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        new Text("${ticketSalesInfo.checkins}", style: TextStyle(color: globalGreen, fontSize: 18, fontWeight: FontWeight.bold)),
                                        new Text("/${ticketSalesInfo.totalCheckins ?? 0}", style: TextStyle(color: globalBlack.withOpacity(0.5), fontSize: 14, fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    progressColor: Colors.green,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      if(widget.event.eventTicketType=="Paid")
                      SizedBox(height: padding * 2),
                      if(widget.event.eventTicketType=="Paid")
                        if(selectedTicket != 'Early Bird' && selectedTicket != 'Regular' && selectedTicket != 'Skipping Line')
                        Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("${ticketSalesInfo.totalCheckins ?? 0} x", style: TextStyle(color: globalGreen, fontSize: 18, fontWeight: FontWeight.bold)),
                            SizedBox(width: padding / 2),
                            Text(selectedTicket!, style: TextStyle(color: globalBlack, fontSize: 14, fontWeight: FontWeight.bold,)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: padding, horizontal: padding * 2),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CancelEventAlert(event: widget.event);
                          });
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text('Cancel Event'.toUpperCase(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16,
                      ),
                    ),
                  ),
                ),
              )
            ],
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
