import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/create-event-model.dart';
import 'package:connevents/pages/home/no-result-available-message.dart';
import 'package:connevents/pages/organizerPortfolio/organizer-event-gallery.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/connevent-appbar.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyPortfolio extends StatefulWidget {
 final bool isPortfolio;
  const MyPortfolio({Key? key,this.isPortfolio=false}) : super(key: key);

  @override
  _MyPortfolioState createState() => _MyPortfolioState();
}

class _MyPortfolioState extends State<MyPortfolio> {

   String message = "";


   List<EventDetail>  eventDetail=[];

   Future getMyEventLibrary() async {
    var  response;
    try{
       response = await DioService.post('get_my_event_library_list' , {
        "usersId": AppData().userdetail!.users_id,
      });
       Navigator.of(context).pop();
      print(response);
      if(response['status']=='success'){
        var event = response['data'] as List;
        eventDetail = event.map<EventDetail>((e) => EventDetail.fromJson(e)).toList();
        setState(() {});}
      else if(response['status']=='error'){
          eventDetail.clear();
          message='No Event Found';
          setState(() {});
    }
    }
    catch (e){
      showErrorToast(response['message']);
    }}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        openLoadingDialog(context, "loading...");
        getMyEventLibrary();
         });


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: ConneventAppBar(),
      body: Container(
        decoration: BoxDecoration(
          color: globallightbg,
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.only(left:padding * 2,right:padding * 2,bottom: padding * 2,top:20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('My Portfolio', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: globalBlack)),
                SizedBox(height: padding),
                SizedBox(height: padding),
                  eventDetail.length > 0 ?
                   ListView.builder(
                     physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: eventDetail.length,
                    itemBuilder: (context,index){
                      return  GestureDetector(
                        onTap: () {
                          CustomNavigator.navigateTo(context, OrganizerEventGalleryPage(
                            eventDetail:eventDetail[index],
                          ));
                        },
                        child: Container(
                          padding: EdgeInsets.only(bottom: padding / 2),
                          margin: EdgeInsets.only(bottom: padding),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: globalLGray,
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(eventDetail[index].title, style: TextStyle(color: globalBlack, fontSize: 18)),
                              SizedBox(height: padding / 3),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset('assets/icons/calendarSmall.svg'),
                                      SizedBox(width: padding / 2),
                                      Text(eventDetail[index].eventStartDate),
                                      SizedBox(width: padding),
                                      SvgPicture.asset('assets/icons/clock.svg'),
                                      SizedBox(width: padding / 2),
                                      Text(eventDetail[index].eventStartTime),
                                    ],
                                  ),
                                  Icon(Icons.chevron_right, color: globalLGray),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }):
                  Center(child: noResultAvailableMessage(message,context))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
