import 'dart:convert';
import 'dart:math';
import 'package:connevents/models/create-event-model.dart';
import 'package:connevents/models/dress-code-model.dart';
import 'package:connevents/pages/confirmCreate/confirmCreatePage.dart';
import 'package:connevents/utils/const.dart';
import 'package:connevents/utils/date-time.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/connevents-textfield.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart'as http;
import 'package:places_service/places_service.dart';

TimeOfDay? createSelectedStartTime;
TimeOfDay? createSelectedEndTime;
class CreateThirdPage extends StatefulWidget {

  final TimeOfDay selectedEventStartTime;
  final TimeOfDay selectedEventEndTime;
  final EventDetail  event;

  const CreateThirdPage({Key? key,required this.selectedEventEndTime,required this.selectedEventStartTime,required this.event}) : super(key: key);

  @override
  State<CreateThirdPage> createState() => _CreateThirdPageState();
}

class _CreateThirdPageState extends State<CreateThirdPage> {
  late  EventDetail event;
  final key = GlobalKey<FormState>();
  String? _hour, _minute, _time;
  TextEditingController selectedAddress=TextEditingController();
  PlacesService  _placesService=PlacesService();
  List<PlacesAutoCompleteResult>  _autoCompleteResult=[];
  String secondaryText="";
  late TextEditingController mainText;
  late TextEditingController city;
  late TextEditingController zip;
  late TextEditingController state;
  PlacesDetails? placeDetails;
  String? dateTime;
  final List<Marker>  markers=[];
  late LatLng latLng;
  LatLng? latlng=LatLng(30.183419, 71.427832);

  DateTime selectedDate = DateTime.now();
  List<DressCodeData> listOfDressCode = [];
  double lat=0.0;
  double lng=0.0;
  static var startShift = DateTime.now();

  Future _selectSalesStartDate(BuildContext context) async {
     final DateTime? picked = await   showDatePicker(
        context: context,
        initialDate: widget.event.pickedSalesStartDate ?? DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
          if(widget.event.pickedSalesEndDate!=null){
          if (picked != null && picked.isAtSameMomentAs(widget.event.pickedSalesEndDate!)  ||  picked!.isBefore(widget.event.pickedSalesEndDate!)) {
           if(widget.event.salesStartTime.isNotEmpty && widget.event.salesEndTime.isNotEmpty && picked.isAtSameMomentAs(widget.event.pickedSalesEndDate!)  &&  toDouble(createSelectedEndTime!) < toDouble(createSelectedStartTime!)){
          return showErrorToast("Event End Time Must be smaller greater than Event End Time");
        }else {
              setState(() {
          widget.event.pickedSalesStartDate = picked;
          widget.event.pickedSalesStartDate = widget.event.pickedSalesStartDate;
          print(widget.event.pickedSalesStartDate);
          var dateFormat = DateFormat.yMMMd();
          widget.event.salesStartDate = dateFormat.format(widget.event.pickedSalesStartDate!);
        });
           }
          }
          if(widget.event.pickedSalesEndDate!.toUtc().isBefore(picked)){
         return showErrorToast("Sales Start Date Must be smaller than event End Date or Sales End Date");
          }
          else{
            if (picked.toUtc().isAtSameMomentAs(widget.event.pickedEventStartDate!)  || picked.toUtc().isAtSameMomentAs(widget.event.pickedEventEndDate!) || picked.toUtc().isBefore(widget.event.pickedEventEndDate!)) {
          setState(() {
          widget.event.pickedSalesStartDate = picked;
          widget.event.pickedSalesStartDate = widget.event.pickedSalesStartDate;
          print(widget.event.pickedSalesStartDate);
          var dateFormat = DateFormat.yMMMd();
          widget.event.salesStartDate = dateFormat.format(widget.event.pickedSalesStartDate!);
        });
    }
    }
      }
    else{
    if (picked != null && picked.toUtc().isAtSameMomentAs(widget.event.pickedEventStartDate!)  || picked!.toUtc().isAtSameMomentAs(widget.event.pickedEventEndDate!) || picked.toUtc().isBefore(widget.event.pickedEventEndDate!)) {
      setState(() {
        widget.event.pickedSalesStartDate = picked;
        widget.event.pickedSalesStartDate = widget.event.pickedSalesStartDate;
        print(widget.event.pickedSalesStartDate);
        var dateFormat = DateFormat.yMMMd();
        widget.event.salesStartDate =
            dateFormat.format(widget.event.pickedSalesStartDate!);
      });
    }
    else showErrorToast("You can't Select greater than Event End Date");
}
}

  Future _selectSalesDateEnd(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: widget.event.pickedSalesEndDate ?? DateTime.now(),
    initialDatePickerMode: DatePickerMode.day,
    firstDate: DateTime(2015),
    lastDate: DateTime(2040));
    if(widget.event.pickedSalesStartDate!=null){
      if (picked != null && (picked.isAtSameMomentAs(widget.event.pickedSalesStartDate!)    || picked.toUtc().isAfter(widget.event.pickedSalesStartDate!))  &&  (picked.isAtSameMomentAs(widget.event.pickedEventEndDate!)  || picked.toUtc().isBefore(widget.event.pickedEventEndDate!)   ) ){
          if(widget.event.salesStartTime.isNotEmpty && widget.event.salesEndTime.isNotEmpty && picked.isAtSameMomentAs(widget.event.pickedSalesStartDate!)  &&  toDouble(createSelectedEndTime!) < toDouble(createSelectedStartTime!)){
         return showErrorToast("Sales End Time Must be greater or equal than Sales Start Time");
       }else{
           setState(() {
          widget.event.pickedSalesEndDate = picked;
          widget.event.pickedSalesEndDate = widget.event.pickedSalesEndDate;
          var i = selectedDate.isAtSameMomentAs(widget.event.pickedSalesStartDate!);
          print(i);
          var dateFormat = DateFormat.yMMMd();
          widget.event.salesEndDate = dateFormat.format(widget.event.pickedSalesEndDate!);
        });
          }
      } else {
        showErrorToast("Sales end Date Must be selected Smaller or equal than Event End Date");
      }
    }
    else  showErrorToast("you have to select Firstly Sales Start Date");

}

