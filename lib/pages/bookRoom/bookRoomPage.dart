import 'dart:convert';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:connevents/mixins/data.dart';
import 'package:connevents/pages/bookRoom/bookRoomPageALert.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/src/intl/date_format.dart';
import 'package:uuid/uuid.dart';



class BookRoomPage extends StatefulWidget {
  num? eventPostId;
   BookRoomPage({Key? key,this.eventPostId}) : super(key: key);

  @override
  State<BookRoomPage> createState() => _BookRoomPageState();
}

class _BookRoomPageState extends State<BookRoomPage> {

  final _users = <int>[];
  final _infoStrings = <String>[];
  RtcEngine? _engine;
   final String channelName="";
  final String userName="";
  final bool isBroadcaster=false;
  var uuid = Uuid();



  String? _hour, _minute, _time;
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;
  String startTime="";
  String endTime="";
  String startDate="";
  String endDate="";
  DateTime? pickedStartDate;
  DateTime? pickedEndDate;
  String tempToken="";
  String uid="";
  var meetingCode="";
  var sec=3600;


    Future<void> getToken() async {
           openLoadingDialog(context, 'creating');
           meetingCode  = uuid.v4().substring(0,8);
       final response = await http.get(
         Uri.parse('https://agora-node-tokenserver.davidcaleb.repl.co/access_token?channelName=$meetingCode'
          // To add expiry time uncomment the below given line with the time in seconds
           //+ '?expiry=$sec'
          ),
    );
    if (response.statusCode == 200) {
      setState(() {
      var  token = response.body;
        tempToken = jsonDecode(token)['token'];
        print(tempToken);
        createRoom();
      });
    } else {
      print('Failed to fetch the token');
    }
 }


  TextEditingController description= TextEditingController();

  Future  createRoom() async {
 openLoadingDialog(context, 'creating');
     meetingCode  = uuid.v4().substring(0,8);
    var   response = await DioService.post('create_host_room', {
        "usersId": AppData().userdetail!.users_id,
        "eventPostId" : widget.eventPostId,
        "liveDate" : startDate,
        "liveEndDate" : endDate,
        "liveStartTime" : startTime,
        "liveEndTime" : endTime,
        "description":description.text,
        "channelName":meetingCode
      });
    Navigator.of(context).pop();
 showErrorToast(response);
    if (response['status'] == 'success') {
          showDialog(
          context: context,
              builder: (BuildContext context) {
                return BookRoomPageAlerts(message: response['data']);
              });
       setState(() {});
    } else if(response['status'] == 'error'){
      showErrorToast(response['message']);
    }
}

  Future _selectDate(BuildContext context) async {
        final DateTime? picked = await     showDatePicker(
            context: context,
            initialDate: pickedStartDate ?? DateTime.now(),
            initialDatePickerMode: DatePickerMode.day,
            firstDate: DateTime.now(),
            lastDate: DateTime(2101));
         //    print(DateFormat('hh:mm:ss').format(DateTime.now()));
       //      TimeOfDay? timeOfDay;
     //   final localizations = MaterialLocalizations.of(context);
        // final formattedTimeOfDay = localizations.formatTimeOfDay(TimeOfDay.now());
        //
        //     if(selectedStartTime!=null && toDouble(selectedStartTime!) < toDouble(TimeOfDay.now())){
        //       return showErrorToast('Start Time Should be greater than Current Time');
        //     }else

              if( (pickedEndDate!=null &&  picked!.isAfter(pickedEndDate!))   || (pickedEndDate!=null  && picked!.difference(pickedEndDate!).inDays < -1)){
              var dateFormat = DateFormat.yMMMd();
              startDate = dateFormat.format(picked);
              endDate = dateFormat.format(picked);
              pickedEndDate=picked;
              pickedStartDate = picked;
              setState(() {});
            }

            else{
              pickedStartDate = picked;
              var dateFormat = DateFormat.yMMMd();
              startDate = dateFormat.format(pickedStartDate!);
              setState(() {});
            }
        //showErrorToast(picked!.difference(pickedEndDate!).inDays.toString());


  }

