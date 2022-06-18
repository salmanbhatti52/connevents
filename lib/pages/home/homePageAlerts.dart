import 'package:connevents/models/category-model.dart';
import 'package:connevents/models/event-type-model.dart';
import 'package:connevents/pages/createEvent/createPage.dart';
import 'package:connevents/pages/searchResults/searchResultsPage.dart';
import 'package:connevents/services/category-service.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/services/event-type-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class SelectCategories extends StatefulWidget {
  @override
  _SelectCategoriesState createState() => _SelectCategoriesState();
}

class _SelectCategoriesState extends State<SelectCategories> {
  List<EventTypes> listOfEventType = [];
  List<EventTypeCategories> listOfCategoryEvents = [];
  Future<EventTypeList>? futureEventTypeModel;
  Future<EventTypeCategories>? futureCategoryModel;
  void getEventType() async {
      futureEventTypeModel = EventTypeService().get();
      await futureEventTypeModel!.then((value) =>   setState(() => listOfEventType = value.event_types!));
      Navigator.pop(context);
  }

  // void getCategoryEvents() async {
  //     futureCategoryModel = CategoryService().get();
  //     await futureCategoryModel!.then((value) => setState(() => listOfCategoryEvents = value.data!));
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      openLoadingDialog(context, "Loading");
      //getCategoryEvents();
      getEventType();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
      height: 350,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Select Categories", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Text("Select Event Type", style: TextStyle(fontSize: 18),),
                    SizedBox(height: 10,),
                    dropDownContainer(
                    child: DropdownButton<EventTypes>(
                      underline: Container(),
                      isExpanded: true,
                      iconEnabledColor: Colors.black,
                      focusColor: Colors.black,
                      hint: Text("Select Event Type"),
                      icon: Icon(Icons.arrow_drop_down_rounded),
                      items: listOfEventType.map((value) {
                        return new DropdownMenuItem<EventTypes>(
                          value: value,
                          child: Text(value.eventType.toString()),
                        );
                      }).toList(),
                      onChanged: (newValue) => setState(() => event.eventTypeData = newValue!),
                      value: event.eventTypeData,
                    ),
                  ),
                    SizedBox(height: 15,),
                    Text("Select Category", style: TextStyle(fontSize: 18),),
                    SizedBox(height: 10,),
                    dropDownContainer(
                    child: DropdownButton<EventTypeCategories>(
                      underline: Container(),
                      isExpanded: true,
                      iconEnabledColor: Colors.black,
                      focusColor: Colors.black,
                      hint: Text("Select Category"),
                      icon: Icon(Icons.arrow_drop_down_rounded),
                      items: listOfCategoryEvents.map((value) {
                        return new DropdownMenuItem<EventTypeCategories>(
                          value: value,
                          child: Text(value.category.toString()),
                        );
                      }).toList(),
                      onChanged: (newValue) => setState(() => event.category= newValue!),
                      value: event.category,
                    ),
                  ),
                    Padding(
                      padding: const EdgeInsets.only(top:9.0),
                      child: Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: globalGreen,
                          child: Text("GO",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                          onPressed: () async{
                        var res   = await DioService.post('event_search_filter', {
             if(event.eventTypeData!.eventTypeId!=null) "eventTypeFilter": event.eventTypeData!.eventTypeId,
      if(event.category!.categoryId!=null)       "categoryFilter":event.category!.categoryId,
                            });
                          },
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                          ),
                        ),
                      ),
                  ),
                    ),

                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: IconButton(
              onPressed: () =>Navigator.pop(context),
              icon: Icon(Icons.close, size: 35,color: globalGreen),
            ),
          ),
        ],
      ),
    );
  }

  Widget dropDownContainer({required Widget child}) {
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
      child: child,
    );
  }
}

//  SECOND ALERT

class LocationSearchAlert extends StatefulWidget {

  @override
  State<LocationSearchAlert> createState() => _LocationSearchAlertState();
}

