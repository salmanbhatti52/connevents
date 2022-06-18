import 'package:connevents/variables/globalVariables.dart';
import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';

class EventLibraryPageAlerts extends StatelessWidget {
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