  Future _selectSalesStartTime(BuildContext context) async {
  TimeOfDay? _endTime;
  final TimeOfDay? picked = await showTimePicker(
  context: context,
  initialTime: createSelectedStartTime ?? TimeOfDay(hour: 00, minute: 00));
  DateTime dt1= DateTime.parse("${widget.event.pickedSalesStartDate!.toString().split(" ").first}" + " ${picked!.hour.toString().length==1 ? "0${picked.hour.toString()}": picked.hour.toString()}" + ":${picked.minute.toString().length==1 ? "0${picked.minute.toString()}" : picked.minute.toString()}" + ":00" );
     Duration diff = dt1.difference(DateTime.now());
     if(diff.isNegative) showErrorToast("You can't  select Previous Time");
       else {
       if (widget.event.pickedSalesStartDate != null && widget.event.pickedSalesEndDate != null) {
         if (widget.event.pickedSalesStartDate!.toUtc().isAtSameMomentAs(widget.event.pickedSalesEndDate!)) {
             if(widget.event.salesEndTime.isNotEmpty){
               _endTime = stringToTimeOfDay(widget.event.salesEndTime);
               if (toDouble(picked) < toDouble(_endTime)) {
                 setState(() {
                   createSelectedStartTime = picked;
                   _hour = createSelectedStartTime!.hour.toString();
                   _minute = createSelectedStartTime!.minute.toString();
                   _time = _hour! + ' : ' + _minute!;
                   widget.event.salesStartTime = _time!;
                   widget.event.salesStartTime = formatDate(DateTime(
                       2019, 08, 1, createSelectedStartTime!.hour,
                       createSelectedStartTime!.minute),
                       [hh, ':', nn, am]).toString();
                 });
           }
               else {
             showErrorToast("You have to select smaller than event Start Time");
           }
             }else{
                setState(() {
               createSelectedStartTime = picked;
               _hour = createSelectedStartTime!.hour.toString();
               _minute = createSelectedStartTime!.minute.toString();
               _time = _hour! + ' : ' + _minute!;
               widget.event.salesStartTime = _time!;
               widget.event.salesStartTime = formatDate(DateTime(2019, 08, 1, createSelectedStartTime!.hour, createSelectedStartTime!.minute), [hh, ':', nn, am]).toString();
             });
             }
         } else         setState(() {
           createSelectedStartTime = picked;
           _hour = createSelectedStartTime!.hour.toString();
           _minute = createSelectedStartTime!.minute.toString();
           _time = _hour! + ' : ' + _minute!;
           widget.event.salesStartTime = _time!;
           widget.event.salesStartTime = formatDate(DateTime(
               2019, 08, 1, createSelectedStartTime!.hour,
               createSelectedStartTime!.minute),
               [hh, ':', nn, am]).toString();
         });

       }
       else
         showErrorToast("Please select First Sales Start  & End Date");
     }

  }

