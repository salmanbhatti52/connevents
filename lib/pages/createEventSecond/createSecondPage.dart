import 'package:connevents/models/create-event-model.dart';
import 'package:connevents/pages/createEvent/createPage.dart';
import 'package:connevents/pages/createEventThird/createThirdPage.dart';
import 'package:connevents/pages/editEvent/editCreateSecond/editCreateSecondPage.dart';
import 'package:connevents/utils/date-time.dart';
import 'package:connevents/utils/detect-link.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/connevent-appbar.dart';
import 'package:connevents/widgets/connevents-textfield.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:connevents/widgets/date-container.dart';
import 'package:connevents/widgets/table-service-textfield.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
TimeOfDay? selectedEventStartTime;
TimeOfDay? selectedEventEndTime;
class CreateSecondPage extends StatefulWidget {

 final bool isEdit;
  final EventDetail event;
  const CreateSecondPage({Key? key,required this.event,this.isEdit=false}) : super(key: key);

  @override
  _CreateSecondPageState createState() => _CreateSecondPageState();
}

class _CreateSecondPageState extends State<CreateSecondPage> {

  String? _hour, _minute, _time;
  String? dateTime;
  String regularDate = '';
  String vipDate = '';
  bool isRefundableYes = false;
  bool isRefundableNo = true;
  bool isEarlyBird = false;
  bool isRegular = false;
  bool isVip = false;
  bool link=false;


  final key = GlobalKey<FormState>();
  TextEditingController hyperLink=TextEditingController(text: "https://");

