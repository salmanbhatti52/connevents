import 'package:connevents/pages/searchResults/searchResultsPage.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:table_calendar/table_calendar.dart';

class FavoritePageAlerts extends StatelessWidget {
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
    final List<Map<String, dynamic>> _items = [
      {
        'value': 'boxValue',
        'label': 'Box Label',
        'icon': Icon(Icons.stop),
      },
      {
        'value': 'circleValue',
        'label': 'Circle Label',
        'icon': Icon(Icons.fiber_manual_record),
        'textStyle': TextStyle(color: Colors.red),
      },
      {
        'value': 'starValue',
        'label': 'Star Label',
        'enable': false,
        'icon': Icon(Icons.grade),
      },
    ];
    return Container(
      height: 300,
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
                  child: Text(
                    "Select Categories",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                ),
                // SizedBox(height: 5,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Select Event Type",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(50),
                            blurRadius: 5,
                            offset: Offset(2.0, 3.0),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: SelectFormField(
                          initialValue: 'circle',
                          labelText: 'Corporate Events',
                          style: TextStyle(fontSize: 14),
                          items: _items,
                          onChanged: (val) => print(val),
                          onSaved: (val) => print(val),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Select Category",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(50),
                            blurRadius: 5,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: SelectFormField(
                          initialValue: 'circle',
                          labelText: 'Seminars',
                          style: TextStyle(fontSize: 14),
                          items: _items,
                          onChanged: (val) => print(val),
                          onSaved: (val) => print(val),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.close,
                size: 35,
                color: globalGreen,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//  SECOND ALERT

class LocationSearchAlert extends StatelessWidget {
  Widget TextFields(icon, text) {
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
            icon: Icon(
              icon,
              size: 30,
            ),
            labelText: text,
            labelStyle: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
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
    return SingleChildScrollView(
      child: Container(
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text("City", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  SizedBox(
                    height: 20,
                  ),
                  TextFields(Icons.my_location, "Your Location"),
                  SizedBox(
                    height: 7,
                  ),
                  TextFields(Icons.search, "Search"),
                  SizedBox(
                    height: 7,
                  ),
                  Container(
                    width: size.width,
                    height: size.height - 320,
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
                      child: SingleChildScrollView(
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListText("Multan"),
                            ListText("Lahore"),
                            ListText("Islamabad"),
                            ListText("Karachi"),
                            ListText("Multan"),
                            ListText("Islamabad"),
                            ListText("Multan"),
                            ListText("Lahore"),
                            ListText("Islamabad"),
                            ListText("Multan"),
                            ListText("Multan"),
                            ListText("Islamabad"),
                            ListText("Lahore"),
                            ListText("Multan"),
                            ListText("Islamabad"),
                            ListText("Multan"),
                            ListText("Multan"),
                            ListText("Islamabad"),
                            ListText("Lahore"),
                            ListText("Multan"),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: -8,
              right: -4,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close,
                  size: 32,
                  color: globalGreen,
                ),
              ),
            ),
          ],
        ),
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
                        child: Text(
                          "GO",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w800),
                        ),
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
