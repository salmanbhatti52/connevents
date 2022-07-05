import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/checked-in-event-detail-model.dart';
import 'package:connevents/models/peek-model.dart';
import 'package:connevents/pages/eventDetails/eventDetailsPage.dart';
import 'package:connevents/pages/eventPeeks/side-menu/side-menu.dart';
import 'package:connevents/pages/home/parse-media.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:connevents/widgets/profile-image-picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class EventPeeksDetail extends StatefulWidget {
  final PeekDetail? peekDetail;
  int comments;
  Function(bool isshown) isShown;
  void Function()? onTapMoreVertz;
  int totalViews;
  List<CheckedInEventDetail> checkedInEventDetail;
   EventPeeksDetail({Key? key,this.comments=0,this.onTapMoreVertz,this.totalViews=0,this.peekDetail,required this.isShown,required this.checkedInEventDetail}) : super(key: key);

  @override
  _EventPeeksDetailState createState() => _EventPeeksDetailState();
}

class _EventPeeksDetailState extends State<EventPeeksDetail> {
late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool isEmojiShown=false;
  List<String>  listOfEmojis = ["👍", "😍","🔥","🤣","👀" ,"❤", "🎉","😯","😳","😢"];

  Future sendMessage(String emoji) async {
    print(emoji);
    openLoadingDialog(context, 'sending');
    var response;
    try{
      response   = await  DioService.post("comment_on_peek", {
        "eventPeekId": widget.peekDetail!.eventPeekId,
        "usersId": AppData().userdetail!.users_id,
        "comment": emoji,
        "emojiType":true
      });

      if(response['status']=="success"){
        Navigator.of(context).pop();
        if(isEmojiShown)
        isEmojiShown=false;
        widget.peekDetail!.totalComments =  (int.parse(widget.peekDetail!.totalComments!)+1).toString();
        setState(() {});
        showErrorToast("sent Successfully");
        print(response);
      }
      else{
        Navigator.of(context).pop();
        print("error");
      }
      setState(() {});
    }
    catch(e){
      Navigator.of(context).pop();
      showErrorToast(e.toString());
    }
  }


  @override
  void initState() {
    super.initState();
    _controller =  VideoPlayerController.network(widget.peekDetail!.videoUrl!);
    _initializeVideoPlayerFuture = _controller.initialize();
     _controller.play();
     _controller.setLooping(true);

     }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();
    super.dispose();
  }







  @override
  Widget build(BuildContext context) {
    print(widget.peekDetail!.videoUrl);
    return  Stack(
      children: [
       Container(
        height: MediaQuery.of(context).size.height,
        width:  MediaQuery.of(context).size.width,
        child: // Use a FutureBuilder to display a loading spinner while waiting for the
          // VideoPlayerController to finish initializing.
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If the VideoPlayerController has finished initialization, use
                // the data it provides to limit the aspect ratio of the video.
                return AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  // Use the VideoPlayer widget to display the video.
                  child: VideoPlayer(_controller),
                );
              } else {
                // If the VideoPlayerController is still initializing, show a
                // loading spinner.
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )),
        Positioned(
          top: 50,
          left: 10,
          right: 2,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                        onTap: (){
                          _controller.pause();
                          Navigator.of(context).pop(true);
                        },
                      child: Icon(CupertinoIcons.back,color: globalGreen,size: 30)),
                    Container(
                        width:40,
                        height:40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: globalGreen)
                        ),
                        child: ProfileImagePicker(
                          previousImage: widget.peekDetail!.profilePicture,
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Text(widget.peekDetail!.userName!,style: TextStyle(color: globalGreen,fontWeight: FontWeight.bold)),
                    ),

                    // Padding(
                    //   padding: const EdgeInsets.only(left:20.0),
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Text(widget.peekDetail!.firstName!,style: TextStyle(color: Colors.white)),
                    //     ],
                    //   ),
                    // ),
                  ],

                ),
                IconButton(
                    onPressed: widget.onTapMoreVertz,
                    icon: Icon(Icons.more_vert,color: globalGreen,size: 30))

              ],
            ),
          ),
        ),
        Positioned(
          bottom: 50,
          left: 20,
          right: 18,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () async {
                            _controller.pause();
                         bool  isPlay =    await CustomNavigator.navigateTo(context, EventDetailsPage(fromPeeks: true, event: widget.peekDetail!.eventDetail!,images: parseMedia(widget.peekDetail!.eventDetail!)));
                         if(isPlay)
                           _controller.play();


                        },
                        child: Text(widget.peekDetail!.eventTitle!,style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold))),
                    Row(
                      children: [
                        Text(widget.totalViews.toString(),style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold)),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Icon(Icons.remove_red_eye,color: Colors.white),
                        )
                      ],
                    )
                  ],
                ),
                Text(widget.peekDetail!.descriptionText!,
                    style: TextStyle(color: Colors.white,fontSize: 12)),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 120,
          right: 5,
          child: SideMenu(peekDetail: widget.peekDetail,checkedInEventDetail: widget.checkedInEventDetail,
            comments: widget.comments,
            onPressed: (){
              isEmojiShown=!isEmojiShown;
               setState(() {});
            },
            isShown: (val){
            widget.isShown(val);
          },),
        ),
        if(isEmojiShown)
          Positioned(
            top: 340,
            right: 50,
            child: Container(
                width: 300,
                height: 140,
                decoration: BoxDecoration(
                   //color: Colors.white38,
                    borderRadius: BorderRadius.circular(12)
                ),
                child : Wrap(
                  children: listOfEmojis.map((e) => InkWell(
                    onTap: () =>sendMessage(e),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(e,style: TextStyle(fontSize: 35)),
                    ),
                  )).toList(),
                )

            ),
          ),


    ],
  );
  }
}