  Future _selectSalesEndTime(BuildContext context) async {
  TimeOfDay? _startTime;
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: createSelectedEndTime ?? TimeOfDay(hour: 00, minute: 00),
  );
  if(widget.event.salesStartTime.isNotEmpty){
  if(createSelectedStartTime==null)
  _startTime = stringToTimeOfDay(widget.event.salesStartTime);
  if(widget.event.pickedSalesStartDate!.toUtc().isAtSameMomentAs(widget.event.pickedSalesEndDate!)){
    if (picked != null  && createSelectedStartTime==null ?  toDouble(picked) > toDouble(_startTime!) : toDouble(picked!) > toDouble(createSelectedStartTime!)) {
    print(createSelectedEndTime);
    setState(() {
      createSelectedEndTime = picked;
      _hour = createSelectedEndTime!.hour.toString();
      _minute = createSelectedEndTime!.minute.toString();
      _time = _hour! + ' : ' + _minute!;
      widget.event.salesEndTime = _time!;
      widget.event.salesEndTime = formatDate(
          DateTime(2019, 08, 1, createSelectedEndTime!.hour, createSelectedEndTime!.minute),
          [hh, ':', nn, am]).toString();
    });
  }
  else showErrorToast("Sales End Time Must be Greater than Sales Start Time");
  } else if(picked!=null){
            setState(() {
      createSelectedEndTime = picked;
      _hour = createSelectedEndTime!.hour.toString();
      _minute = createSelectedEndTime!.minute.toString();
      _time = _hour! + ' : ' + _minute!;
      widget.event.salesEndTime = _time!;
      widget.event.salesEndTime = formatDate(
          DateTime(2019, 08, 1, createSelectedEndTime!.hour, createSelectedEndTime!.minute),
          [hh, ':', nn, am]).toString();
    });
  }
  }
  else showErrorToast("Please Select Start Time");
}

  void getDressCodes() async {
    try {
      var res = await http.get(Uri.parse("${apiUrl}dress_codes"));
      final data = res.body;
      print(data);
      var json = jsonDecode(data)['data'] as List;
      setState(() {});
      listOfDressCode = json.map<DressCodeData>((e) => DressCodeData.fromJson(e)).toList();
      print(listOfDressCode);
      Navigator.of(context).pop();
    } catch (e) {
      Navigator.of(context).pop();
      print(e.toString());
    }
}

  addMarker(double lat, double long){
   int id=Random().nextInt(100);
    setState(() {
    markers.add(Marker(position: LatLng(widget.event.locationLat!.toDouble(),widget.event.locationLong!.toDouble()) , markerId: MarkerId(id.toString())));
  });
    }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      openLoadingDialog(context, "Loading...");
      getDressCodes();
    });
     var startBreak = startShift.add(Duration(hours: widget.selectedEventStartTime.hour));
    event = widget.event;
    _placesService.initialize(apiKey: apiKey);
    city=TextEditingController(text: widget.event.eventAddress!.city);
    zip=TextEditingController(text: widget.event.eventAddress!.zip);
    state=TextEditingController(text: widget.event.eventAddress!.state);
    mainText=TextEditingController(text: widget.event.eventAddress!.fullAddress);
  }

  @override
  Widget build(BuildContext context) {

     Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
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
        child: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(padding * 2),
            child: Form(
              key: key,
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Stack(
                    children: [
                     Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                       Text('Sales Date & Time*', style: TextStyle(color: globalBlack, fontSize: 18, fontWeight: FontWeight.bold,),),
                       SizedBox(height: padding / 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Start Date', style: TextStyle(color: globalBlack, fontSize: 14, fontWeight: FontWeight.bold)),
                              SizedBox(height: 6),
                              GestureDetector(
                                  onTap:  ()=> _selectSalesStartDate(context),
                                  child: dateContainer(size, widget.event.salesStartDate, Icons.calendar_today)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('End Date', style: TextStyle(color: globalBlack, fontSize: 14, fontWeight: FontWeight.bold)),
                              SizedBox(height: 6),
                              GestureDetector(
                                  onTap:  ()=> _selectSalesDateEnd(context),
                                  child: dateContainer(size, widget.event.salesEndDate, Icons.calendar_today)),


                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: padding),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text('Start Time', style: TextStyle(color: globalBlack, fontSize: 14, fontWeight: FontWeight.bold)),
                             SizedBox(height: 6),
                             GestureDetector(
                                 onTap: ()=>_selectSalesStartTime(context),
                                 child: dateContainer( size, widget.event.salesStartTime, Icons.watch_later_outlined)),
                           ],
                         ),
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text('End Time', style: TextStyle(color: globalBlack, fontSize: 14, fontWeight: FontWeight.bold)),
                           SizedBox(height: 6),
                           GestureDetector(
                              onTap: ()=>_selectSalesEndTime(context),
                                child: dateContainer( size, widget.event.salesEndTime, Icons.watch_later_outlined)),
                         ],
                       ),

                        ],
                      ),

                      SizedBox(height: padding),
                      Text('Dress Code', style: TextStyle(color: globalBlack, fontSize: 18, fontWeight: FontWeight.bold,),),
                      SizedBox(height: padding),
                      dropDownContainer(
                        child: DropdownButton<DressCodeData>(
                            underline: Container(),
                            isExpanded: true,
                            iconEnabledColor: Colors.black,
                            focusColor: Colors.black,
                            hint: Text("Select Category"),
                            icon: Icon(Icons.arrow_drop_down_rounded),
                            items: listOfDressCode.map((value) {
                              return new DropdownMenuItem<DressCodeData>(
                                value: value,
                                child: Text(value.dressCode.toString()),
                              );
                            }).toList(),
                            onChanged: (newValue) => setState((){
                            bool  isAvailable= widget.event.eventTags!.any((element) => element.tagName=="Non alcoholic");
                               if(isAvailable) {
                                 print(newValue!.dressCode);
                                 if (newValue.dressCode == "Casual wear")
                                   return showErrorToast("You can't select this dress code because You have selected Non alcoholic Tag");
                               }
                               else{
                                 widget.event.dressCodeData = newValue;
                               }
                                widget.event.dressCodeData = newValue;


                            }),
                            value: widget.event.dressCodeData),
                      ),
                       ],
                     ),
                    if(widget.event.isNotMyEvent || widget.event.isFreeEvent)
                     Opacity(
                      opacity:0.6,
                      child: Container(
                        color:Colors.grey.shade50,
                        height:300,
                        width : MediaQuery.of(context).size.width,
                            ),
                    )
                    ],
                  ),

                      SizedBox(height: padding),
                      Stack(
                        children: [
                          text(title: "Address*",color:globalBlack,fontSize:18,fontWeight: FontWeight.bold ),
                          Padding(
                            padding: const EdgeInsets.only(top:30.0),
                            child: ConneventsTextField(
                              controller: mainText,
                              onSaved: (value) => widget.event.eventAddress!.fullAddress = value!,
                              onChanged: (value) async {
                                setState(() {
                                  print(value);
                                });
                                final autoCompleteSuggestions = await _placesService.getAutoComplete(value);
                                _autoCompleteResult = autoCompleteSuggestions;
                              },

                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 120.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                    text(title: "City*",color:globalBlack,fontSize:14,fontWeight: FontWeight.w600 ),
                                      SizedBox(height: padding / 2),
                                      Container(
                                        height: 44,
                                        padding: EdgeInsets.symmetric(horizontal: padding),
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
                                          controller: city,
                                          onSaved: (value) => widget.event.eventAddress!.city = value!,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: padding),
                                Expanded(
                                  child: Column(
                                    children: [
                                      text(title: "State*",color:globalBlack,fontSize:14,fontWeight: FontWeight.w600 ),
                                      SizedBox(height: padding / 2),
                                      Container(
                                        height: 44,
                                        padding: EdgeInsets.symmetric(horizontal: padding),
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
                                          controller: state,
                                          onSaved: (value) => widget.event.eventAddress!.state = value!,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: padding),
                                Expanded(
                                  child: Column(
                                    children: [
                                      text(title: "Zip*",color:globalBlack,fontSize:14,fontWeight: FontWeight.bold ),
                                      SizedBox(height: padding / 2),
                                      Container(
                                        height: 44,
                                        padding: EdgeInsets.symmetric(horizontal: padding),
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
                                          controller: zip,
                                          onSaved: (value) => widget.event.eventAddress!.zip = value!,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (_autoCompleteResult.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 90.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black)),
                                height: 140,
                                child: ListView.builder(
                                  itemCount: _autoCompleteResult.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      visualDensity: VisualDensity(
                                          horizontal: 0, vertical: -4),
                                      title: Text(_autoCompleteResult[index].mainText ?? ""),
                                      subtitle: Text(_autoCompleteResult[index].description ?? ""),
                                      onTap: () async {
                                        var id = _autoCompleteResult[index].placeId;
                                        final placeDetails = await _placesService.getPlaceDetails(id!);
                                        setState(() {
                                          zip.text = placeDetails.zip!;
                                          state.text = placeDetails.state!;
                                          city.text = placeDetails.city!;
                                          latlng = LatLng(lat, lng);
                                          widget.event.locationLat = placeDetails.lat!;
                                          widget.event.locationLong = placeDetails.lng!;
                                          mainText.text = "${_autoCompleteResult[index].mainText!} " + _autoCompleteResult[index].secondaryText!;
                                          _autoCompleteResult.clear();
                                          addMarker(widget.event.locationLat!.toDouble(),widget.event.locationLong!.toDouble());
                                        });
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: padding,),
                      Text('Location*', style: TextStyle(color: globalBlack, fontSize: 18, fontWeight: FontWeight.bold,),),
                      SizedBox(height: padding,),
                      Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: globalLGray,
                              blurRadius: 5,
                            ),
                          ],
                         ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: padding),
                              child: Text(mainText.text, style: TextStyle(color: globalBlack.withOpacity(0.5), fontSize: 16, fontWeight: FontWeight.w300, height: 2.3,),), height: 40,
                            ),
                            Expanded(
                                child: GoogleMap(
                               // onMapCreated: onMapCreated,
                                  mapType: MapType.normal,
                                  initialCameraPosition: CameraPosition(
                                  target: LatLng(widget.event.locationLat??22.735110,widget.event.locationLong??75.917380),
                                  zoom: 5.0,
                                ),
                              markers: markers.toSet()
                              //  markers: marker,
                                //onTap: onHandleMarker,
                              ),),


                          ],
                        ),
                      ),

                 Padding(
                   padding: const EdgeInsets.only(top:30.0),
                   child: Container(
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: globalGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () async{
                          print(createSelectedEndTime);

                                if (key.currentState!.validate()) {
                                  key.currentState!.save();
                          if(!widget.event.isFreeEvent && !widget.event.isNotMyEvent){
                        if(widget.event.salesStartDate.isEmpty) return showErrorToast("You have to select a Sales Start Date");
                        if(widget.event.salesEndDate.isEmpty) return showErrorToast("You have to select a Sales End Date");
                        if(widget.event.salesStartTime.isEmpty) return showErrorToast("You have to select a Sales Start Time");
                        if(widget.event.salesEndTime.isEmpty) return showErrorToast("You have to select a Sales End Time");
                         if(widget.event.dressCodeData==null) return showErrorToast("You have to select Dress Code");

                                  }
                      if(widget.event.eventAddress!.fullAddress.isEmpty) return showErrorToast("You have to add Address");
                      if(widget.event.eventAddress!.city.isEmpty) return showErrorToast("You have to enter City");
                      if(widget.event.eventAddress!.state.isEmpty) return showErrorToast("You have to enter state");
                      if(widget.event.eventAddress!.zip.isEmpty) return showErrorToast("You have to enter zip Code");

                          CustomNavigator.navigateTo(context, ConfirmCreatePage(
                            event: event,
                            selectedEventStartTime: widget.selectedEventStartTime,
                            selectedEventEndTime: widget.selectedEventEndTime,
                            selectedSalesEndTime: !widget.event.isFreeEvent &&  !widget.event.isNotMyEvent ? createSelectedEndTime! : TimeOfDay(hour: 12, minute: 12),
                            selectedSalesStartTime: !widget.event.isFreeEvent &&  !widget.event.isNotMyEvent ? createSelectedStartTime! : TimeOfDay(hour: 12, minute: 12),
                          ));
                             }
                        },
                        child: Text('Next'.toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
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
          Text(text, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
          ),
          Icon(Icons.arrow_drop_down, size: 18,),
        ],
      ),
    );
  }
Widget dropDownContainer({required Widget child}){
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
      child:  child,
    );
  }
 Widget text({String? title, Color? color, double? fontSize, FontWeight?  fontWeight}){
    return Text(title!, style: TextStyle(color: color, fontSize: fontSize!, fontWeight: fontWeight));
}

}
