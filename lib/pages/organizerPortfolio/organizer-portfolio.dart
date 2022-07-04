import 'package:connevents/pages/organizerPortfolio/base-Tab-Portfolio-Page.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/connevent-appbar.dart';
import 'package:flutter/material.dart';
import 'package:connevents/models/create-event-model.dart';

import 'followers-list-page.dart';
import 'organizer-library-list.dart';

class OrganizerPortfolio extends StatefulWidget {
   EventDetail? eventDetail;
   OrganizerPortfolio({Key? key,this.eventDetail}) : super(key: key);

   @override
  _OrganizerPortfolioState createState() => _OrganizerPortfolioState();
}

class _OrganizerPortfolioState extends State<OrganizerPortfolio> {
   List<EventDetail> eventDetail=[];
   String message = "No Event Found";
   String selectedSegment="Portfolio";

   @override
   Widget build(BuildContext context) {
    return Scaffold(

      appBar: ConneventAppBar(),
      body: Container(
        decoration: BoxDecoration(color: globallightbg),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Container(
          padding: EdgeInsets.all(padding * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BaseTabPortfolioPage(selectedSegment: (value){
                selectedSegment=value;
                setState(() {});
              }),
              selectedSegment=="Portfolio" ?
              Expanded(child: OrganizerLibraryList(eventDetail: widget.eventDetail)):
              Expanded(child: FollowersListPage(eventDetail:widget.eventDetail)),
            ],
          ),
         ),
      ),
    );
  }
}
