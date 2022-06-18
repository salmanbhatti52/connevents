import 'package:connevents/pages/BaseTabCreatePage/Base-Tab-Create-Page.dart';
import 'package:connevents/pages/Dashboard/businessDashboard/business-dashboard-page.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/connevent-appbar.dart';
import 'package:flutter/material.dart';

import 'eventDashboard/eventDashboardPage.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  String selectedSegment = "Events";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: globallightbg,
      appBar: ConneventAppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.only(left:padding * 2,right:padding * 2,top:8 ,bottom:20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               BaseTabCreatePage(selectedSegment: (val) =>setState(() =>selectedSegment=val)),
                SizedBox(height: 15),
                if(selectedSegment=='Events')
                  EventDashboard()
                else
                  BusinessDashboardPage()
              ],
            ),
          ),
        ),
      ),
    );
  }



}
