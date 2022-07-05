import 'dart:convert';
import 'dart:math';
import 'package:connevents/models/create-event-model.dart';
import 'package:connevents/models/dress-code-model.dart';
import 'package:connevents/pages/editEvent/editConfirmCreate/editConfirmCreatePage.dart';
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


class EditCreateThirdPage extends StatefulWidget {
  final String selectedEventStartTime;
 final String selectedEventEndTime;
  final EventDetail  event;

  const EditCreateThirdPage({Key? key,required this.selectedEventEndTime,required this.selectedEventStartTime,required this.event}) : super(key: key);

  @override
  State<EditCreateThirdPage> createState() => _EditCreateThirdPageState();
}

class _EditCreateThirdPageState extends State<EditCreateThirdPage> {
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
    LatLng? latlng=LatLng(30.183419, 71.427832);
    TimeOfDay selectedStartTime = TimeOfDay(hour: 00, minute: 00);
    TimeOfDay selectedEndTime = TimeOfDay(hour: 00, minute: 00);
    DateTime selectedDate = DateTime.now();
    List<DressCodeData> listOfDressCode = [];
    // DressCodeData? dressCode;
    double lat=0.0;
    double lng=0.0;

  Future _selectDate(BuildContext context) async {
 final DateTime? picked = await   showDatePicker(
        context: context,
        initialDate: event.pickedSalesStartDate ?? DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101),);
        if (picked != null && (picked.toUtc().isAtSameMomentAs(event.pickedEventStartDate!)  || picked.toUtc().isAtSameMomentAs(event.pickedEventEndDate!) || picked.toUtc().isBefore(event.pickedEventEndDate!)) && (picked.toUtc().isBefore(event.pickedSalesEndDate!) || picked.isAtSameMomentAs(event.pickedSalesEndDate!) )) {
          if(picked.isAtSameMomentAs(event.pickedSalesEndDate!)  &&  toDouble(selectedEndTime) < toDouble(selectedStartTime)){
          return showErrorToast("Event End Time Must be smaller greater than Event End Time");
        } else
        setState(() {
        event.pickedSalesStartDate = picked;
        event.pickedSalesStartDate = event.pickedSalesStartDate;
        print(event.pickedSalesStartDate);
        var dateFormat = DateFormat.yMMMd();
        event.salesStartDate = dateFormat.format(event.pickedSalesStartDate!);
      });
    }
      else{
        showErrorToast("Sales Date should be more or less than Event Start & End Date");
      }
  }

  Future _selectDateEnd(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: event.pickedSalesEndDate ?? DateTime.now() ,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(2015),
      lastDate: DateTime(2040),
    );
    if (picked != null && (picked.isAtSameMomentAs(event.pickedSalesStartDate!)  || picked.toUtc().isAfter(event.pickedSalesStartDate!)) &&  (picked.isAtSameMomentAs(event.pickedEventEndDate!)  || picked.toUtc().isBefore(event.pickedEventEndDate!)) ) {
       if(event.salesStartTime.isNotEmpty && event.salesEndTime.isNotEmpty && picked.isAtSameMomentAs(event.pickedSalesStartDate!)  &&  toDouble(selectedEndTime) < toDouble(selectedStartTime)){
         return showErrorToast("Sales End Time Must be greater or equal than Sales Start Time");
       }
      else
      setState(() {
        event.pickedSalesEndDate = picked;
        event.pickedSalesEndDate = event.pickedSalesEndDate;
        var i = selectedDate.isAtSameMomentAs(event.pickedSalesStartDate!);
        print(i);
        var dateFormat = DateFormat.yMMMd();
        event.salesEndDate = dateFormat.format(event.pickedSalesEndDate!);
      });
    } else {
      showErrorToast("Sales end Date Must be selected greater than Event Start Date");
    }
  }

  Future _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedStartTime,
    );
    if(event.pickedSalesStartDate!.toUtc().isAtSameMomentAs(event.pickedSalesEndDate!)){
      if(toDouble(picked!) < toDouble(selectedEndTime)){
       setState(() {
        selectedStartTime = picked;
       _hour = selectedStartTime.hour.toString();
       _minute = selectedStartTime.minute.toString();
       _time = _hour! + ' : ' + _minute!;
       event.salesStartTime = _time!;
       event.salesStartTime = formatDate(
       DateTime(
          2019, 08, 1, selectedStartTime.hour, selectedStartTime.minute),
      [hh, ':', nn, am]).toString();
         });
      }
      else  {
      showErrorToast("Sales Start Time should be smaller than End Time");
  }
    }
    else if (picked != null)
       setState(() {
       selectedStartTime = picked;
       _hour = selectedStartTime.hour.toString();
       _minute = selectedStartTime.minute.toString();
      _time = _hour! + ' : ' + _minute!;
      event.salesStartTime = _time!;
      event.salesStartTime = formatDate(
      DateTime(
          2019, 08, 1, selectedStartTime.hour, selectedStartTime.minute),
      [hh, ':', nn, am]).toString();
         });
  }

  Future _selectTimeEnd(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedEndTime,
    );
    if (picked != null) {
      if(event.pickedSalesStartDate!.toUtc().isAtSameMomentAs(event.pickedSalesEndDate!)){
        if( toDouble(picked) > toDouble(selectedStartTime)){
          setState(() {
        selectedEndTime = picked;
        _hour = selectedEndTime.hour.toString();
        _minute = selectedEndTime.minute.toString();
        _time = _hour! + ' : ' + _minute!;
        event.salesEndTime = _time!;
        event.salesEndTime = formatDate(
            DateTime(2019, 08, 1, selectedEndTime.hour, selectedEndTime.minute),
            [hh, ':', nn, am]).toString();
      });
        } else  {
          showErrorToast("Sales End Time should be greater than Start Time");
         }
      }else     print(selectedEndTime);
     setState(() {
      selectedEndTime = picked;
      _hour = selectedEndTime.hour.toString();
      _minute = selectedEndTime.minute.toString();
      _time = _hour! + ' : ' + _minute!;
      event.salesEndTime = _time!;

      event.salesEndTime = formatDate(
          DateTime(2019, 08, 1, selectedEndTime.hour, selectedEndTime.minute),
          [hh, ':', nn, am]).toString();
    });

    }
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


  final List<Marker>  markers=[];
  late LatLng latLng;

   addMarker(double lat, double long){
   int id=Random().nextInt(100);
  setState(() {
  markers.add(Marker(position: LatLng(event.locationLat!.toDouble(),event.locationLong!.toDouble()) , markerId: MarkerId(id.toString())));
});
 }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      openLoadingDialog(context, "loading");
      getDressCodes();
    });
     event = widget.event;
     var dateFormat = DateFormat.yMMMd();
    _placesService.initialize(apiKey: apiKey);
        selectedStartTime     = stringToTimeOfDay(event.salesStartTime);
        selectedEndTime = stringToTimeOfDay(event.salesEndTime);
        event.pickedSalesStartDate=dateFormat.parse(event.salesStartDate);
        print(event.pickedSalesStartDate);
        event.pickedSalesEndDate=dateFormat.parse(event.salesEndDate);


    city=TextEditingController(text: event.eventAddress!.city);
    zip=TextEditingController(text: event.eventAddress!.zip);
    state=TextEditingController(text: event.eventAddress!.state);
    mainText=TextEditingController(text: event.eventAddress!.fullAddress);
  }

  @override
  Widget build(BuildContext context) {

     print(event.toJson());
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
          physics: BouncingScrollPhysics(),
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
                   children:[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:[
                      Text('Sales Date & Time*', style: TextStyle(color: globalBlack, fontSize: 18, fontWeight: FontWeight.bold,),),
                      SizedBox(height: padding / 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Start Date', style: TextStyle(color: globalBlack, fontSize: 14, fontWeight: FontWeight.bold,),),
                              SizedBox(height: 6),
                              GestureDetector(
                                  onTap:  ()=> _selectDate(context),
                                  child: dateContainer(size, event.salesStartDate, Icons.calendar_today)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('End Date', style: TextStyle(color: globalBlack, fontSize: 14, fontWeight: FontWeight.bold,),),
                              SizedBox(height: 6),
                              GestureDetector(
                                  onTap:  ()=> _selectDateEnd(context),
                                  child: dateContainer(size, event.salesEndDate, Icons.calendar_today)),

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
                             Text('Start Time', style: TextStyle(color: globalBlack, fontSize: 14, fontWeight: FontWeight.bold,),),
                             SizedBox(height: 6),
                             GestureDetector(
                                 onTap: ()=>_selectTime(context),
                                 child: dateContainer( size, event.salesStartTime, Icons.watch_later_outlined)),

                           ],
                         ),
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text('End Time', style: TextStyle(color: globalBlack, fontSize: 14, fontWeight: FontWeight.bold,),),
                           SizedBox(height: 6),
                           GestureDetector(
                              onTap: ()=>_selectTimeEnd(context),
                                child: dateContainer( size, event.salesEndTime, Icons.watch_later_outlined)),
                         ],
                       ),
                        ],
                      ),
                      SizedBox(width: padding),
                      SizedBox(height: padding),
                      Text('Dress Code', style: TextStyle(color: globalBlack, fontSize: 18, fontWeight: FontWeight.bold)),
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
                              value: event.dressCode),
                        ),

                     ]),
                    if(widget.event.eventTicketType == "MyFreeEvent" || widget.event.eventTicketType=="NotMyEvent")
                    Opacity(
                      opacity:0.6,
                      child: Container(
                        color:Colors.grey.shade50,
                        height:MediaQuery.of(context).size.height/2.5,
                        width : MediaQuery.of(context).size.width,
                            ),
                    )
                    ]
                  ) ,
                      SizedBox(height: padding),
                      Stack(
                        children: [
                          text(title: "Address*",color:globalBlack,fontSize:18,fontWeight: FontWeight.bold ),
                          Padding(
                            padding: const EdgeInsets.only(top:30.0),
                            child: ConneventsTextField(
                              controller: mainText,
                              onSaved: (value) => event.eventAddress!.fullAddress = value!,
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
                                          onSaved: (value) => event.eventAddress!.city = value!,
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
                                          onSaved: (value) => event.eventAddress!.state = value!,
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
                                          onSaved: (value) => event.eventAddress!.zip = value!,
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
                                          event.locationLat = placeDetails.lat!;
                                          event.locationLong = placeDetails.lng!;
                                          mainText.text = "${_autoCompleteResult[index].mainText!} " + _autoCompleteResult[index].secondaryText!;
                                          _autoCompleteResult.clear();
                                          addMarker(event.locationLat!.toDouble(),event.locationLong!.toDouble());
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
                                  target: LatLng(event.locationLat??22.735110,event.locationLong??75.917380),
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
                                if (key.currentState!.validate()) {
                                  key.currentState!.save();
                      if(event.eventTicketType=="Paid"){
                        if(event.salesStartDate.isEmpty) return showErrorToast("You have to select a Sales Start Date");
                        if(event.salesEndDate.isEmpty) return showErrorToast("You have to select a Sales End Date");
                        if(event.salesStartTime.isEmpty) return showErrorToast("You have to select a Sales Start Time");
                        if(event.salesEndTime.isEmpty) return showErrorToast("You have to select a Sales End Time");
                        if(event.dressCode==null) return showErrorToast("You have to select Dress Code");
                      }

                      if(event.eventAddress!.fullAddress.isEmpty) return showErrorToast("You have to add Address");
                      if(event.eventAddress!.city.isEmpty) return showErrorToast("You have to enter City");
                      if(event.eventAddress!.state.isEmpty) return showErrorToast("You have to enter state");
                      if(event.eventAddress!.zip.isEmpty) return showErrorToast("You have to enter zip Code");

                          CustomNavigator.navigateTo(context, EditConfirmCreatePage(
                            event: event,
                            selectedEventStartTime: widget.selectedEventStartTime,
                            selectedEventEndTime: widget.selectedEventEndTime,
                            selectedSalesEndTime: selectedEndTime,
                            selectedSalesStartTime: selectedStartTime,

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
