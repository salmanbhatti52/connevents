import 'package:camera/camera.dart';
import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/checked-in-event-detail-model.dart';
import 'package:connevents/models/peek-model.dart';
import 'package:connevents/Camera-Pages/camera-screen.dart';
import 'package:connevents/pages/eventPeeks/pick-video.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class SideMenu extends StatefulWidget {
  Function(bool isshown) isShown;
  Function() onPressed;
  int comments;
  final PeekDetail? peekDetail;
   List<CheckedInEventDetail> checkedInEventDetail ;
   SideMenu({Key? key,this.comments=0,this.peekDetail,required this.onPressed,required this.isShown,required this.checkedInEventDetail}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {


  @override
  void initState() {
    super.initState();
    if(widget.comments>0)
    widget.peekDetail!.totalComments=widget.comments.toString();
  }

  @override
  Widget build(BuildContext context) {
    print("shahzaib");
    print(widget.peekDetail!.totalComments);
    print("shahzaib");

    return Column(
       children: [
            InkWell(
              onTap: () => widget.isShown(true),
              child: SvgPicture.asset("assets/icons/comments.svg",color: Colors.white)),
             Padding(
               padding: const EdgeInsets.only(top:8.0,bottom: 20),
               child: Text(widget.peekDetail!.totalComments!,style: TextStyle(color: Colors.white)),
             ),
             IconButton(
             onPressed: widget.onPressed,
             icon: Icon(Icons.emoji_emotions_outlined,color: Colors.white)
             ),
             // Padding(
             //   padding: const EdgeInsets.only(top:25.0,bottom: 20),
             //   child: InkWell(
             //       onTap: () async {
             //         if(widget.checkedInEventDetail.isNotEmpty){
             //              // availableCameras().then(
             //              // (cameras) {
             //              // print(cameras);
             //              // CameraController _controller = CameraController(
             //              // cameras[0],
             //              // ResolutionPreset.high,
             //              // enableAudio: true,
             //              // );
             //              // _controller.initialize().then((value) {
             //              //   CustomNavigator.navigateTo(context, CameraScreen(_controller));
             //              // }
             //              // ); });
             //
             //           final video = await ImagePicker().pickVideo(
             //              source: ImageSource.camera, maxDuration: Duration(seconds: 10));
             //          if (video != null) {
             //             CustomNavigator.navigateTo(context, PickVideo(videoPath: video.path,checkInEventDetail : widget.checkedInEventDetail,)) ;
             //            } else {
             //            print("Cancel Video");
             //          }
             //         } else {
             //           showErrorToast("You must be checked in first");
             //         }
             //       },
             //       child: SvgPicture.asset("assets/icons/tabs/create.svg",color:widget.checkedInEventDetail.isUserCheckedin ? Colors.white : Colors.white60,width: 30,height: 30)),
             // ),
      ],
    );
  }
}
