import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/checked-in-event-detail-model.dart';
import 'package:connevents/models/create-event-model.dart';
import 'package:connevents/models/peek-model.dart';
import 'package:connevents/pages/eventComments/eventCommentsPageFunctions.dart';
import 'package:connevents/pages/eventPeeks/Event-Peeks-Detail.dart';
import 'package:connevents/Camera-Pages/camera-screen.dart';
import 'package:connevents/pages/eventPeeks/side-menu/comment-section.dart';
import 'package:connevents/pages/tabs/tabsPage.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

int peekUniqueId=0;
class EventPeeks extends StatefulWidget {
  final PeekDetail? peekDetail;
  final EventDetail? eventDetail;
  bool fromPeeksTab;
  bool fromHome;
   EventPeeks({Key? key, this.eventDetail,this.fromHome=false,this.fromPeeksTab=true,this.peekDetail}) : super(key: key);
  @override
  _EventPeeksState createState() => _EventPeeksState();
}

class _EventPeeksState extends State<EventPeeks> {

 PageController?  _pageController = PageController(initialPage: 0);
 bool isShown=false;

  List<PeekDetail>  peekDetail=[];
  String message="";
  bool isLoading=true;
  int totalPages=0;
  int totalViews=0;
  int comments=0;
  bool mainLoading=true;
  List<CheckedInEventDetail> checkedInEventDetail=[];
  List<PeekDetail> newPeekList=[];



    Future getPeeks() async {
     isLoading=true;
     setState(() {});
    var  response;
    try{
       response = await DioService.post('get_event_peeks', {
         "eventPostId": widget.eventDetail!.eventPostId,
         "usersId" :AppData().userdetail!.users_id,
         "userLat": AppData().userLocation!.latitude,
         "userLong": AppData().userLocation!.latitude
      });
       print("here");
       print(widget.eventDetail!.eventPostId);
       print(AppData().userdetail!.users_id);
       print(AppData().userLocation!.latitude);
       print(AppData().userLocation!.latitude);
       print("here");
      if(response['status']=="success"){
        totalPages=response['total_count'];
          var data = response['data'] as List;
          peekDetail     = data.map<PeekDetail>((e) => PeekDetail.fromJson(e)).toList();
          newPeekList.addAll(peekDetail);
          peekUniqueId = newPeekList.first.eventPeekId!;
          await viewPeeks(peekUniqueId);
          print(newPeekList.first.eventPeekId!);
          mainLoading=false;
          isLoading=false;
          setState(() {});
      }
      else if(response['status']=="error"){
        mainLoading=false;
        isLoading=false;
        message=response['message'];
        setState(() {});
      }
       print(response);
   }
    catch (e){
     // showErrorToast(response['message']);
    }
   }

   // Function to get Views On Peeks
   Future viewPeeks(int eventPeekId) async {
   var     response = await DioService.post('view_event_peek', {
         "usersId" :AppData().userdetail!.users_id,
         "eventPeekId": eventPeekId   // this is Event Peek Id
      });
      if(response['status']=="success"){
        totalViews=response['data'];
        print("Total Views");
        print(totalViews);
        print("Total Views");
      }
   }

    Future chekInEventDetails() async {
     isLoading=true;
     setState(() {});
    var  response;
    try{
       response = await DioService.post('peek_dropdown_event_list', {
         "usersId" :AppData().userdetail!.users_id
      });
      if(response['status']=="success"){
          var jsonData = response['data'] as List;
          if(this.mounted){
            checkedInEventDetail = jsonData.map<CheckedInEventDetail>((e) => CheckedInEventDetail.fromJson(e)).toList();
            setState(() {});
          }
          Navigator.of(context).pop();
      }
      else{
        Navigator.of(context).pop();
      }
       print(response);
   }
    catch (e){
      Navigator.of(context).pop();
     // showErrorToast(response['message']);
    }

   }

   @override
  void initState() {
    // TODO: implement initState
     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Color(0XFFF6F6F8), // status bar color
      ));
       super.initState();
       if(!widget.fromPeeksTab)
         newPeekList.add(widget.peekDetail!);
       getPeeks();
     WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
         openLoadingDialog(context, "loading...");
         chekInEventDetails();
          });

  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
      bottomSheet: isShown ? BottomSheet(
        builder: (BuildContext context) {
          return CommentSection(
            comments: (value){
              comments = value;
              setState(() {});
            },
             isShown: (val){
                  isShown=val;
                  setState(() {});
               },
              peekEventId: peekUniqueId);
        },
        onClosing: () {
          isShown=false;
          setState(() {});
        },
      ):SizedBox(),
      body :widget.fromHome ? mainLoading ? Center(child: CircularProgressIndicator()) :    Stack(
        children: [
          isLoading ? Positioned(
               bottom: 10,
               left: MediaQuery.of(context).size.width/2.2,
               child: CircularProgressIndicator()) : SizedBox(),
          PageView(
            onPageChanged: (val) async {
              //peekUniqueId Use to get event Peek Id
              peekUniqueId = newPeekList[val].eventPeekId!;
              if(val+1 == newPeekList.length)
                await getPeeks();
                await  viewPeeks(peekUniqueId);
            },
            controller: _pageController,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: [
              for(var i=0; i<newPeekList.length; i++)
               EventPeeksDetail(
                 comments: comments,
                 onTapMoreVertz:() async {
                     showDeletePeeksVideo(context,newPeekList[i], () async{
                         openLoadingDialog(context, 'deleting');
                         var response= await DioService.post('delete_event_peek', {
                           "eventPeekId": newPeekList[i].eventPeekId,
                         });
                        //await getAllComments();
                        CustomNavigator.pushReplacement(context,TabsPage(index: 0));
                       }
                       );
                 },
                 peekDetail:newPeekList[i],
                 checkedInEventDetail: checkedInEventDetail,
                 totalViews: totalViews,
                 isShown: (val){
                  isShown=val;
                  setState(() {});
               },)
            ]
          ),
        ],
      ) :
          SingleChildScrollView(
            child: Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height:MediaQuery.of(context).size.height*0.16),
                  Image.asset('assets/peeks.png'),
                  SizedBox(height:MediaQuery.of(context).size.height*0.05),
                  Text("The more you Peeks you share, the \n more fun it gets for everyone",textAlign:TextAlign.center,style:TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color:Color(0xff13A34C))),
                 SizedBox(height:MediaQuery.of(context).size.height*0.11),
                  GestureDetector(
                     onTap: () async {
                       if(checkedInEventDetail.isNotEmpty){
                         CustomNavigator.navigateTo(context, CameraScreen(checkedInEventDetail));
                          //-----------------------------------------------------------
                        //  final video = await ImagePicker().pickVideo(
                        //     preferredCameraDevice: CameraDevice.rear,
                        //     source: ImageSource.camera, maxDuration: Duration(seconds: 10));
                        // if (video != null) {
                        //    CustomNavigator.navigateTo(context, PickVideo(videoPath: video.path,checkInEventDetail: checkedInEventDetail)) ;
                        //   }else{
                        //   print("Cancel Video");
                        // }
                       }else{
                         showErrorToast("You have to check In First");
                         }
                     },
                     child: SvgPicture.asset("assets/peeksButton.svg",color: Colors.grey.shade700)),
              ],
            )
            ),
          )
    );
  }
}
