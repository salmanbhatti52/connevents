import 'dart:io';

import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/checked-in-event-detail-model.dart';
import 'package:connevents/models/peek-model.dart';
import 'package:connevents/pages/Dashboard/eventDashboard/eventDashboardPage.dart';
import 'package:connevents/pages/tabs/tabsPage.dart';
import 'package:connevents/services/_config.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/widgets/connevent-appbar.dart';
import 'package:connevents/widgets/connevent-button.dart';
import 'package:connevents/widgets/connevents-textfield.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_thumbnail/video_thumbnail.dart';


class PickVideo extends StatefulWidget {
     List<CheckedInEventDetail>? checkInEventDetail;
    String?  videoPath;
   PickVideo({Key? key,this.videoPath,this.checkInEventDetail}) : super(key: key);

  @override
  _PickVideoState createState() => _PickVideoState();
}

class _PickVideoState extends State<PickVideo> {
  TextEditingController description=TextEditingController();
    final key = GlobalKey<FormState>();
    String videoName="";
    bool isCompress=false;
    MediaInfo? mediaInfo;
    String? _tempDir;
    String? thumb;
  CheckedInEventDetail? checkedIdEventDetail;
  List<CheckedInEventDetail> listOfCheckedIdEventDetail=[];

   int index = 0;
  VideoPlayerController? videoPlayerController;


   Future uploadVideo() async {

     if(checkedIdEventDetail==null) return showErrorToast('Please Select Event');

   openLoadingDialog(context, 'uploading');
   var  response;
   try{
       response = await DioService.post('upload_event_peek_video', FormData.fromMap({
                   'event_peek' :await MultipartFile.fromFile(mediaInfo!.path!),
                   'event_peek_thumbnail': await MultipartFile.fromFile(thumb!)
                       }));

       if(response['status']=="success"){
        var result = await DioService.post("upload_event_peek_details",{
            "usersId" : AppData().userdetail!.users_id,
            "eventPostId" : checkedIdEventDetail!.eventPostId,
            "videoName" : response['video'],
             'thumbnail':  response['thumbnail'],
            "descriptionText" : description.text
         });
           Navigator.of(context).pop();
           CustomNavigator.pushReplacement(context, TabsPage(index: 0));

       }else{
       print("error");
       }
   }
    catch (e){
      Navigator.of(context).pop();
     // showErrorToast(response['message']);
    }

   }

   compressVideo() async {
         mediaInfo = await VideoCompress.compressVideo(
            widget.videoPath!,
            quality: VideoQuality.Res1920x1080Quality,
            deleteOrigin: false, // It's false by default
          );
       isCompress=true;
       setState(() {});
       Navigator.of(context).pop();
      print(mediaInfo!.filesize);
   }

    Future<File> getThumbnailPath(String url) async {
    await getTemporaryDirectory().then((d) => _tempDir = d.path);
     thumb = await VideoThumbnail.thumbnailFile(
        video: url,
        thumbnailPath: _tempDir,
        imageFormat: ImageFormat.JPEG,
        quality: 80);
    final file = File(thumb!);
    return file;
}



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoPlayerController!.dispose();
  }


    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listOfCheckedIdEventDetail=widget.checkInEventDetail!;
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      openLoadingDialog(context, 'loading');
      compressVideo();
    });


    getThumbnailPath(widget.videoPath!);
    videoPlayerController = VideoPlayerController.file(File(widget.videoPath!))..initialize().then((value) {
      setState(() {
        videoPlayerController!.play();
        videoPlayerController!.setLooping(true);
      });
    });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: ConneventAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Form(
                  key: key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.cover,
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          height: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: VideoPlayer(videoPlayerController!)),
                        ),
                      ),
                      Padding(
                    padding: const EdgeInsets.only(top:16.0,bottom: 20),
                    child: Text("Text",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 16)),
                  ),
                      ConneventsTextField(
                      hintText: "50 characters maximum",
                      controller: description,
                      validator: (val){
                        if(val!.isEmpty)
                          return "Please Enter Description";
                          else if(val.length > 50)
                          return "You can't write more than 50 words";
                        },
                      maxLines: 4,
                    ),
                      SizedBox(height:12),
                      dropDownContainer(
                        child: DropdownButton<CheckedInEventDetail>(
                          underline: Container(),
                          isExpanded: true,
                          iconEnabledColor: Colors.black,
                          focusColor: Colors.black,
                          hint: Text("Select Event To Upload Peek"),
                          icon: Icon(Icons.arrow_drop_down_rounded),
                          items: listOfCheckedIdEventDetail.map((value) {
                            return new DropdownMenuItem<CheckedInEventDetail>(
                              value: value,
                              child: Text(value.title.toString()),
                            );
                          }).toList(),
                          onChanged: (CheckedInEventDetail? newValue){
                            print(newValue);
                            checkedIdEventDetail = newValue!;
                            setState(() {});
                          },
                          value: checkedIdEventDetail
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ConneventButton(
                title: "Upload",
                onPressed: ()async{
                  if(isCompress)
                   uploadVideo() ;
                },
              )
          ],
        ),
      ),
    );
  }
}