class _LocationSearchAlertState extends State<LocationSearchAlert> {
  Widget TextFields({icon, text, void Function(String)? onChanged, }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: TextFormField(
          cursorColor: globalGreen,
          decoration: InputDecoration(
            icon: Icon(icon, size: 30),
            labelText: text,
            labelStyle: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),

          ),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget ListText(text) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 14),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateTime _date = DateTime.now();
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      // elevation: 3,
      backgroundColor: Colors.transparent,
      child: contentBox(context, size, _date),
    );
  }

  contentBox(context, size, _date) {
     List<String>  listOfCountry=["Multan","Islamabad","Karachi","Kolkata","Lahore","Khanewal","Khanate","Murree","Ayubia","Multan","Islamabad","Karachi","Kolkata","Lahore","Khanewal","Khanate","Murree","Ayubia"];
     List<String>  searchCountry=[];
  TextEditingController _controller=TextEditingController();
  

    return Container(
      margin: EdgeInsets.symmetric(vertical: 30),
      width: size.width,
      height: size.height - 100,
      padding: EdgeInsets.all(11.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: globalGreen),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.transparent,
            offset: Offset(0, 2),
            blurRadius: 1,
          ),
        ],
      ),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text("Where?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  SizedBox(height: 20),
                  TextFields(icon:Icons.my_location,text: "Your Location"),
                  SizedBox(height: 7),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: TextField(
               onChanged: (value){
                setState(() {
                  print(value);
                 searchCountry= listOfCountry.where((element) => element.contains(value)).toList();
                      });
              },
              controller: _controller,
              cursorColor: globalGreen,
              decoration: InputDecoration(
                icon: Icon(Icons.search, size: 30),
                labelText: "Search",
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),

              ),

            ),
          ),
        ),
                  SizedBox(height: 7),
                  SingleChildScrollView(
                    child: Container(
                      width: size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child:searchCountry.length !=0 ||_controller.text.isNotEmpty ?  Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: searchCountry.length,
                            itemBuilder: (context,index){
                              return ListTile(
                                title: Text(searchCountry[index]),
                              );
                            }),
                      ): Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: listOfCountry.length,
                            itemBuilder: (context,index){
                              return ListTile(
                                title: Text(listOfCountry[index]),
                              );
                            }),
                      )
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -8,
            right: -4,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.close, size: 32,color: globalGreen),
            ),
          ),
        ],
      ),
    );
  }
}

//  THIRD ALERT

class CalendarAlert extends StatelessWidget {
  // CalendarController _controller ;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateTime _date = DateTime.now();
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      // elevation: 3,
      backgroundColor: Colors.transparent,
      child: contentBox(context, size, _date),
    );
  }

  contentBox(context, size, _date) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 30),
              width: size.width,
              padding: EdgeInsets.all(11.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: globalGreen),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.transparent,
                    offset: Offset(0, 2),
                    blurRadius: 1,
                  ),
                ],
              ),
              child: Column(
                children: [
                  TableCalendar(
                    calendarFormat: CalendarFormat.month,
                    calendarStyle: CalendarStyle(
                      weekendTextStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Colors.black,
                        // height: 1.3333333333333333,
                      ),
                      // renderDaysOfWeek: true,
                      markersMaxCount: 20,
                      outsideTextStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Colors.black,
                      ),
                      todayTextStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: const Color(0xff000000),
                      ),
                    ),
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      weekendStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    headerStyle: HeaderStyle(
                      titleTextStyle: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        color: const Color(0xff000000),
                        height: 1.3333333333333333,
                      ),
                      leftChevronIcon: Icon(
                        Icons.keyboard_arrow_left,
                        size: 25,
                        color: Colors.black,
                      ),
                      formatButtonTextStyle: TextStyle(color: Colors.blue),
                      rightChevronIcon: Icon(
                        Icons.keyboard_arrow_right,
                        size: 25,
                        color: Colors.black,
                      ),
                      formatButtonVisible: false,
                    ),
                    currentDay: DateTime.now(),
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: DateTime.now(),
                    calendarBuilders: CalendarBuilders(
                      selectedBuilder: (context, date, events) => Container(
                        margin: const EdgeInsets.all(10.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: globalGreen,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Text(
                          _date.day.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: const Color(0xff000000),
                          ),
                        ),
                      ),
                      todayBuilder: (context, _date, events) => Container(
                        height: 25,
                        width: 25,
                        margin: const EdgeInsets.all(10.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(15)),
                        child: Text(
                          _date.day.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Colors.white,
                            // height: 1.3333333333333333,
                          ),
                        ),
                      ),
                    ),
                    // calendarController: _controller,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: globalGreen,
                        child: Text("GO",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                        onPressed: () {
                          Navigator.pop(context);
                          CustomNavigator.navigateTo(context, SearchResultsPage());

                          // Navigator.pushNamed(context, '/searchResults');
                        },
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }




}
