import 'package:connevents/models/create-event-model.dart';
import 'package:connevents/models/event-dummy-ticket.dart';
import 'package:connevents/pages/editEvent/editcreate/editCreatePage.dart';
import 'package:connevents/pages/editEvent/editcreateThird/editCreateThirdPage.dart';
import 'package:connevents/utils/date-time.dart';
import 'package:connevents/utils/detect-link.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/connevents-textfield.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class EditCreateSecondPage extends StatefulWidget {
 final bool isEdit;
  final EventDetail event;
  const EditCreateSecondPage({Key? key, required this.event,this.isEdit=false}) : super(key: key);

  @override
  _EditCreateSecondPageState createState() => _EditCreateSecondPageState();
}

class _EditCreateSecondPageState extends State<EditCreateSecondPage> {

  String? _hour, _minute, _time;
  String? dateTime;
  String regularDate = '';
  String vipDate = '';
  bool isRefundableYes = true;
  bool isRefundableNo = false;
  bool isEarlyBird = false;
  bool isRegular = false;
  bool isVip = false;

  TimeOfDay? editSelectedStartTime;
  TimeOfDay? editSelectedEndTime;
  final key = GlobalKey<FormState>();

  Future _selectEagleBirdClosingDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: eventDetail.earlyBird!.selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null && picked.toUtc().isAfter(eventDetail.pickedEventStartDate!) && picked.toUtc().isBefore(eventDetail.pickedEventEndDate!)  || picked!.toUtc().isAtSameMomentAs(eventDetail.pickedEventEndDate!)  || picked.toUtc().isAtSameMomentAs(eventDetail.pickedEventStartDate!)){
      setState(() {
        print(picked);
        eventDetail.earlyBird!.selectedDate = picked;
        eventDetail.earlyBird!.selectedDate = eventDetail.earlyBird!.selectedDate;
        eventDetail.earlyBird!.earlyBird = DateFormat.yMd().format(eventDetail.earlyBird!.selectedDate);
        print(eventDetail.earlyBird!.earlyBird);
        final f = new DateFormat('yyyy-MM-dd hh:mm');
        eventDetail.earlyBird!.closingDate = f.format(eventDetail.earlyBird!.selectedDate);
      });
    }
    else{
      showErrorToast("Closing Date Should Not more or less than Event Date & Time");
    }
  }


  Future _selectDate(BuildContext context) async {
    TimeOfDay? _startTime;
    TimeOfDay? _endTime;
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: eventDetail.pickedEventStartDate ?? DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
       if (picked != null) {
          setState(() {
        if(picked.isAtSameMomentAs(eventDetail.pickedEventEndDate!)  &&  toDouble(editSelectedStartTime!) > toDouble(editSelectedEndTime!)){
          return  showErrorToast("Event Start Time Must be Smaller than Event End Time");

        }else if ((picked.toUtc().isBefore(eventDetail.pickedEventEndDate!) || picked.isAtSameMomentAs(eventDetail.pickedEventEndDate!))){
            eventDetail.pickedEventStartDate = picked;
            var dateFormat = DateFormat.yMMMd();
            eventDetail.eventStartDate = dateFormat.format(eventDetail.pickedEventStartDate!);
        }
       else showErrorToast("Event Start Date Must be Smaller than Event End Date");
      });
    }
  }

  Future _selectDateEnd(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: eventDetail.pickedEventEndDate ?? DateTime.now(),
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(2015),
      lastDate: DateTime(2040),
    );
    if(picked!.isAtSameMomentAs(eventDetail.pickedEventStartDate!)  &&  toDouble(editSelectedStartTime!) > toDouble(editSelectedEndTime!)){
          return  showErrorToast("Event Start Time Must be Smaller than Event End Time");
        }
   else if (picked.isAtSameMomentAs(eventDetail.pickedEventStartDate!)  ||  picked.isAfter(eventDetail.pickedEventStartDate!)  || picked.isAtSameMomentAs(eventDetail.pickedEventEndDate!)) {
      setState(() {
        eventDetail.pickedEventEndDate = picked;
        eventDetail.pickedEventEndDate = eventDetail.pickedEventEndDate;
        var i = eventDetail.pickedEventEndDate!.isAtSameMomentAs(eventDetail.pickedEventStartDate!);
        print(i);
        var dateFormat = DateFormat.yMMMd();
        eventDetail.eventEndDate = dateFormat.format(eventDetail.pickedEventEndDate!);

      });
    } else {
      showErrorToast("Please Select greater than Event Start Date");
    }
  }

  Future _selectTime(BuildContext context) async {
    TimeOfDay? _endTime;

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: editSelectedStartTime ?? TimeOfDay(hour: 00, minute: 00),
    );
    if(picked==null)
      _endTime = stringToTimeOfDay(eventDetail.eventEndTime);
    DateTime dt1= DateTime.parse("${eventDetail.pickedEventStartDate!.toString().split(" ").first}" + " ${picked!.hour.toString().length==1 ? "0${picked.hour.toString()}": picked.hour.toString()}" + ":${picked.minute.toString().length==1 ? "0${picked.minute.toString()}" : picked.minute.toString()}" + ":00" );
     Duration diff = dt1.difference(DateTime.now());
     print(diff);
    if(diff.isNegative)
      showErrorToast("You Can't Select Previous Time");
    else{
       if(eventDetail.pickedEventStartDate!.toUtc().isAtSameMomentAs(eventDetail.pickedEventEndDate!)){
      if (  editSelectedEndTime==null ?  toDouble(picked) < toDouble(_endTime!) : toDouble(picked) < toDouble(editSelectedEndTime!)){
        setState(() {
          editSelectedStartTime = picked;
          _hour = editSelectedStartTime!.hour.toString();
          _minute = editSelectedStartTime!.minute.toString();
          _time = _hour! + ' : ' + _minute!;
          eventDetail.eventStartTime = _time!;
          eventDetail.eventStartTime = formatDate(
              DateTime(2019, 08, 1, editSelectedStartTime!.hour, editSelectedStartTime!.minute),
              [hh, ':', nn, am]).toString();
        });
      }
      else showErrorToast("Event Sales Start Time must be smaller than Event Sales End Time");


    }
    else {
      if (picked != null)
        setState(() {
          editSelectedStartTime = picked;
          _hour = editSelectedStartTime!.hour.toString();
          _minute = editSelectedStartTime!.minute.toString();
          _time = _hour! + ' : ' + _minute!;
          eventDetail.eventStartTime = _time!;
          eventDetail.eventStartTime = formatDate(
              DateTime(2019, 08, 1, editSelectedStartTime!.hour, editSelectedStartTime!.minute),
              [hh, ':', nn, am]).toString();
        });
    }

    }


  }

  Future _selectTimeEnd(BuildContext context) async {
    TimeOfDay? _startTime;
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: editSelectedEndTime ?? TimeOfDay(hour: 00, minute: 00),
    );
    if(editSelectedStartTime==null)
    _startTime = stringToTimeOfDay(eventDetail.eventStartTime);

    if(eventDetail.pickedEventStartDate!.toUtc().isAtSameMomentAs(eventDetail.pickedEventEndDate!)){
      if (picked != null  &&  editSelectedStartTime==null ?  toDouble(picked) > toDouble(_startTime!) : toDouble(picked!) > toDouble(editSelectedStartTime!)  ) {
        print(editSelectedEndTime);
        setState(() {
          editSelectedEndTime = picked;
          _hour = editSelectedEndTime!.hour.toString();
          _minute = editSelectedEndTime!.minute.toString();
          _time = _hour! + ' : ' + _minute!;
          eventDetail.eventEndTime = _time!;
          eventDetail.eventEndTime = formatDate(DateTime(2019, 08, 1, editSelectedEndTime!.hour, editSelectedEndTime!.minute),
              [hh, ':', nn, am]).toString();
        });
      }
      else showErrorToast("Sales End Time must e greater than Sales Start Time");

    }
    else if (picked != null) {
      print(editSelectedEndTime);
      setState(() {
        editSelectedEndTime = picked;
        _hour = editSelectedEndTime!.hour.toString();
        _minute = editSelectedEndTime!.minute.toString();
        _time = _hour! + ' : ' + _minute!;
        eventDetail.eventEndTime = _time!;
        eventDetail.eventEndTime = formatDate(DateTime(2019, 08, 1, editSelectedEndTime!.hour, editSelectedEndTime!.minute),
            [hh, ':', nn, am]).toString();
      });
    }


  }

  @override
  void initState() {
    super.initState();
    eventDetail = widget.event;
      eventDetail.list = eventDetail.list ?? [];
      eventDetail.removedTickets = eventDetail.removedTickets ?? [];
      var dateFormat = DateFormat.yMMMd();
      editSelectedStartTime     =stringToTimeOfDay(eventDetail.eventStartTime);
      editSelectedEndTime = stringToTimeOfDay(eventDetail.eventEndTime);
    eventDetail.pickedEventStartDate=dateFormat.parse(eventDetail.eventStartDate);
    eventDetail.pickedEventEndDate=dateFormat.parse(eventDetail.eventEndDate);
   if(eventDetail.earlyBird != null) {
     if(eventDetail.earlyBird!.quantity!.isNotEmpty){
     eventDetail.earlyBird!.isVisible=true;
     DateTime closingDate = DateTime.parse(eventDetail.earlyBird!.closingDate);
    eventDetail.earlyBird!.earlyBird = DateFormat.yMd().format(closingDate);
     }
   }else eventDetail.earlyBird=EarlyBird();

   if(eventDetail.regular!=null) {
     if(eventDetail.regular!.quantity!.isNotEmpty)
     eventDetail.regular!.isVisible=true;
   }else  eventDetail.regular=Regular();
   if(eventDetail.vip!=null){
     if(eventDetail.vip!.quantity!.isNotEmpty)
     eventDetail.vip!.isVisible=true;
   }  else eventDetail.vip=VIP();
    if(eventDetail.skippingLine!=null){
      if(eventDetail.skippingLine!.quantity!.isNotEmpty)
        eventDetail.skippingLine!.isVisible=true;
    }  else eventDetail.skippingLine=SkippingLine();
   // if(eventDetail.tblTenPeopleCost.toString().isNotEmpty) eventDetail.isTableAvailableFor10People=true;
   // if(eventDetail.tblEightPeopleCost.toString().isNotEmpty) eventDetail.isTableAvailableFor8People=true;
   // if(eventDetail.tblSixPeopleCost.toString().isNotEmpty) eventDetail.isTableAvailableFor6People=true;
   // if(eventDetail.tblFourPeopleCost.toString().isNotEmpty) eventDetail.isTableAvailableFor4People=true;
   
   if(eventDetail.eventTicketType == "MyFreeEvent")
     eventDetail.isFreeEvent=true;
   else if(eventDetail.eventTicketType == "NotMyEvent")
      eventDetail.isNotMyEvent=true;
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
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
            padding: EdgeInsets.all(padding * 2),
            child: Form(
              key: key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Event Date & Time*", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Start Date", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),
                              SizedBox(height: 6),
                              GestureDetector(
                                  onTap: () => _selectDate(context),
                                  child: dateContainer(size, eventDetail.eventStartDate, Icons.calendar_today)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("End Date", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                              SizedBox(height: 6),
                              GestureDetector(
                                  onTap: () => _selectDateEnd(context),
                                  child: dateContainer(size, eventDetail.eventEndDate, Icons.calendar_today)),

                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Start Time", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),
                              SizedBox(height: 6),
                              GestureDetector(
                                  onTap: () => _selectTime(context),
                                  child: dateContainer(size, eventDetail.eventStartTime, Icons.watch_later_outlined)),

                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("End Time", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                              SizedBox(height: 6),
                              GestureDetector(
                                  onTap: () => _selectTimeEnd(context),
                                  child: dateContainer(size, eventDetail.eventEndTime, Icons.watch_later_outlined)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 12,),
                      Text("Description*", style: TextConstants.headingStyle),
                      SizedBox(height: 8),
                      ConneventsTextField(
                        value: eventDetail.description,
                        onSaved: (value) => eventDetail.description = value,
                        validator: (val) => val!.isEmpty ? "Please Enter Description" : null,
                        maxLines: 4,
                      ),
                      SizedBox(height: 6),
                      if(eventDetail.eventTicketType=="NotMyEvent")
                      Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         SizedBox(
                           width: 20,
                           child: Checkbox(
                             value: eventDetail.isNotMyEvent,
                             checkColor: globalGreen,
                             onChanged: (val)  {},
                           ),
                         ),
                         text(title:"Not My Event",fontSize: 14),
                       ],
                          ),
                      if(eventDetail.eventTicketType=="NotMyEvent")
                      SizedBox(height: 6),
                      if(eventDetail.eventTicketType=="NotMyEvent")
                      Text("Hyperlink*", style: TextConstants.headingStyle),
                      if(eventDetail.eventTicketType=="NotMyEvent")
                      SizedBox(height: 6),
                      if(eventDetail.eventTicketType=="NotMyEvent")
                       ConneventsTextField(
                        keyBoardType: TextInputType.url,
                        value: eventDetail.hyperlink,
                        onSaved: (value) {
                          bool link = isLink(value!);
                          print(link);
                          if(link){
                            setState(() {
                            eventDetail.hyperlink = value;
                          });
                          }
                        },
                       // validator: (val) => val!.isEmpty ? "Please Enter Hyperlink" : null,
                      ),
                      if(eventDetail.eventTicketType=="MyFreeEvent")
                      Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         SizedBox(
                           width: 20,
                           child: Checkbox(
                             value: eventDetail.isFreeEvent,
                             checkColor: globalGreen,
                             onChanged: (val) {},
                           ),
                         ),
                         text(title:"Free Event" , fontSize: 14),
                       ],
                          ),
                      SizedBox(height: 10),
                    Stack(
                    children:[
                     Column(
                       children:[
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Refundable", style: TextConstants.headingStyle),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (isRefundableYes)
                                    setState(() => isRefundableNo = false);
                                  else {
                                    setState(() {
                                      isRefundableYes = true;
                                      isRefundableNo = false;
                                    });
                                  }
                                },
                                child: Container(
                                  height: 25,
                                  decoration: BoxDecoration(
                                    color: isRefundableYes ? Colors.red : globalLightButtonbg,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  width: size.width / 4,
                                  child: Center(
                                      child: Text("YES", style: TextStyle(color: Colors.black))),
                                ),
                              ),
                              SizedBox(width: 6),
                              GestureDetector(
                                onTap: () {
                                  if (isRefundableNo)  setState(() => isRefundableYes = false);
                                  else {
                                    setState(() {
                                      isRefundableNo = true;
                                      isRefundableYes = false;
                                    });
                                  }
                                },
                                child: Container(
                                  height: 25,
                                  decoration: BoxDecoration(
                                    color: isRefundableNo ? Colors.red : globalLightButtonbg,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  width: size.width / 4,
                                  child: Center(
                                      child: Text("NO", style: TextStyle(color: Colors.black),
                                  )),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Ticket Prices*", style: TextConstants.headingStyle),
                          text(title:"# of Tickets",fontSize: 14),
                          text(title:"Price",fontSize: 14)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 20,
                                child: Checkbox(
                                  value: eventDetail.earlyBird!.isVisible,
                                  checkColor: globalGreen,
                                  onChanged: (val) => setState(() => eventDetail.earlyBird!.isVisible = val!),
                                ),
                              ),
                              text(title:"Early bird",fontSize: 14 ),
                            ],
                          ),
                          Visibility(
                            visible: eventDetail.earlyBird!.isVisible,
                            child: SizedBox(
                               width: MediaQuery.of(context).size.width/2.29,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 23,
                                    width: MediaQuery.of(context).size.width/6,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: globalLGray,
                                          blurRadius: 3,
                                        )
                                      ],
                                    ),
                                    child: TextFormField(
                                      initialValue: eventDetail.earlyBird!.quantity,
                                      textAlign: TextAlign.center,
                                      inputFormatters: [LengthLimitingTextInputFormatter(4)],
                                      onSaved: (value) => setState(() => eventDetail.earlyBird!.quantity = value!),
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration.collapsed(hintText: ""),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left:MediaQuery.of(context).size.width/21),
                                    child: Row(
                                      children: [
                                        text(title:"\$" ,fontSize: 14),
                                        SizedBox(width: 6),
                                        Container(
                                          height: 23,
                                          width: MediaQuery.of(context).size.width/6.6,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: globalLGray,
                                                blurRadius: 3,
                                              )
                                            ],
                                          ),
                                          child: TextFormField(
                                            initialValue: eventDetail.earlyBird!.price.toString(),
                                            keyboardType: TextInputType.number,
                                            textAlign: TextAlign.center,
                                            inputFormatters: [LengthLimitingTextInputFormatter(4)],
                                            onSaved: (value) => setState(() {
                                              eventDetail.earlyBird!.price = value!;
                                            }),
                                            decoration: InputDecoration.collapsed(hintText: ""),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: eventDetail.earlyBird!.isVisible,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            text(title: "Closing Date",fontSize: 14),
                            GestureDetector(
                                onTap: () => _selectEagleBirdClosingDate(context),
                                child: dateContainer(size, eventDetail.earlyBird!.earlyBird, Icons.calendar_today)),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                                child: Checkbox(
                                  value: eventDetail.regular!.isVisible,
                                  checkColor: globalGreen,
                                  activeColor: globalGreen,
                                  onChanged: (val) => setState(() => eventDetail.regular!.isVisible = val!),
                                ),
                              ),
                              text(title:"Regular",fontSize: 14),
                            ],
                          ),
                          Visibility(
                            visible: eventDetail.regular!.isVisible,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width/2.4,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 23,
                                    width: MediaQuery.of(context).size.width/6,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: globalLGray,
                                          blurRadius: 3,
                                        )
                                      ],
                                    ),
                                    child: TextFormField(
                                      initialValue: eventDetail.regular!.quantity,
                                      onSaved: (value) => setState(() => eventDetail.regular!.quantity = value!),
                                      keyboardType: TextInputType.number,
                                       textAlign: TextAlign.center,
                                      inputFormatters: [LengthLimitingTextInputFormatter(4)],
                                      decoration: InputDecoration.collapsed(hintText: ""),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text("\$", style: TextStyle(fontSize: 14)),
                                      SizedBox(width: 6),
                                      Container(
                                        height: 23,
                                        width: MediaQuery.of(context).size.width/6.6,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: globalLGray,
                                              blurRadius: 3,
                                            )
                                          ],
                                        ),
                                        child: TextFormField(
                                          initialValue: eventDetail.regular!.price,
                                          keyboardType: TextInputType.number,
                                           textAlign: TextAlign.center,
                                      inputFormatters: [LengthLimitingTextInputFormatter(4)],
                                          onSaved: (value) => setState(() {
                                            eventDetail.regular!.price = value!;
                                          }),
                                          decoration: InputDecoration.collapsed(hintText: ""),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width:20,
                                child: Checkbox(
                                  value: eventDetail.vip!.isVisible,
                                  checkColor: globalGreen,
                                  activeColor: globalGreen,
                                  onChanged: (val) => setState(() {
                                  //      if(eventDetail.isTableAvailableFor4People || eventDetail.isTableAvailableFor6People || eventDetail.isTableAvailableFor6People || eventDetail.isTableAvailableFor10People ){
                                  //      return showErrorToast("You can't deselect thi after including Table Service");
                                  //     }
                                  // else
                                    eventDetail.vip!.isVisible = val!;
                                  }),
                                ),
                              ),
                              text(title:"VIP",fontSize: 14),
                            ],
                          ),
                          Visibility(
                            visible: eventDetail.vip!.isVisible,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width/2.4,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 25,
                                    width: MediaQuery.of(context).size.width/6,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: globalLGray,
                                          blurRadius: 3,
                                        )
                                      ],
                                    ),
                                    child: TextFormField(
                                      initialValue: eventDetail.vip!.quantity,
                                      onSaved: (value) => setState(() => eventDetail.vip!.quantity = value!),
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      inputFormatters: [LengthLimitingTextInputFormatter(4)],
                                      decoration: InputDecoration.collapsed(
                                          hintText: ""),
                                    ),
                                  ),
                                  Padding(
                                    padding:  EdgeInsets.only(left:MediaQuery.of(context).size.width/21),
                                    child: Row(
                                      children: [
                                        Text("\$", style: TextStyle(fontSize: 14)),
                                        SizedBox(width: 6),
                                        Container(
                                          height: 23,
                                          width: MediaQuery.of(context).size.width/6.6,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: globalLGray,
                                                blurRadius: 3,
                                              )
                                            ],
                                          ),
                                          child: TextFormField(
                                            initialValue: eventDetail.vip!.price.toString(),
                                            keyboardType: TextInputType.number,
                                            textAlign: TextAlign.center,
                                            inputFormatters: [LengthLimitingTextInputFormatter(4)],
                                            onSaved: (value) => setState(() => eventDetail.vip!.price = value!),
                                            decoration: InputDecoration.collapsed(hintText: ""),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Row(
                               children: [
                                 SizedBox(
                                   width:20,
                                   child: Checkbox(
                                     value: eventDetail.skippingLine!.isVisible,
                                     checkColor: globalGreen,
                                     activeColor: globalGreen,
                                     onChanged: (val) => setState(() {
                                       //      if(eventDetail.isTableAvailableFor4People || eventDetail.isTableAvailableFor6People || eventDetail.isTableAvailableFor6People || eventDetail.isTableAvailableFor10People ){
                                       //      return showErrorToast("You can't deselect thi after including Table Service");
                                       //     }
                                       // else
                                       eventDetail.skippingLine!.isVisible = val!;
                                     }),
                                   ),
                                 ),
                                 text(title:"Skipping Line",fontSize: 14),
                               ],
                             ),
                             Visibility(
                               visible: eventDetail.skippingLine!.isVisible,
                               child: SizedBox(
                                 width: MediaQuery.of(context).size.width/2.4,
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Container(
                                       height: 25,
                                       width: MediaQuery.of(context).size.width/6,
                                       decoration: BoxDecoration(
                                         color: Colors.white,
                                         boxShadow: [
                                           BoxShadow(
                                             color: globalLGray,
                                             blurRadius: 3,
                                           )
                                         ],
                                       ),
                                       child: TextFormField(
                                         initialValue: eventDetail.skippingLine!.quantity,
                                         onSaved: (value) => setState(() => eventDetail.skippingLine!.quantity = value!),
                                         keyboardType: TextInputType.number,
                                         textAlign: TextAlign.center,
                                         inputFormatters: [LengthLimitingTextInputFormatter(4)],
                                         decoration: InputDecoration.collapsed(
                                             hintText: ""),
                                       ),
                                     ),
                                     Padding(
                                       padding:  EdgeInsets.only(left:MediaQuery.of(context).size.width/21),
                                       child: Row(
                                         children: [
                                           Text("\$", style: TextStyle(fontSize: 14)),
                                           SizedBox(width: 6),
                                           Container(
                                             height: 23,
                                             width: MediaQuery.of(context).size.width/6.6,
                                             decoration: BoxDecoration(
                                               color: Colors.white,
                                               boxShadow: [
                                                 BoxShadow(
                                                   color: globalLGray,
                                                   blurRadius: 3,
                                                 )
                                               ],
                                             ),
                                             child: TextFormField(
                                               initialValue: eventDetail.skippingLine!.price.toString(),
                                               keyboardType: TextInputType.number,
                                               textAlign: TextAlign.center,
                                               inputFormatters: [LengthLimitingTextInputFormatter(4)],
                                               onSaved: (value) => setState(() => eventDetail.skippingLine!.price = value!),
                                               decoration: InputDecoration.collapsed(hintText: ""),
                                             ),
                                           ),
                                         ],
                                       ),
                                     )
                                   ],
                                 ),
                               ),
                             ),
                           ],
                         ),




 /////////////--------Table Services------------------------


                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Row(
                      //       children: [
                      //         SizedBox(
                      //           width: 20,
                      //           child: Checkbox(
                      //             value: eventDetail.isTableAvailableFor4People,
                      //             checkColor: globalGreen,
                      //             activeColor: globalGreen,
                      //             onChanged: (val) {
                      //                setState(() {
                      //                  if(eventDetail.vip!.isVisible)
                      //                     eventDetail.isTableAvailableFor4People = val!;
                      //                  else{
                      //                    return showErrorToast("You have to select Skipping Line");
                      //                  }
                      //               });
                      //             },
                      //           ),
                      //         ),
                      //         text(title:"VIP For 4 People",fontSize: 14),
                      //       ],
                      //     ),
                      //     Visibility(
                      //       visible: eventDetail.isTableAvailableFor4People,
                      //       child: Row(
                      //         children: [
                      //           Text("\$", style: TextStyle(fontSize: 14)),
                      //           SizedBox(width: 6),
                      //           Container(
                      //             height: 23,
                      //             width: 60,
                      //             decoration: BoxDecoration(
                      //               color: Colors.white,
                      //               boxShadow: [
                      //                 BoxShadow(
                      //                   color: globalLGray,
                      //                   blurRadius: 3,
                      //                 )
                      //               ],
                      //             ),
                      //             child: TextFormField(
                      //              initialValue:   eventDetail.tblFourPeopleCost.toString(),
                      //               onSaved: (value) => setState(() => eventDetail.tblFourPeopleCost = value!),
                      //               keyboardType: TextInputType.number,
                      //                textAlign: TextAlign.center,
                      //                   inputFormatters: [LengthLimitingTextInputFormatter(4)],
                      //               decoration: InputDecoration.collapsed(hintText: ""),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Row(
                      //       children: [
                      //         SizedBox(
                      //           width: 20,
                      //           child: Checkbox(
                      //             value: eventDetail.isTableAvailableFor6People,
                      //             checkColor: globalGreen,
                      //             activeColor: globalGreen,
                      //             onChanged: (val) {
                      //                setState(() {
                      //                  if(eventDetail.vip!.isVisible)
                      //                     eventDetail.isTableAvailableFor6People = val!;
                      //                  else{
                      //                    return showErrorToast("You have to select Skipping Line");
                      //                  }
                      //               });
                      //             },
                      //           ),
                      //         ),
                      //         text(title:"VIP For 6 People",fontSize: 14),
                      //       ],
                      //     ),
                      //     Visibility(
                      //       visible: eventDetail.isTableAvailableFor6People,
                      //       child: Row(
                      //         children: [
                      //           Text("\$", style: TextStyle(fontSize: 14)),
                      //           SizedBox(width: 6),
                      //           Container(
                      //             height: 23,
                      //             width: 60,
                      //             decoration: BoxDecoration(
                      //               color: Colors.white,
                      //               boxShadow: [
                      //                 BoxShadow(
                      //                   color: globalLGray,
                      //                   blurRadius: 3,
                      //                 )
                      //               ],
                      //             ),
                      //             child: TextFormField(
                      //              initialValue:   eventDetail.tblSixPeopleCost.toString(),
                      //               onSaved: (value) => setState(() => eventDetail.tblSixPeopleCost = value!),
                      //               keyboardType: TextInputType.number,
                      //                textAlign: TextAlign.center,
                      //                   inputFormatters: [LengthLimitingTextInputFormatter(4)],
                      //               decoration: InputDecoration.collapsed(hintText: ""),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Row(
                      //       children: [
                      //         SizedBox(
                      //           width: 20,
                      //           child: Checkbox(
                      //             value: eventDetail.isTableAvailableFor8People,
                      //             checkColor: globalGreen,
                      //             activeColor: globalGreen,
                      //             onChanged: (val){
                      //               setState(() {
                      //                  if(eventDetail.vip!.isVisible)
                      //                     eventDetail.isTableAvailableFor8People = val!;
                      //                  else{
                      //                    return showErrorToast("You have to select Skipping Line");
                      //                  }
                      //               });
                      //             }
                      //           ),
                      //         ),
                      //         text(title:"VIP For 8 People",fontSize: 14),
                      //       ],
                      //     ),
                      //     Visibility(
                      //       visible: eventDetail.isTableAvailableFor8People,
                      //       child: Row(
                      //         children: [
                      //           Text("\$", style: TextStyle(fontSize: 14)),
                      //           SizedBox(width: 6),
                      //           Container(
                      //             height: 23,
                      //             width: 60,
                      //             decoration: BoxDecoration(
                      //               color: Colors.white,
                      //               boxShadow: [
                      //                 BoxShadow(
                      //                   color: globalLGray,
                      //                   blurRadius: 3,
                      //                 )
                      //               ],
                      //             ),
                      //             child: TextFormField(
                      //              initialValue:   eventDetail.tblEightPeopleCost.toString(),
                      //               onSaved: (value) => setState(() => eventDetail.tblEightPeopleCost = value!),
                      //               keyboardType: TextInputType.number,
                      //                textAlign: TextAlign.center,
                      //                   inputFormatters: [LengthLimitingTextInputFormatter(4)],
                      //               decoration: InputDecoration.collapsed(hintText: ""),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Row(
                      //       children: [
                      //         SizedBox(
                      //           width: 20,
                      //           child: Checkbox(
                      //             value: eventDetail.isTableAvailableFor10People,
                      //             checkColor: globalGreen,
                      //             activeColor: globalGreen,
                      //             onChanged: (val){
                      //                setState(() {
                      //                  if(eventDetail.vip!.isVisible)
                      //                     eventDetail.isTableAvailableFor10People = val!;
                      //                  else{
                      //                    return showErrorToast("You have to select Skipping Line");
                      //                  }
                      //               });
                      //             },
                      //           ),
                      //         ),
                      //         text(title:"VIP For 10 People",fontSize: 14),
                      //       ],
                      //     ),
                      //     Visibility(
                      //       visible: eventDetail.isTableAvailableFor10People,
                      //       child: Row(
                      //         children: [
                      //           Text("\$", style: TextStyle(fontSize: 14)),
                      //                   SizedBox(width: 6),
                      //           Container(
                      //             height: 23,
                      //             width: 60,
                      //             decoration: BoxDecoration(
                      //               color: Colors.white,
                      //               boxShadow: [
                      //                 BoxShadow(
                      //                   color: globalLGray,
                      //                   blurRadius: 3,
                      //                 )
                      //               ],
                      //             ),
                      //             child: TextFormField(
                      //              initialValue:    eventDetail.tblTenPeopleCost.toString(),
                      //               onSaved: (value) => setState(() =>eventDetail.tblTenPeopleCost = value!),
                      //               keyboardType: TextInputType.number,
                      //                textAlign: TextAlign.center,
                      //                   inputFormatters: [LengthLimitingTextInputFormatter(4)],
                      //               decoration: InputDecoration.collapsed(hintText: ""),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Discount Promo", style: TextStyle(fontSize: 14)),
                          SizedBox(
                            width: MediaQuery.of(context).size.width /2.4,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 23,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: globalLGray,
                                        blurRadius: 3,
                                      )
                                    ],
                                  ),
                                  child: TextFormField(
                                    initialValue: eventDetail.minTicketsDiscount,
                                    onSaved: (value) => setState(() => eventDetail.minTicketsDiscount = value),
                                    keyboardType: TextInputType.number,
                                     textAlign: TextAlign.center,
                                            inputFormatters: [LengthLimitingTextInputFormatter(4)],
                                    decoration: InputDecoration.collapsed(hintText: ""),
                                  ),
                                ),
                                Row(
                              children: [
                                Text("%", style: TextStyle(fontSize: 14)),
                                SizedBox(width: 6),
                                Container(
                                  height: 23,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: globalLGray,
                                        blurRadius: 3,
                                      )
                                    ],
                                  ),
                                  child: TextFormField(
                                    initialValue: eventDetail.discountPercent,
                                    keyboardType: TextInputType.number,
                                     textAlign: TextAlign.center,
                                        inputFormatters: [LengthLimitingTextInputFormatter(4)],
                                    onSaved: (value) => setState(() {
                                      print(value);
                                      eventDetail.discountPercent = value;
                                    }),
                                    decoration: InputDecoration.collapsed(hintText: ""),
                                  ),
                                ),
                              ],
                            ),
                              ],
                            ),
                          ),

                        ],
                      ),
                       ]
                     ),
                     if(eventDetail.eventTicketType=="MyFreeEvent" || eventDetail.eventTicketType=="NotMyEvent")
                     Opacity(
                      opacity:0.6,
                      child: Container(
                        color:Colors.grey.shade50,
                        height:MediaQuery.of(context).size.height/2.6,
                        width : MediaQuery.of(context).size.width,
                            ),
                    )
                        ]
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:16.0),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: globalGreen,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () async {
                              print(eventDetail.eventEndTime);
                              if (key.currentState!.validate()) {
                                key.currentState!.save();

                                if(eventDetail.eventTicketType=="Paid"){

                                if (isRefundableYes) eventDetail.refundable = 1; else eventDetail.refundable = 0;
                                // if (eventDetail.isTableAvailableFor4People) eventDetail.tableService = 1;
                                // if (eventDetail.isTableAvailableFor6People) eventDetail.tableService = 1;
                                // if (eventDetail.isTableAvailableFor8People) eventDetail.tableService = 1;
                                // if (eventDetail.isTableAvailableFor10People) eventDetail.tableService = 1;
                                if (eventDetail.eventStartDate.isEmpty) return showErrorToast("You have to select a Event Start Date");
                                if (eventDetail.eventEndDate.isEmpty) return showErrorToast("You have to select a Event End Date");
                                if (eventDetail.eventStartTime.isEmpty) return showErrorToast("You have to select a Event Start Time");
                                if (eventDetail.eventEndTime.isEmpty) return showErrorToast("You have to select a Event End Time");
                              //  if (!eventDetail.isTableAvailableFor10People && !eventDetail.isTableAvailableFor5People)  return showErrorToast("You have to add atleast one table service");

                                print(eventDetail.tableService);
                                 if(!widget.event.isSocialEvent){
                                      if (!eventDetail.earlyBird!.isVisible && !eventDetail.vip!.isVisible && !eventDetail.regular!.isVisible && !eventDetail.skippingLine!.isVisible) return showErrorToast("You have to select atleast one ticket to sell");
                                if (eventDetail.earlyBird!.isVisible) {
                                  if ((eventDetail.earlyBird!.quantity == null || eventDetail.earlyBird!.quantity!.isEmpty) || (eventDetail.earlyBird!.price == null|| eventDetail.earlyBird!.price!.isEmpty ) || eventDetail.earlyBird!.closingDate.isEmpty) {
                                    return showErrorToast("You have to fill Early Bird fields");
                                  }
                                }
                                if (eventDetail.regular!.isVisible) {
                                  if ((eventDetail.regular!.quantity == null  || eventDetail.regular!.quantity!.isEmpty) || (eventDetail.regular!.price == null || eventDetail.regular!.price!.isEmpty)) {
                                    return showErrorToast("You have to fill Regular fields");
                                  }
                                }

                                if (eventDetail.vip!.isVisible) {
                                  if ((eventDetail.vip!.quantity==null || eventDetail.vip!.quantity!.isEmpty) ||  eventDetail.vip!.price == null || eventDetail.vip!.price!.isEmpty) {
                                    return showErrorToast("You have to fill VIP fields");
                                  }
                                }

                                if (eventDetail.skippingLine!.isVisible) {
                                  if ((eventDetail.skippingLine!.quantity == null  || eventDetail.skippingLine!.quantity!.isEmpty) || (eventDetail.skippingLine!.price == null || eventDetail.skippingLine!.price!.isEmpty)) {
                                    return showErrorToast("You have to fill Skipping Line fields");
                                  }
                                }


                                // if (eventDetail.isTableAvailableFor4People){
                                //   if(eventDetail.tblFourPeopleCost.isEmpty){
                                //     return showErrorToast("You have to add amount for 4 People");
                                //   }
                                // }
                                //
                                //  if (eventDetail.isTableAvailableFor6People){
                                //   if(eventDetail.tblSixPeopleCost.isEmpty){
                                //     return showErrorToast("You have to add amount for 6 People");
                                //   }
                                // }
                                //
                                //   if (eventDetail.isTableAvailableFor8People){
                                //   if(eventDetail.tblEightPeopleCost.isEmpty){
                                //     return showErrorToast("You have to add amount for 8 People");
                                //   }
                                // }
                                //
                                // if (eventDetail.isTableAvailableFor10People){
                                //   if(eventDetail.tblTenPeopleCost.isEmpty){
                                //     return showErrorToast("You have to add amount for 10 People");
                                //   }
                                // }

                               // }
                                // if(event.discountPercent!.isEmpty) return showErrorToast("You have to select a Event End Time");
                                //  if(event.minTicketsDiscount!.isEmpty) return showErrorToast("You have to select a Event End Time");
              if(eventDetail.earlyBird!.isVisible)    eventDetail.earlyBird!.ticket= "Early Bird";
              if(eventDetail.regular!.isVisible)        eventDetail.regular!.ticket= "Regular";
              if(eventDetail.vip!.isVisible)            eventDetail.vip!.ticket= "VIP";
              if(eventDetail.skippingLine!.isVisible)            eventDetail.skippingLine!.ticket= "Skipping Line";

                if(eventDetail.vip!.isVisible) {
                   eventDetail.list!.add(eventDetail.vip!.toJson());
                }
                else if(!eventDetail.vip!.isVisible && widget.event.vip!.price!.isNotEmpty)  widget.event.removedTickets!.add(eventDetail.vip!.toJson());


                 if(eventDetail.regular!.isVisible) {
                   eventDetail.list!.add(eventDetail.regular!.toJson());
                 } else if(!eventDetail.regular!.isVisible && widget.event.regular!.price!.isNotEmpty)  widget.event.removedTickets!.add(eventDetail.regular);



                if(eventDetail.skippingLine!.isVisible) {
                  eventDetail.list!.add(eventDetail.skippingLine!.toJson());
                } else if(!eventDetail.skippingLine!.isVisible && widget.event.skippingLine!.price!.isNotEmpty)  widget.event.removedTickets!.add(eventDetail.skippingLine);



                  if(eventDetail.earlyBird!.isVisible)  {
                   eventDetail.list!.add(eventDetail.earlyBird);
                 }
                 else if(!eventDetail.earlyBird!.isVisible && widget.event.earlyBird!.price!.isNotEmpty)  widget.event.removedTickets!.add(eventDetail.earlyBird!.toJson());

                                 }
                                }

                                CustomNavigator.navigateTo(context, EditCreateThirdPage(event: eventDetail, selectedEventEndTime: eventDetail.eventEndTime, selectedEventStartTime: eventDetail.eventStartTime));

                              }
                            },
                            child: Text('Next'.toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold,)),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget dateContainer(size, text, icon) {
    return Container(
      height: 44,
      width: size.width / 2.5,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: globalLGray,
            blurRadius: 3,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(icon, size: 12),
          Text(text, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300)),
          Icon(Icons.arrow_drop_down, size: 18),
        ],
      ),
    );
  }

  Widget smallContainer(value, size) {
    return Container(
      width: size.width / 6,
      height: 20,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: globalLGray,
            blurRadius: 3,
          )
        ],
      ),
      child: Center(
        child: Text(
          value,
          style: TextStyle(fontSize: 12),
        ),
      ),
    );
  }


 Widget text({String? title, Color? color, double? fontSize, FontWeight?  fontWeight}){
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(title!, style: TextStyle(color: color, fontSize: fontSize!, fontWeight: fontWeight)),
    );
}

}

class TextConstants {
  static final headingStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
}