  Future _selectEndDate(BuildContext context) async {
    final DateTime? picked = await     showDatePicker(
        context: context,
        initialDate: pickedEndDate ?? DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    print(DateFormat('hh:mm:ss').format(DateTime.now()));
    TimeOfDay? timeOfDay;
    final localizations = MaterialLocalizations.of(context);
  //  final formattedTimeOfDay = localizations.formatTimeOfDay(TimeOfDay.now());
    // print(formattedTimeOfDay);
    // print(selectedStartTime);
    // print(TimeOfDay.now());
    // if(selectedStartTime!=null && toDouble(selectedStartTime!) < toDouble(TimeOfDay.now()) && ){
    //   return showErrorToast('Start Time Should be greater than Current Time');
    // }else
      if( (pickedStartDate!=null &&  picked!.isBefore(pickedStartDate!)  || (pickedStartDate!=null  && picked!.difference(pickedStartDate!).inDays > 1) )){
      var dateFormat = DateFormat.yMMMd();
      startDate = dateFormat.format(picked);
      endDate = dateFormat.format(picked);
      pickedEndDate=picked;
      pickedStartDate = picked;
      setState(() {});
    }else{
      pickedEndDate = picked;
      var dateFormat = DateFormat.yMMMd();
      endDate = dateFormat.format(pickedEndDate!);
      setState(() {});
    }
  }

  Future _selectTime(BuildContext context) async {
    TimeOfDay? _endTime;
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedStartTime ?? TimeOfDay(hour: 00, minute: 00),
    );
       final DateTime now = DateTime.now();
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final String formatted = formatter.format(now);
    // print(formatted);
        DateTime dt1= DateTime.parse("${formatted.toString().split(" ").first}" + " ${picked!.hour.toString().length==1 ? "0${picked.hour.toString()}": picked.hour.toString()}" + ":${picked.minute.toString().length==1 ? "0${picked.minute.toString()}" : picked.minute.toString()}" + ":00" );
    // print(dt1);
        Duration diff = dt1.difference(DateTime.now());
        DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
       var startDate=dateFormat.format(pickedStartDate!).split(' ').first;
       var currentDate=dateFormat.format(DateTime.now()).split(' ').first;
      //print(DateTime.parse(startDate).toUtc().isAtSameMomentAs(DateTime.parse(currentDate)));
    // if(DateTime.parse(startDate).toUtc().isAtSameMomentAs(DateTime.parse(currentDate))){
    //   if(diff.isNegative) showErrorToast("You can't  select Previous Time");
    //   else
    //   if(picked!=null && pickedStartDate!=null){
    //     setState(() {
    //       selectedStartTime = picked;
    //       print(selectedStartTime);
    //       _hour = selectedStartTime!.hour.toString();
    //       _minute = selectedStartTime!.minute.toString();
    //       _time = _hour! + ' : ' + _minute!;
    //       //  event.eventStartTime = _time!;
    //       startTime= formatDate(DateTime(
    //           2019, 08, 1, selectedStartTime!.hour, selectedStartTime!.minute),
    //           [hh, ':', nn, am]).toString();
    //     });
    //   }
    //   else{
    //     showErrorToast("Please Select Date First");
    //   }
    // }
    // else{
    if((pickedStartDate!=null && pickedEndDate!=null )){
       // if(toDouble(picked) > toDouble(selectedEndTime!)){
       //   return  showErrorToast("Start Time Should be smaller than End Time");
       // }
       // else
        setState(() {
          selectedStartTime = picked;
          print(selectedStartTime);
          _hour = selectedStartTime!.hour.toString();
          _minute = selectedStartTime!.minute.toString();
          _time = _hour! + ' : ' + _minute!;
          //  event.eventStartTime = _time!;
          startTime= formatDate(DateTime(
              2019, 08, 1, selectedStartTime!.hour, selectedStartTime!.minute),
              [hh, ':', nn, am]).toString();
        });
      }
      else{
        showErrorToast("Please Select Date First");
      }

   // }

    }