  Future _selectEagleBirdClosingDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null  && picked.toUtc().isBefore(event.pickedEventEndDate!)  || picked!.toUtc().isAtSameMomentAs(event.pickedEventEndDate!)  || picked.toUtc().isAtSameMomentAs(event.pickedEventStartDate!)){
      setState(() {
        print(picked);
        event.earlyBird!.selectedDate = picked;
        event.earlyBird!.selectedDate = event.earlyBird!.selectedDate;
      event.earlyBird!.earlyBird = DateFormat.yMd().format(event.earlyBird!.selectedDate);
      print(event.earlyBird!.earlyBird);
        final f = new DateFormat('yyyy-MM-dd hh:mm');
        event.earlyBird!.closingDate = f.format(event.earlyBird!.selectedDate);
        print(event.earlyBird!.closingDate);
      });
    }
    else{
      showErrorToast("Closing Date Should Not more or less than Event Date & Time");
    }
  }

  Future _selectDate(BuildContext context) async {
        final DateTime? picked = await     showDatePicker(
            context: context,
            initialDate: event.pickedEventStartDate ?? DateTime.now(),
            initialDatePickerMode: DatePickerMode.day,
            firstDate: DateTime.now(),
            lastDate: DateTime(2101));
          if(event.pickedEventEndDate!=null){
            if (picked != null && picked.isAtSameMomentAs(event.pickedEventEndDate!)  ||  picked!.isBefore(event.pickedEventEndDate!)) {
              if(event.eventStartTime.isNotEmpty && event.eventEndTime.isNotEmpty && picked.isAtSameMomentAs(event.pickedEventEndDate!)  &&  toDouble(selectedEventEndTime!) < toDouble(selectedEventStartTime!)){
              return showErrorToast("Event End Time Must be smaller greater than Event End Time");
            }else{
                event.pickedEventStartDate = picked;
                var dateFormat = DateFormat.yMMMd();
                event.eventStartDate = dateFormat.format(event.pickedEventStartDate!);
                setState(() {});
            }
            }
            else  if(event.pickedEventEndDate!.toUtc().isBefore(picked)){
             return showErrorToast("Event Start Date Must be smaller than event End Date");
            }else{
                event.pickedEventStartDate = picked;
                var dateFormat = DateFormat.yMMMd();
                event.eventStartDate = dateFormat.format(event.pickedEventStartDate!);
                setState(() {});
            }
          } else{
                event.pickedEventStartDate = picked;
                var dateFormat = DateFormat.yMMMd();
                event.eventStartDate = dateFormat.format(event.pickedEventStartDate!);
                setState(() {});
          }

  }

  Future _selectDateEnd(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: event.pickedEventEndDate ?? DateTime.now(),
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(2015),
      lastDate: DateTime(2040),
    );
  // var  _startTime = stringToTimeOfDay(event.eventStartTime);
  // var  _endTime = stringToTimeOfDay(event.eventEndTime);


    if(event.pickedEventStartDate!=null){
      if (picked != null && picked.isAtSameMomentAs(event.pickedEventStartDate!)  ||  picked!.isAfter(event.pickedEventStartDate!)) {
       if(event.eventStartTime.isNotEmpty && event.eventEndTime.isNotEmpty && picked.isAtSameMomentAs(event.pickedEventStartDate!)  &&  toDouble(selectedEventEndTime!) < toDouble(selectedEventStartTime!)){
         return showErrorToast("Event End Time Must be  greater than Event Start Time");
       }else{
         setState(() {
          event.pickedEventEndDate = picked;
          event.pickedEventEndDate = event.pickedEventEndDate;
          var i = event.pickedEventEndDate!.isAtSameMomentAs(event.pickedEventStartDate!);
          print(i);
          var dateFormat = DateFormat.yMMMd();
          event.eventEndDate = dateFormat.format(event.pickedEventEndDate!);
        });
       }
      } else {
        showErrorToast("Event end Date Must be selected greater than Event Start Date");
      }
    }
    else showErrorToast("You have to select first event Start Date");
    print(picked);
  }

  Future _selectTime(BuildContext context) async {
    TimeOfDay? _endTime;
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedEventStartTime ?? TimeOfDay(hour: 00, minute: 00),
    );
    final now = new DateTime.now();
    print(now);
    DateTime dt1= DateTime.parse("${event.pickedEventStartDate!.toString().split(" ").first}" + " ${picked!.hour.toString().length==1 ? "0${picked.hour.toString()}": picked.hour.toString()}" + ":${picked.minute.toString().length==1 ? "0${picked.minute.toString()}" : picked.minute.toString()}" + ":00" );
     Duration diff = dt1.difference(DateTime.now());
     print(diff);
    if(diff.isNegative) showErrorToast("You can't  select Previous Time");
      else{
        if(event.pickedEventStartDate!=null && event.pickedEventEndDate!=null) {
        if(event.pickedEventStartDate!.toUtc().isAtSameMomentAs(event.pickedEventEndDate!) && selectedEventEndTime==null){
         if (picked != null){
          setState(() {
          selectedEventStartTime = picked;
          print(selectedEventStartTime);
          _hour = selectedEventStartTime!.hour.toString();
          _minute = selectedEventStartTime!.minute.toString();
          _time = _hour! + ' : ' + _minute!;
          event.eventStartTime = _time!;
          event.eventStartTime = formatDate(DateTime(
              2019, 08, 1, selectedEventStartTime!.hour, selectedEventStartTime!.minute),
              [hh, ':', nn, am]).toString();
        });
      }else {
         showErrorToast("You have to select smaller than event Start Time");
      }
      } else if(event.pickedEventStartDate!.toUtc().isAtSameMomentAs(event.pickedEventEndDate!)){
         if(selectedEventEndTime==null)
       _endTime = stringToTimeOfDay(event.eventEndTime);
         if (  selectedEventEndTime==null ?  toDouble(picked) < toDouble(_endTime!) : toDouble(picked) < toDouble(selectedEventEndTime!)){
          setState(() {
          selectedEventStartTime = picked;
          print(selectedEventStartTime);
          _hour = selectedEventStartTime!.hour.toString();
          _minute = selectedEventStartTime!.minute.toString();
          _time = _hour! + ' : ' + _minute!;
          event.eventStartTime = _time!;
          event.eventStartTime = formatDate(DateTime(
              2019, 08, 1, selectedEventStartTime!.hour, selectedEventStartTime!.minute),
              [hh, ':', nn, am]).toString();
        });
      }else {
         showErrorToast("You have to select smaller than event Start Time");
      }
      }
      else         setState(() {
        selectedEventStartTime = picked;
        print(selectedEventStartTime);
        _hour = selectedEventStartTime!.hour.toString();
        _minute = selectedEventStartTime!.minute.toString();
        _time = _hour! + ' : ' + _minute!;
        event.eventStartTime = _time!;
        event.eventStartTime = formatDate(DateTime(
            2019, 08, 1, selectedEventStartTime!.hour, selectedEventStartTime!.minute),
            [hh, ':', nn, am]).toString();
      });

    }
        else{
      showErrorToast("You have to select First Event Start Date & End Date");
    }
      }


  }

  Future _selectTimeEnd(BuildContext context) async {
    TimeOfDay? _startTime;
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedEventEndTime ?? TimeOfDay(hour: 00, minute: 00),
    );
    if(event.eventStartTime.isNotEmpty){
     if(selectedEventStartTime==null)
    _startTime = stringToTimeOfDay(event.eventStartTime);
    if(event.pickedEventStartDate!.toUtc().isAtSameMomentAs(event.pickedEventEndDate!)){
     if (picked != null &&  selectedEventStartTime==null ?  toDouble(picked) > toDouble(_startTime!) : toDouble(picked!) > toDouble(selectedEventStartTime!) ) {
       setState(() {
         selectedEventEndTime = picked;
         _hour = selectedEventEndTime!.hour.toString();
         _minute = selectedEventEndTime!.minute.toString();
         _time = _hour! + ' : ' + _minute!;
         event.eventEndTime = _time!;
         event.eventEndTime = formatDate(DateTime(
             2019, 08, 1, selectedEventEndTime!.hour, selectedEventEndTime!.minute),
             [hh, ':', nn, am]).toString();
       });
     }
      else showErrorToast("You have to select greater than event Start Time");
     }else if(picked != null){
           setState(() {
        selectedEventEndTime = picked;
        _hour = selectedEventEndTime!.hour.toString();
        _minute = selectedEventEndTime!.minute.toString();
        _time = _hour! + ' : ' + _minute!;
        event.eventEndTime = _time!;
        event.eventEndTime = formatDate(DateTime(2019, 08, 1, selectedEventEndTime!.hour, selectedEventEndTime!.minute),
            [hh, ':', nn, am]).toString();
      });
         }

    }
    else{
      showErrorToast("Please Select Event Start Time");
    }


  }

  @override
  void initState() {
    super.initState();
      event = widget.event;
      event.list = event.list ?? [];

  }

  @override
    Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: ConneventAppBar(),
      body: Container(
        decoration: BoxDecoration(color: globallightbg),
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
                      SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Start Date", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                              SizedBox(height: 6),
                              GestureDetector(
                                  onTap: () => _selectDate(context),
                                  child: dateContainer(size, event.eventStartDate, Icons.calendar_today)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("End Date", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                              SizedBox(height: 6),
                              GestureDetector(
                                  onTap: () => _selectDateEnd(context),
                                  child: dateContainer(size, event.eventEndDate,
                                      Icons.calendar_today)),
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
                              Text("Start Time", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                              SizedBox(height: 6),
                              GestureDetector(
                                  onTap: () => _selectTime(context),
                                  child: dateContainer(size, event.eventStartTime, Icons.watch_later_outlined)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("End Time", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                              SizedBox(height: 6),
                              GestureDetector(
                                  onTap: () => _selectTimeEnd(context),
                                  child: dateContainer(size, event.eventEndTime,
                                      Icons.watch_later_outlined)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 12,),
                      Text("Description*", style: TextConstants.headingStyle),
                      SizedBox(height: 6),
                      ConneventsTextField(
                        value: event.description,
                        onSaved: (value) => event.description = value,
                        validator: (val) => val!.isEmpty ? "Please Enter Description" : null,
                        maxLines: 4,
                      ),
                      SizedBox(height: 6),
                      Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         SizedBox(
                           width: 20,
                           child: Checkbox(
                             value: event.isNotMyEvent,
                             checkColor: globalGreen,
                             onChanged: (val) => setState(() {
                               event.isNotMyEvent = val!;
                               event.isFreeEvent=false;
                             }),
                           ),
                         ),
                         text(title:"Not My Event",fontSize: 14),
                       ],
                          ),
                      if(event.isNotMyEvent)
                      SizedBox(height: 6),
                      if(event.isNotMyEvent)
                      Text("Hyperlink*", style: TextConstants.headingStyle),
                      if(event.isNotMyEvent)
                      SizedBox(height: 6),
                      if(event.isNotMyEvent)
                       ConneventsTextField(
                         controller: hyperLink,
                        keyBoardType: TextInputType.url,
                        onSaved: (value) {
                          bool link = isLink(value!);
                          print(link);
                          if(link){
                            setState(() {
                              hyperLink.text = value;
                          });
                          }
                        },
                       // validator: (val) => val!.isEmpty ? "Please Enter Hyperlink" : null,
                      ),
                      Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         SizedBox(
                           width: 20,
                           child: Checkbox(
                             value: event.isFreeEvent,
                             checkColor: globalGreen,
                             onChanged: (val) => setState(() {
                               event.isFreeEvent = val!;
                               event.isNotMyEvent=false;
                             }),
                           ),
                         ),
                         text(title:"Free Event" , fontSize: 14),
                       ],
                          ),

                    Stack(
                    children: [
                    Column(
                      children: [
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Refundable", style: TextConstants.headingStyle),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (isRefundableYes) setState(() => isRefundableNo = false);
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
                                  child: Center(child: Text("YES", style: TextStyle(color: Colors.black))),
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
                             value: event.earlyBird!.isVisible,
                             checkColor: globalGreen,
                             onChanged: (val) => setState(() => event.earlyBird!.isVisible = val!),
                           ),
                         ),
                         text(title:"Early bird",fontSize: 14),
                       ],
                          ),
                          Visibility(
                       visible: event.earlyBird!.isVisible,
                       child: SizedBox(
                         width: MediaQuery.of(context).size.width/2.4,
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
                                 initialValue: event.earlyBird!.quantity,
                                 onSaved: (value) => setState(() => event.earlyBird!.quantity = value!),
                                 keyboardType: TextInputType.number,
                                 textAlign: TextAlign.center,
                                 inputFormatters: [LengthLimitingTextInputFormatter(4)],
                                 decoration: InputDecoration.collapsed(hintText: ""),
                               ),
                             ),
                             Row(
                               children: [
                                 text(title:"\$" ,fontSize: 14),
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
                                     initialValue: event.earlyBird!.price,
                                     keyboardType: TextInputType.number,
                                     textAlign: TextAlign.center,
                                     inputFormatters: [LengthLimitingTextInputFormatter(4)],
                                     onSaved: (value) => setState(() {
                                       event.earlyBird!.price = value!;
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
                      Visibility(
                        visible: event.earlyBird!.isVisible,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                       text(title: "Closing Date",fontSize: 14),
                       GestureDetector(
                           onTap: () => _selectEagleBirdClosingDate(context),
                           child: dateContainer(size*1.05, event.earlyBird!.earlyBird, Icons.calendar_today)),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 20,
                                child: Checkbox(
                                  value: event.regular!.isVisible,
                                  checkColor: globalGreen,
                                  activeColor: globalGreen,
                                  onChanged: (val) => setState(() => event.regular!.isVisible = val!),
                                ),
                              ),
                              text(title:"Regular",fontSize: 14),
                            ],
                          ),
                          Visibility(
                            visible: event.regular!.isVisible,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width/2.4,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 25,
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
                                      initialValue: event.regular!.quantity,
                                      onSaved: (value) => setState(() => event.regular!.quantity = value!),
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
                                          initialValue: event.regular!.price,
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          inputFormatters: [LengthLimitingTextInputFormatter(4)],
                                          onSaved: (value) => setState(() {
                                            event.regular!.price = value!;
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
                                width: 20,
                                child: Checkbox(
                                  value: event.vip!.isVisible,
                                  checkColor: globalGreen,
                                  activeColor: globalGreen,
                                  onChanged: (val) => setState(() {
                                  // if(event.isTableAvailableFor4People || event.isTableAvailableFor6People || event.isTableAvailableFor6People || event.isTableAvailableFor10People ){
                                  //   return showErrorToast("You can't deselect thi after including Table Service");
                                  // }
                                  // else
                                    event.vip!.isVisible = val!;
                                  }),
                                ),
                              ),
                              text(title:"VIP",fontSize: 14),
                            ],
                          ),
                          Visibility(
                            visible: event.vip!.isVisible,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width/2.4,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 25,
                                    width: MediaQuery.of(context).size.width/6.5,
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
                                      initialValue: event.vip!.quantity,
                                      onSaved: (value) => setState(() => event.vip!.quantity = value!),
                                      textAlign: TextAlign.center,
                                      inputFormatters: [LengthLimitingTextInputFormatter(4)],
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration.collapsed(
                                          hintText: ""),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left:25.0),
                                    child: Row(
                                      children: [
                                        Text("\$", style: TextStyle(fontSize: 14)),
                                        SizedBox(width: 6),
                                        Container(
                                          height: 23,
                                          width: MediaQuery.of(context).size.width/6.5,
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
                                            initialValue: event.vip!.price,
                                            keyboardType: TextInputType.number,
                                            textAlign: TextAlign.center,
                                            inputFormatters: [LengthLimitingTextInputFormatter(4)],
                                            onSaved: (value) => setState(() => event.vip!.price = value!),
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
                                  width: 20,
                                  child: Checkbox(
                                    value: event.skippingLine!.isVisible,
                                    checkColor: globalGreen,
                                    activeColor: globalGreen,
                                    onChanged: (val) => setState(() {
                                      // if(event.isTableAvailableFor4People || event.isTableAvailableFor6People || event.isTableAvailableFor6People || event.isTableAvailableFor10People ){
                                      //   return showErrorToast("You can't deselect thi after including Table Service");
                                      // }
                                      // else
                                        event.skippingLine!.isVisible = val!;
                                    }),
                                  ),
                                ),
                                text(title:"Skipping Line",fontSize: 14),
                              ],
                            ),
                            Visibility(
                              visible: event.skippingLine!.isVisible,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width/2.4,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 25,
                                      width: MediaQuery.of(context).size.width/6.5,
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
                                        initialValue: event.skippingLine!.quantity,
                                        onSaved: (value) => setState(() => event.skippingLine!.quantity = value!),
                                        textAlign: TextAlign.center,
                                        inputFormatters: [LengthLimitingTextInputFormatter(4)],
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration.collapsed(
                                            hintText: ""),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left:25.0),
                                      child: Row(
                                        children: [
                                          Text("\$", style: TextStyle(fontSize: 14)),
                                          SizedBox(width: 6),
                                          Container(
                                            height: 23,
                                            width: MediaQuery.of(context).size.width/6.5,
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
                                              initialValue: event.skippingLine!.price,
                                              keyboardType: TextInputType.number,
                                              textAlign: TextAlign.center,
                                              inputFormatters: [LengthLimitingTextInputFormatter(4)],
                                              onSaved: (value) => setState(() => event.skippingLine!.price = value!),
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



////-------------------------------------------------------------------------------------/////////
  //  --------------------Table Services-------------------------------------------///////////////////
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.start,
  //                       children: [
  //                         Text("Table Services", style: TextConstants.headingStyle),
  //                       ],
  //                     ),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Row(
  //                           children: [
  //                             SizedBox(
  //                               width:20,
  //                               child: Checkbox(
  //                                 value: event.isTableAvailableFor4People,
  //                                 checkColor: globalGreen,
  //                                 activeColor: globalGreen,
  //                                 onChanged: (val) {
  //                                   setState(() {
  //                                      if(event.vip!.isVisible)
  //                                         event.isTableAvailableFor4People = val!;
  //                                      else{
  //                                        return showErrorToast("You have to select Skipping Line");
  //                                      }
  //                                   });
  //                                 } ,
  //                               ),
  //                             ),
  //                             text(title:"VIP For 4 People",fontSize: 14),
  //                           ],
  //                         ),
  //
  //                         Visibility(
  //                           visible: event.isTableAvailableFor4People,
  //                           child:  TableServiceTextField(
  //                             initialValue:   event.tblFourPeopleCost.toString(),
  //                             onSaved: (value) => setState(() => event.tblFourPeopleCost = value!),
  //                         ),
  //                         ),
  //                       ],
  //                     ),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Row(
  //                           children: [
  //                             SizedBox(
  //                               width:20,
  //                               child: Checkbox(
  //                                 value: event.isTableAvailableFor6People,
  //                                 checkColor: globalGreen,
  //                                 activeColor: globalGreen,
  //                                 onChanged: (val) {
  //                                   setState(() {
  //                                      if(event.vip!.isVisible)
  //                                         event.isTableAvailableFor6People = val!;
  //                                      else{
  //                                        return showErrorToast("You have to select Skipping Line");
  //                                      }
  //                                   });
  //                                 },
  //                               ),
  //                             ),
  //                             text(title:"VIP For 6 People",fontSize: 14),
  //                           ],
  //                         ),
  //                         Visibility(
  //                           visible: event.isTableAvailableFor6People,
  //                           child:  TableServiceTextField(
  //                             initialValue:   event.tblSixPeopleCost.toString(),
  //                             onSaved: (value) => setState(() => event.tblSixPeopleCost = value!),
  //                         ),
  //                         ),
  //                       ],
  //                     ),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Row(
  //                           children: [
  //                             SizedBox(
  //                               width:20,
  //                               child: Checkbox(
  //                                 value: event.isTableAvailableFor8People,
  //                                 checkColor: globalGreen,
  //                                 activeColor: globalGreen,
  //                                 onChanged: (val) {
  //                                   setState(() {
  //                                      if(event.vip!.isVisible)
  //                                         event.isTableAvailableFor8People = val!;
  //                                      else{
  //                                        return showErrorToast("You have to select Skipping Line");
  //                                      }
  //                                   });
  //                                 },
  //                               ),
  //                             ),
  //                             text(title:"VIP For 8 People",fontSize: 14),
  //                           ],
  //                         ),
  //                         Visibility(
  //                           visible: event.isTableAvailableFor8People,
  //                           child: TableServiceTextField(
  //                             initialValue:   event.tblEightPeopleCost.toString(),
  //                             onSaved: (value) => setState(() => event.tblEightPeopleCost = value!),
  //                           )
  //                         ),
  //                       ],
  //                     ),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Row(
  //                           children: [
  //                             SizedBox(
  //                               width: 20,
  //                               child: Checkbox(
  //                                 value: event.isTableAvailableFor10People,
  //                                 checkColor: globalGreen,
  //                                 activeColor: globalGreen,
  //                                 onChanged: (val) {
  //                                   setState(() {
  //                                      if(event.vip!.isVisible)
  //                                         event.isTableAvailableFor10People = val!;
  //                                      else{
  //                                        return showErrorToast("You have to select Skipping Line");
  //                                      }
  //                                   });
  //                                 },
  //                               ),
  //                             ),
  //                             text(title:"VIP For 10 People",fontSize: 14),
  //                           ],
  //                         ),
  //                         Visibility(
  //                           visible: event.isTableAvailableFor10People,
  //                           child: TableServiceTextField(
  //                             initialValue:    event.tblTenPeopleCost.toString(),
  //                             onSaved: (value) => setState(() =>event.tblTenPeopleCost = value!),
  //                           )
  //                         ),
  //                       ],
  //                     ),
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
                                initialValue: event.minTicketsDiscount,
                                onSaved: (value) => setState(() => event.minTicketsDiscount = value),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                inputFormatters: [LengthLimitingTextInputFormatter(4)],
                                decoration: InputDecoration.collapsed(hintText: ""),
                                  ),
                                ),
                                 DiscountTextField(
                                     initialValue: event.discountPercent ?? "",
                                     onSaved: (value) => setState(() =>event.discountPercent = value),
                                 )

                              ],
                            ),
                          ),


                        ],
                      ),
                      SizedBox(height: padding),
                            ],
                          ),
                    if(event.isNotMyEvent || event.isFreeEvent)
                    Opacity(
                      opacity:0.6,
                      child: Container(
                        color:Colors.grey.shade50,
                        height:310,
                        width : MediaQuery.of(context).size.width,
                            ),
                    )
                        ],
                      ),
                      ////Button
                      SizedBox(
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
                            event.hyperlink=hyperLink.text;
                            if (key.currentState!.validate()) {
                              key.currentState!.save();
                              if(event.isNotMyEvent && event.hyperlink.isEmpty) return showErrorToast("Please Input Valid Link");
                              if(!event.isFreeEvent && !event.isNotMyEvent){
                               if (isRefundableYes) event.refundable = 1; else event.refundable = 0;
                              // if (event.isTableAvailableFor4People) event.tableService = 1;
                              // if (event.isTableAvailableFor6People) event.tableService = 1;
                              // if (event.isTableAvailableFor8People) event.tableService = 1;
                              // if (event.isTableAvailableFor10People) event.tableService = 1;
                              if (event.eventStartDate.isEmpty) return showErrorToast("You have to select a Event Start Date");
                              if (event.eventEndDate.isEmpty) return showErrorToast("You have to select a Event End Date");
                              if (event.eventStartTime.isEmpty) return showErrorToast("You have to select a Event Start Time");
                              if (event.eventEndTime.isEmpty) return showErrorToast("You have to select a Event End Time");
                             // if (!event.isTableAvailableFor10People && !event.isTableAvailableFor5People)  return showErrorToast("You have to add atleast one table service");
                              print(event.tableService);
                              if (!event.earlyBird!.isVisible && !event.vip!.isVisible && !event.regular!.isVisible && !event.skippingLine!.isVisible)
                                return showErrorToast("You have to select atleast one ticket to sell");

                              if (event.earlyBird!.isVisible) {
                                if ((event.earlyBird!.quantity ==null || event.earlyBird!.quantity!.isEmpty) || (event.earlyBird!.price ==null|| event.earlyBird!.price!.isEmpty) || event.earlyBird!.closingDate.isEmpty) {
                                  return showErrorToast("You have to fill Early Bird fields");
                                }
                              }
                              if (event.regular!.isVisible) {
                                if ((event.regular!.quantity ==null  ||event.regular!.quantity!.isEmpty ) || event.regular!.price ==null || event.regular!.price!.isEmpty) {
                                  return showErrorToast("You have to fill Regular fields");
                                }
                              }

                              if (event.vip!.isVisible) {
                                if ((event.vip!.quantity ==null   || event.vip!.quantity!.isEmpty)      || (event.vip!.price ==null  || event.vip!.price!.isEmpty)) {
                                  return showErrorToast("You have to fill VIP fields");
                                }
                              }

                               if (event.skippingLine!.isVisible) {
                                 if ((event.skippingLine!.quantity ==null   || event.skippingLine!.quantity!.isEmpty)      || (event.skippingLine!.price ==null  || event.skippingLine!.price!.isEmpty)) {
                                   return showErrorToast("You have to fill Skipping Line fields");
                                 }
                               }


                              // if (event.isTableAvailableFor4People){
                              //   if(event.tblFourPeopleCost.isEmpty){
                              //     return showErrorToast("You have to add amount for 4 People");
                              //   }
                              // }
                              // if (event.isTableAvailableFor6People){
                              //   if(event.tblSixPeopleCost.isEmpty){
                              //     return showErrorToast("You have to add amount for 6 People");
                              //   }
                              // }
                              // if (event.isTableAvailableFor8People){
                              //   if(event.tblEightPeopleCost.isEmpty){
                              //     return showErrorToast("You have to add amount for 8 People");
                              //   }
                              // }
                              //
                              // if (event.isTableAvailableFor10People){
                              //   if(event.tblTenPeopleCost.isEmpty){
                              //     return showErrorToast("You have to add amount for 10 People");
                              //   }
                              // }
                              
                      if(event.earlyBird!.isVisible)    event.earlyBird!.ticket= "Early Bird";
                      if(event.regular!.isVisible)        event.regular!.ticket= "Regular";
                      if(event.vip!.isVisible)            event.vip!.ticket= "VIP";
                      if(event.skippingLine!.isVisible)            event.skippingLine!.ticket= "Skipping Line";

                 if(event.vip!.isVisible)                   event.list!.add(event.vip!.toJson());
                 if(event.regular!.isVisible)               event.list!.add(event.regular!.toJson());
               if(event.earlyBird!.isVisible)                event.list!.add(event.earlyBird!.toJson());
               if(event.skippingLine!.isVisible)                event.list!.add(event.skippingLine!.toJson());
                              }


                              print(event.list!.toList());

                              CustomNavigator.navigateTo(context, CreateThirdPage(event: event, selectedEventEndTime: selectedEventEndTime!, selectedEventStartTime: selectedEventStartTime!));

                            }
                          },
                          child: Text('Next'.toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold,)),
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





 Widget text({String? title, Color? color, double? fontSize, FontWeight?  fontWeight}){
    return Padding(
      padding: const EdgeInsets.only(left:8.0),
      child: Text(title!, style: TextStyle(color: color, fontSize: fontSize!, fontWeight: fontWeight)),
    );
}

}

