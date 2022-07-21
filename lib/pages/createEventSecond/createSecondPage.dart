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
  TextEditingController socialLink = TextEditingController();

  Future _selectEagleBirdClosingDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null  && picked.toUtc().isBefore(widget.event.pickedEventEndDate!)  || picked!.toUtc().isAtSameMomentAs(widget.event.pickedEventEndDate!)  || picked.toUtc().isAtSameMomentAs(widget.event.pickedEventStartDate!)){
      setState(() {
        print(picked);
        widget.event.earlyBird!.selectedDate = picked;
        widget.event.earlyBird!.selectedDate = widget.event.earlyBird!.selectedDate;
        widget.event.earlyBird!.earlyBird = DateFormat.yMd().format(widget.event.earlyBird!.selectedDate);
        print(widget.event.earlyBird!.earlyBird);
        final f = new DateFormat('yyyy-MM-dd hh:mm');
        widget.event.earlyBird!.closingDate = f.format(widget.event.earlyBird!.selectedDate);
        print(widget.event.earlyBird!.closingDate);
      });
    }
    else{
      showErrorToast("Closing Date Should Not more or less than Event Date & Time");
    }
  }

  Future _selectDate(BuildContext context) async {
        final DateTime? picked = await     showDatePicker(
            context: context,
            initialDate: widget.event.pickedEventStartDate ?? DateTime.now(),
            initialDatePickerMode: DatePickerMode.day,
            firstDate: DateTime.now(),
            lastDate: DateTime(2101));
          if(widget.event.pickedEventEndDate!=null){
            if (picked != null && picked.isAtSameMomentAs(widget.event.pickedEventEndDate!)  ||  picked!.isBefore(widget.event.pickedEventEndDate!)) {
              if(widget.event.eventStartTime.isNotEmpty && widget.event.eventEndTime.isNotEmpty && picked.isAtSameMomentAs(widget.event.pickedEventEndDate!)  &&  toDouble(selectedEventEndTime!) < toDouble(selectedEventStartTime!)){
              return showErrorToast("Event End Time Must be smaller greater than Event End Time");
            }else{
                widget.event.pickedEventStartDate = picked;
                var dateFormat = DateFormat.yMMMd();
                widget.event.eventStartDate = dateFormat.format(widget.event.pickedEventStartDate!);
                setState(() {});
            }
            }
            else  if(widget.event.pickedEventEndDate!.toUtc().isBefore(picked)){
             return showErrorToast("Event Start Date Must be smaller than event End Date");
            }else{
                widget.event.pickedEventStartDate = picked;
                var dateFormat = DateFormat.yMMMd();
                widget.event.eventStartDate = dateFormat.format(widget.event.pickedEventStartDate!);
                setState(() {});
            }
          } else{
                widget.event.pickedEventStartDate = picked;
                var dateFormat = DateFormat.yMMMd();
                widget.event.eventStartDate = dateFormat.format(widget.event.pickedEventStartDate!);
                setState(() {});
          }

  }

  Future _selectDateEnd(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.event.pickedEventEndDate ?? DateTime.now(),
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(2015),
      lastDate: DateTime(2040),
    );
  // var  _startTime = stringToTimeOfDay(widget.event.eventStartTime);
  // var  _endTime = stringToTimeOfDay(widget.event.eventEndTime);


    if(widget.event.pickedEventStartDate!=null){
      if (picked != null && picked.isAtSameMomentAs(widget.event.pickedEventStartDate!)  ||  picked!.isAfter(widget.event.pickedEventStartDate!)) {
       if(widget.event.eventStartTime.isNotEmpty && widget.event.eventEndTime.isNotEmpty && picked.isAtSameMomentAs(widget.event.pickedEventStartDate!)  &&  toDouble(selectedEventEndTime!) < toDouble(selectedEventStartTime!)){
         return showErrorToast("Event End Time Must be  greater than Event Start Time");
       }else{
         setState(() {
          widget.event.pickedEventEndDate = picked;
          widget.event.pickedEventEndDate = widget.event.pickedEventEndDate;
          var i = widget.event.pickedEventEndDate!.isAtSameMomentAs(widget.event.pickedEventStartDate!);
          print(i);
          var dateFormat = DateFormat.yMMMd();
          widget.event.eventEndDate = dateFormat.format(widget.event.pickedEventEndDate!);
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
    DateTime dt1= DateTime.parse("${widget.event.pickedEventStartDate!.toString().split(" ").first}" + " ${picked!.hour.toString().length==1 ? "0${picked.hour.toString()}": picked.hour.toString()}" + ":${picked.minute.toString().length==1 ? "0${picked.minute.toString()}" : picked.minute.toString()}" + ":00" );
     Duration diff = dt1.difference(DateTime.now());
     print(diff);
    if(diff.isNegative) showErrorToast("You can't  select Previous Time");
      else{
        if(widget.event.pickedEventStartDate!=null && widget.event.pickedEventEndDate!=null) {
        if(widget.event.pickedEventStartDate!.toUtc().isAtSameMomentAs(widget.event.pickedEventEndDate!) && selectedEventEndTime==null){
         if (picked != null){
          setState(() {
          selectedEventStartTime = picked;
          print(selectedEventStartTime);
          _hour = selectedEventStartTime!.hour.toString();
          _minute = selectedEventStartTime!.minute.toString();
          _time = _hour! + ' : ' + _minute!;
          widget.event.eventStartTime = _time!;
          widget.event.eventStartTime = formatDate(DateTime(
              2019, 08, 1, selectedEventStartTime!.hour, selectedEventStartTime!.minute),
              [hh, ':', nn, am]).toString();
        });
      }else {
         showErrorToast("You have to select smaller than event Start Time");
      }
      } else if(widget.event.pickedEventStartDate!.toUtc().isAtSameMomentAs(widget.event.pickedEventEndDate!)){
         if(selectedEventEndTime==null)
       _endTime = stringToTimeOfDay(widget.event.eventEndTime);
         if (  selectedEventEndTime==null ?  toDouble(picked) < toDouble(_endTime!) : toDouble(picked) < toDouble(selectedEventEndTime!)){
          setState(() {
          selectedEventStartTime = picked;
          print(selectedEventStartTime);
          _hour = selectedEventStartTime!.hour.toString();
          _minute = selectedEventStartTime!.minute.toString();
          _time = _hour! + ' : ' + _minute!;
          widget.event.eventStartTime = _time!;
          widget.event.eventStartTime = formatDate(DateTime(
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
        widget.event.eventStartTime = _time!;
        widget.event.eventStartTime = formatDate(DateTime(
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
    if(widget.event.eventStartTime.isNotEmpty){
     if(selectedEventStartTime==null)
    _startTime = stringToTimeOfDay(widget.event.eventStartTime);
    if(widget.event.pickedEventStartDate!.toUtc().isAtSameMomentAs(widget.event.pickedEventEndDate!)){
     if (picked != null &&  selectedEventStartTime==null ?  toDouble(picked) > toDouble(_startTime!) : toDouble(picked!) > toDouble(selectedEventStartTime!) ) {
       setState(() {
         selectedEventEndTime = picked;
         _hour = selectedEventEndTime!.hour.toString();
         _minute = selectedEventEndTime!.minute.toString();
         _time = _hour! + ' : ' + _minute!;
         widget.event.eventEndTime = _time!;
         widget.event.eventEndTime = formatDate(DateTime(
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
        widget.event.eventEndTime = _time!;
        widget.event.eventEndTime = formatDate(DateTime(2019, 08, 1, selectedEventEndTime!.hour, selectedEventEndTime!.minute),
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
      widget.event.list = widget.event.list ?? [];

  }
  String stringReplacement(
      String mainString, String subString
      ){

    return mainString.replaceAll(subString, "");
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
                                  child: dateContainer(size, widget.event.eventStartDate, Icons.calendar_today)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("End Date", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                              SizedBox(height: 6),
                              GestureDetector(
                                  onTap: () => _selectDateEnd(context),
                                  child: dateContainer(size, widget.event.eventEndDate,
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
                                  child: dateContainer(size, widget.event.eventStartTime, Icons.watch_later_outlined)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("End Time", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                              SizedBox(height: 6),
                              GestureDetector(
                                  onTap: () => _selectTimeEnd(context),
                                  child: dateContainer(size, widget.event.eventEndTime,
                                      Icons.watch_later_outlined)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 12,),
                      Text("Description*", style: TextConstants.headingStyle),
                      SizedBox(height: 6),
                      ConneventsTextField(
                        value: widget.event.description,
                        onSaved: (value) => widget.event.description = value,
                        validator: (val) => val!.isEmpty ? "Please Enter Description" : null,
                        maxLines: 4,
                      ),
                      SizedBox(height: 6),
                      if(!widget.event.isNotMyEvent)
                        Text('Website', style: TextStyle(color: globalBlack, fontSize: 18, fontWeight: FontWeight.bold,),),
                      if(!widget.event.isNotMyEvent)
                        SizedBox(height: 10),
                      if(!widget.event.isNotMyEvent)
                        ConneventsTextField(
                          onChanged: (e){
                            if(socialLink.text.contains('https://'))
                              socialLink.text = stringReplacement(socialLink.text,"https://");
                          },
                          controller: socialLink,
                          onSaved: (value) => widget.event.socialLink = value!,
                        ),
                      if(!widget.event.isNotMyEvent)
                        SizedBox(height: padding),
                      Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         SizedBox(
                           width: 20,
                           child: Checkbox(
                             value: widget.event.isNotMyEvent,
                             checkColor: globalGreen,
                             onChanged: (val) => setState(() {
                               widget.event.isNotMyEvent = val!;
                               widget.event.isFreeEvent=false;
                             }),
                           ),
                         ),
                         text(title:"Not My Event",fontSize: 14),
                       ],
                          ),
                      if(widget.event.isNotMyEvent)
                      SizedBox(height: 6),
                      if(widget.event.isNotMyEvent)
                      Text("Hyper Link*", style: TextConstants.headingStyle),
                      if(widget.event.isNotMyEvent)
                      SizedBox(height: 6),
                      if(widget.event.isNotMyEvent)
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
                             value: widget.event.isFreeEvent,
                             checkColor: globalGreen,
                             onChanged: (val) => setState(() {
                               print("testing data${val}");
                               widget.event.isFreeEvent = val!;
                               widget.event.isNotMyEvent=false;
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
                             value: widget.event.earlyBird!.isVisible,
                             checkColor: globalGreen,
                             onChanged: (val) => setState(() => widget.event.earlyBird!.isVisible = val!),
                           ),
                         ),
                         text(title:"Early bird",fontSize: 14),
                       ],
                          ),
                          Visibility(
                       visible: widget.event.earlyBird!.isVisible,
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
                                 initialValue: widget.event.earlyBird!.quantity,
                                 onSaved: (value) => setState(() => widget.event.earlyBird!.quantity = value!),
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
                                     initialValue: widget.event.earlyBird!.price,
                                     keyboardType: TextInputType.number,
                                     textAlign: TextAlign.center,
                                     inputFormatters: [LengthLimitingTextInputFormatter(4)],
                                     onSaved: (value) => setState(() {
                                       widget.event.earlyBird!.price = value!;
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
                        visible: widget.event.earlyBird!.isVisible,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                       text(title: "Closing Date",fontSize: 14),
                       GestureDetector(
                           onTap: () => _selectEagleBirdClosingDate(context),
                           child: dateContainer(size*1.05, widget.event.earlyBird!.earlyBird, Icons.calendar_today)),
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
                                  value: widget.event.regular!.isVisible,
                                  checkColor: globalGreen,
                                  activeColor: globalGreen,
                                  onChanged: (val) => setState(() => widget.event.regular!.isVisible = val!),
                                ),
                              ),
                              text(title:"Regular",fontSize: 14),
                            ],
                          ),
                          Visibility(
                            visible: widget.event.regular!.isVisible,
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
                                      initialValue: widget.event.regular!.quantity,
                                      onSaved: (value) => setState(() => widget.event.regular!.quantity = value!),
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
                                          initialValue: widget.event.regular!.price,
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          inputFormatters: [LengthLimitingTextInputFormatter(4)],
                                          onSaved: (value) => setState(() {
                                            widget.event.regular!.price = value!;
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
                                  value: widget.event.vip!.isVisible,
                                  checkColor: globalGreen,
                                  activeColor: globalGreen,
                                  onChanged: (val) => setState(() {
                                  // if(widget.event.isTableAvailableFor4People || widget.event.isTableAvailableFor6People || widget.event.isTableAvailableFor6People || widget.event.isTableAvailableFor10People ){
                                  //   return showErrorToast("You can't deselect thi after including Table Service");
                                  // }
                                  // else
                                    widget.event.vip!.isVisible = val!;
                                  }),
                                ),
                              ),
                              text(title:"VIP",fontSize: 14),
                            ],
                          ),
                          Visibility(
                            visible: widget.event.vip!.isVisible,
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
                                      initialValue: widget.event.vip!.quantity,
                                      onSaved: (value) => setState(() => widget.event.vip!.quantity = value!),
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
                                            initialValue: widget.event.vip!.price,
                                            keyboardType: TextInputType.number,
                                            textAlign: TextAlign.center,
                                            inputFormatters: [LengthLimitingTextInputFormatter(4)],
                                            onSaved: (value) => setState(() => widget.event.vip!.price = value!),
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
                                    value: widget.event.skippingLine!.isVisible,
                                    checkColor: globalGreen,
                                    activeColor: globalGreen,
                                    onChanged: (val) => setState(() {
                                      // if(widget.event.isTableAvailableFor4People || widget.event.isTableAvailableFor6People || widget.event.isTableAvailableFor6People || widget.event.isTableAvailableFor10People ){
                                      //   return showErrorToast("You can't deselect thi after including Table Service");
                                      // }
                                      // else
                                        widget.event.skippingLine!.isVisible = val!;
                                    }),
                                  ),
                                ),
                                text(title:"Skipping Line",fontSize: 14),
                              ],
                            ),
                            Visibility(
                              visible: widget.event.skippingLine!.isVisible,
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
                                        initialValue: widget.event.skippingLine!.quantity,
                                        onSaved: (value) => setState(() => widget.event.skippingLine!.quantity = value!),
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
                                              initialValue: widget.event.skippingLine!.price,
                                              keyboardType: TextInputType.number,
                                              textAlign: TextAlign.center,
                                              inputFormatters: [LengthLimitingTextInputFormatter(4)],
                                              onSaved: (value) => setState(() => widget.event.skippingLine!.price = value!),
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
  //                                 value: widget.event.isTableAvailableFor4People,
  //                                 checkColor: globalGreen,
  //                                 activeColor: globalGreen,
  //                                 onChanged: (val) {
  //                                   setState(() {
  //                                      if(widget.event.vip!.isVisible)
  //                                         widget.event.isTableAvailableFor4People = val!;
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
  //                           visible: widget.event.isTableAvailableFor4People,
  //                           child:  TableServiceTextField(
  //                             initialValue:   widget.event.tblFourPeopleCost.toString(),
  //                             onSaved: (value) => setState(() => widget.event.tblFourPeopleCost = value!),
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
  //                                 value: widget.event.isTableAvailableFor6People,
  //                                 checkColor: globalGreen,
  //                                 activeColor: globalGreen,
  //                                 onChanged: (val) {
  //                                   setState(() {
  //                                      if(widget.event.vip!.isVisible)
  //                                         widget.event.isTableAvailableFor6People = val!;
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
  //                           visible: widget.event.isTableAvailableFor6People,
  //                           child:  TableServiceTextField(
  //                             initialValue:   widget.event.tblSixPeopleCost.toString(),
  //                             onSaved: (value) => setState(() => widget.event.tblSixPeopleCost = value!),
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
  //                                 value: widget.event.isTableAvailableFor8People,
  //                                 checkColor: globalGreen,
  //                                 activeColor: globalGreen,
  //                                 onChanged: (val) {
  //                                   setState(() {
  //                                      if(widget.event.vip!.isVisible)
  //                                         widget.event.isTableAvailableFor8People = val!;
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
  //                           visible: widget.event.isTableAvailableFor8People,
  //                           child: TableServiceTextField(
  //                             initialValue:   widget.event.tblEightPeopleCost.toString(),
  //                             onSaved: (value) => setState(() => widget.event.tblEightPeopleCost = value!),
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
  //                                 value: widget.event.isTableAvailableFor10People,
  //                                 checkColor: globalGreen,
  //                                 activeColor: globalGreen,
  //                                 onChanged: (val) {
  //                                   setState(() {
  //                                      if(widget.event.vip!.isVisible)
  //                                         widget.event.isTableAvailableFor10People = val!;
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
  //                           visible: widget.event.isTableAvailableFor10People,
  //                           child: TableServiceTextField(
  //                             initialValue:    widget.event.tblTenPeopleCost.toString(),
  //                             onSaved: (value) => setState(() =>widget.event.tblTenPeopleCost = value!),
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
                                initialValue: widget.event.minTicketsDiscount,
                                onSaved: (value) => setState(() => widget.event.minTicketsDiscount = value),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                inputFormatters: [LengthLimitingTextInputFormatter(4)],
                                decoration: InputDecoration.collapsed(hintText: ""),
                                  ),
                                ),
                                 DiscountTextField(
                                     initialValue: widget.event.discountPercent ?? "",
                                     onSaved: (value) => setState(() =>widget.event.discountPercent = value),
                                 )

                              ],
                            ),
                          ),


                        ],
                      ),
                      SizedBox(height: padding),
                            ],
                          ),
                    if(widget.event.isNotMyEvent || widget.event.isFreeEvent)
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
                            widget.event.hyperlink=hyperLink.text;
                            if (key.currentState!.validate()) {
                              key.currentState!.save();
                              if(widget.event.isNotMyEvent && widget.event.hyperlink.isEmpty) return showErrorToast("Please Input Valid Link");
                              if(!widget.event.isFreeEvent && !widget.event.isNotMyEvent){
                               if (isRefundableYes) widget.event.refundable = 1; else widget.event.refundable = 0;
                              // if (widget.event.isTableAvailableFor4People) widget.event.tableService = 1;
                              // if (widget.event.isTableAvailableFor6People) widget.event.tableService = 1;
                              // if (widget.event.isTableAvailableFor8People) widget.event.tableService = 1;
                              // if (widget.event.isTableAvailableFor10People) widget.event.tableService = 1;
                              if (widget.event.eventStartDate.isEmpty) return showErrorToast("You have to select a Event Start Date");
                              if (widget.event.eventEndDate.isEmpty) return showErrorToast("You have to select a Event End Date");
                              if (widget.event.eventStartTime.isEmpty) return showErrorToast("You have to select a Event Start Time");
                              if (widget.event.eventEndTime.isEmpty) return showErrorToast("You have to select a Event End Time");
                             // if (!widget.event.isTableAvailableFor10People && !widget.event.isTableAvailableFor5People)  return showErrorToast("You have to add atleast one table service");
                              print(widget.event.tableService);
                              if (!widget.event.earlyBird!.isVisible && !widget.event.vip!.isVisible && !widget.event.regular!.isVisible && !widget.event.skippingLine!.isVisible)
                                return showErrorToast("You have to select atleast one ticket to sell");

                              if (widget.event.earlyBird!.isVisible) {
                                if ((widget.event.earlyBird!.quantity ==null || widget.event.earlyBird!.quantity!.isEmpty) || (widget.event.earlyBird!.price ==null|| widget.event.earlyBird!.price!.isEmpty) || widget.event.earlyBird!.closingDate.isEmpty) {
                                  return showErrorToast("You have to fill Early Bird fields");
                                }
                              }
                              if (widget.event.regular!.isVisible) {
                                if ((widget.event.regular!.quantity ==null  ||widget.event.regular!.quantity!.isEmpty ) || widget.event.regular!.price ==null || widget.event.regular!.price!.isEmpty) {
                                  return showErrorToast("You have to fill Regular fields");
                                }
                              }

                              if (widget.event.vip!.isVisible) {
                                if ((widget.event.vip!.quantity ==null   || widget.event.vip!.quantity!.isEmpty)      || (widget.event.vip!.price ==null  || widget.event.vip!.price!.isEmpty)) {
                                  return showErrorToast("You have to fill VIP fields");
                                }
                              }

                               if (widget.event.skippingLine!.isVisible) {
                                 if ((widget.event.skippingLine!.quantity ==null   || widget.event.skippingLine!.quantity!.isEmpty)      || (widget.event.skippingLine!.price ==null  || widget.event.skippingLine!.price!.isEmpty)) {
                                   return showErrorToast("You have to fill Skipping Line fields");
                                 }
                               }


                              // if (widget.event.isTableAvailableFor4People){
                              //   if(widget.event.tblFourPeopleCost.isEmpty){
                              //     return showErrorToast("You have to add amount for 4 People");
                              //   }
                              // }
                              // if (widget.event.isTableAvailableFor6People){
                              //   if(widget.event.tblSixPeopleCost.isEmpty){
                              //     return showErrorToast("You have to add amount for 6 People");
                              //   }
                              // }
                              // if (widget.event.isTableAvailableFor8People){
                              //   if(widget.event.tblEightPeopleCost.isEmpty){
                              //     return showErrorToast("You have to add amount for 8 People");
                              //   }
                              // }
                              //
                              // if (widget.event.isTableAvailableFor10People){F
                              //   if(widget.event.tblTenPeopleCost.isEmpty){
                              //     return showErrorToast("You have to add amount for 10 People");
                              //   }
                              // }
                              
                      if(widget.event.earlyBird!.isVisible)    widget.event.earlyBird!.ticket= "Early Bird";
                      if(widget.event.regular!.isVisible)        widget.event.regular!.ticket= "Regular";
                      if(widget.event.vip!.isVisible)            widget.event.vip!.ticket= "VIP";
                      if(widget.event.skippingLine!.isVisible)            widget.event.skippingLine!.ticket= "Skipping Line";

                 if(widget.event.vip!.isVisible)                   widget.event.list!.add(widget.event.vip!.toJson());
                 if(widget.event.regular!.isVisible)               widget.event.list!.add(widget.event.regular!.toJson());
               if(widget.event.earlyBird!.isVisible)                widget.event.list!.add(widget.event.earlyBird!.toJson());
               if(widget.event.skippingLine!.isVisible)                widget.event.list!.add(widget.event.skippingLine!.toJson());
                              }


                              print(widget.event.list!.toList());

                              CustomNavigator.navigateTo(context, CreateThirdPage(event: widget.event, selectedEventEndTime: selectedEventEndTime!, selectedEventStartTime: selectedEventStartTime!));

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