  Future _selectTimeEnd(BuildContext context) async {
    TimeOfDay? _endTime;
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedEndTime ?? TimeOfDay(hour: 00, minute: 00),
    );
       if(picked!=null && selectedStartTime!=null){
        // if(toDouble(picked) > toDouble(selectedStartTime!)){
           setState(() {
             selectedEndTime = picked;
             print(selectedEndTime);
             _hour = selectedEndTime!.hour.toString();
             _minute = selectedEndTime!.minute.toString();
             _time = _hour! + ' : ' + _minute!;
             endTime= formatDate(DateTime(
                 2019, 08, 1, selectedEndTime!.hour, selectedEndTime!.minute),
                 [hh, ':', nn, am]).toString();
           });
        // }
         //else showErrorToast("Please select greater than  Start Time");
    }
       else{
         showErrorToast('Please select start time first');
       }
    }


  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          children: [
            TextButton(
              onPressed: () =>Navigator.pop(context),
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
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(left: padding * 2, right: padding * 2, top: padding * 2, bottom: padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Create Host Room', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: globalBlack)),
                      SizedBox(height: padding),
                      Row(
                        children: [
                          Text('Live Date & Time', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: globalBlack)),
                          Text('*', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red)),
                        ],
                      ),
                      SizedBox(height: padding / 2),
                      Text('Date', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: globalBlack)),
                      Padding(
                        padding: const EdgeInsets.only(top:12.0,bottom:12.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                      onTap: () => _selectDate(context),
                                      child: dateContainer(size, startDate, Icons.calendar_today)),
                            ),
                            SizedBox(width: padding),
                            Expanded(
                              child: GestureDetector(
                                  onTap: () => _selectEndDate(context),
                                  child: dateContainer(size, endDate, Icons.calendar_today)),
                            ),
                          ],
                        ),
                      ),
                      Text('Time', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: globalBlack)),
                      Padding(
                        padding: const EdgeInsets.only(top:12.0,bottom:12.0),
                        child: Row(
                          children: [
                            Expanded(
                              child:  GestureDetector(
                                onTap: () => _selectTime(context),
                                child: dateContainer(size, startTime, Icons.watch_later_outlined)),
                            ),
                            SizedBox(width: padding),
                            Expanded(
                              child:GestureDetector(
                                onTap: () => _selectTimeEnd(context),
                                child: dateContainer(size, endTime, Icons.watch_later_outlined)) ,
                            ),
                          ],
                        ),
                      ),
                      Text('Description', style: TextStyle(color: globalBlack, fontSize: 18, fontWeight: FontWeight.bold,),),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: globalLGray,
                              blurRadius: 3,
                            )
                          ],
                        ),
                        margin: const EdgeInsets.symmetric(vertical: padding / 2),
                        child: TextFormField(
                          controller: description,
                          style: TextStyle(color: globalBlack, fontSize: 12, fontWeight: FontWeight.normal),
                          decoration: InputDecoration(
                            hintText: 'Briefly describe here...',
                            hintStyle: TextStyle(
                              color: globalBlack.withOpacity(0.5),
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          minLines: 5,
                          maxLines: 5,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: padding, horizontal: padding * 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Expanded(
                  //   child: SizedBox(
                  //     height: 44,
                  //     child: TextButton(
                  //       style: TextButton.styleFrom(
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(30),
                  //           side: BorderSide(
                  //             color: globalGreen,
                  //             width: 2,
                  //           ),
                  //         ),
                  //       ),
                  //       onPressed: () {},
                  //       child: Text('INVITE', style: TextStyle(color: globalGreen, fontSize: 16, fontWeight: FontWeight.bold),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(width: padding / 2),
                  Expanded(
                    child: SizedBox(
                      height: 44,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: globalGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: BorderSide(
                              color: globalGreen,
                              width: 2,
                            ),
                          ),
                        ),
                        onPressed: () async {
                          if(startDate.isEmpty) return showErrorToast("Please Select Start Date");
                          if(startTime.isEmpty) return showErrorToast("Please Select Start Time");
                          if(endTime.isEmpty) return showErrorToast("Please Select End Time");
                          if(description.text.isEmpty) return showErrorToast("Please Enter Some Description");
                          createRoom();
                        },
                        child: Text('Create'.toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


   Widget dateContainer(size, text, icon) {
    return Container(
      height: 40,
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
      child: Padding(
        padding: const EdgeInsets.only(left:12.0,right: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, size: 12),
            Text(text, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300)),
            Icon(Icons.arrow_drop_down, size: 18),
          ],
        ),
      ),
    );
  }


}
