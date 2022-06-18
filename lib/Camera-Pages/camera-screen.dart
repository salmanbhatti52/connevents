import 'dart:async';

import 'package:connevents/Camera-Pages/camera-view.dart';
import 'package:connevents/models/checked-in-event-detail-model.dart';
import 'package:connevents/pages/eventPeeks/pick-video.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
List<CameraDescription>? cameras;
class CameraScreen extends StatefulWidget {

  List<CheckedInEventDetail> checkedInEventDetail;

  CameraScreen(this.checkedInEventDetail);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  String? path;
  File? filePath;
  bool isRecording=false;


  Timer? _timer;
  double previousValue=0.0;
  int _start = 10;
  double scale = 1.0;
  double zoomLevel = 1.0;
  bool isFlashModeOn=false;

  CameraController? cameraController;
  FlashMode? _currentFlashMode;


  bool isTimerStart = false;
  bool isCameraFront=false;
  void startTimer() {
    isTimerStart=true;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          isTimerStart=false;
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }
  bool _isCameraInitialized = false;

  @override
  void dispose() {
    _timer!.cancel();
    cameraController!.dispose();
    super.dispose();
  }


  Future initializeCamera({int index = 0}) async{
    cameraController = CameraController(cameras![index], ResolutionPreset.high);
    cameraController!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
    _currentFlashMode = cameraController!.value.flashMode;

  }


  @override
  void initState() {
    super.initState();
    initializeCamera();
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
    );
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          GestureDetector(
            child:  Stack(
              children: [
                Container(
                    height:double.infinity,
                    width:double.infinity,
                    color: Colors.black,
                    child: CameraPreview(cameraController!)),
                   isRecording ?
                    Positioned(
                      bottom:40,
                      right:150,
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            border: Border.all(color: Colors.white,width: 2),
                            borderRadius: BorderRadius.circular(40)
                        )

                      ),
                    ):Positioned(
                     bottom:40,
                     right:150,
                      child: Icon(
                          Icons.panorama_fish_eye,
                          color: Colors.white,
                          size:80
                      ),
                    ),

                      ],
                    ),


          onVerticalDragUpdate:(DragUpdateDetails dragUpdateDetails)async{
              print("Dragging Start");

                if(dragUpdateDetails.delta.direction.isNegative){
                  if(await cameraController!.getMaxZoomLevel() > zoomLevel+0.1){
                    zoomLevel+=0.03;
                    cameraController!. setZoomLevel(this.zoomLevel);
                    //  print("On Vertical Drag Update"+ dragUpdateDetails.delta.direction.toString());
                  }
                }else{
                  if(await cameraController!.getMinZoomLevel() < zoomLevel-0.1){
                    zoomLevel-=0.03;
                    cameraController!. setZoomLevel(this.zoomLevel);
                    //print("On Vertical Drag Update"+ dragUpdateDetails.delta.direction.toString());
                  }
                }


          },
            onLongPressStart: (_) async {

              startTimer();
              await  cameraController!.startVideoRecording();
              isRecording=true;
              setState(() {});
            },

            onLongPressMoveUpdate:(LongPressMoveUpdateDetails longPressMoveUpdateDetails) async {
              print("Move Update");
              print(longPressMoveUpdateDetails.localOffsetFromOrigin.dx);
              print(longPressMoveUpdateDetails.localOffsetFromOrigin.dy);
              print("Move Update");
              if(longPressMoveUpdateDetails.localOffsetFromOrigin.dy < previousValue){
                if(await cameraController!.getMaxZoomLevel() > zoomLevel+0.1){
                  zoomLevel+=0.03;
                  cameraController!. setZoomLevel(this.zoomLevel);
                  //  print("On Vertical Drag Update"+ dragUpdateDetails.delta.direction.toString());
                }
              }
              else{
                if(await cameraController!.getMinZoomLevel() < zoomLevel-0.1){
                  zoomLevel-=0.03;
                  cameraController!. setZoomLevel(this.zoomLevel);
                  //print("On Vertical Drag Update"+ dragUpdateDetails.delta.direction.toString());
                }
              }
              previousValue = longPressMoveUpdateDetails.localOffsetFromOrigin.dy;


              ///--------------------------------------------------------------------------
              if(_start==0){
                 XFile videoPath= await cameraController!.stopVideoRecording();
                 print(videoPath.path);
                 setState(() {
                      isRecording=false;
                      Get.off( PickVideo(videoPath: videoPath.path,checkInEventDetail: widget.checkedInEventDetail));
                      //CustomNavigator.navigateTo(context, PickVideo(videoPath: videoPath.path,checkInEventDetail: widget.checkedInEventDetail)) ;

                   // CustomNavigator.navigateTo(context, VideoViewPage(path:videoPath.path));
                 });
              }
            },
            onLongPressEnd: (_) async{
              XFile videoPath;
              print("On LOng Press End");
              if(_start < 9){
                try {
                   videoPath= await cameraController!.stopVideoRecording();
                   print(videoPath.path);
                   setState(() {
                     isRecording=false;
                     Get.off( PickVideo(videoPath: videoPath.path,checkInEventDetail: widget.checkedInEventDetail));
                     // CustomNavigator.navigateTo(context, VideoViewPage(path:videoPath.path));
                   });
                } on CameraException catch (e) {
                  print(e);
                  return null;
                }

              }
              else{
                isRecording=false;
                isTimerStart=false;
                _start=10;
                _timer!.cancel();
                setState(() {});
              }
            },
          ),
          isFlashModeOn?
          Positioned(
            bottom:60,
            left:80,
            child: InkWell(
              onTap: () async {
                setState(() {
                  isFlashModeOn=false;
                  _currentFlashMode = FlashMode.off;
                });
                await cameraController!.setFlashMode(
                  FlashMode.off,
                );
              },
              child: Icon(
                Icons.flash_on,
                color: _currentFlashMode == FlashMode.torch
                    ? Colors.amber
                    : Colors.white,
              ),
            ),
          ):
          Positioned(
            bottom:60,
            left:80,
            child: InkWell(
              onTap: () async {
                setState(() {
                  print(isFlashModeOn);
                  isFlashModeOn=true;
                  print(isFlashModeOn);

                  _currentFlashMode = FlashMode.torch;
                });
                await cameraController!.setFlashMode(
                  FlashMode.torch,
                );
              },
              child: Icon(
                Icons.flash_off,
                color: _currentFlashMode == FlashMode.torch
                    ? Colors.amber
                    : Colors.white,
              ),
            ),
          ),

          Positioned(
              bottom:60,
              right:80,
              child: InkWell(
                  onTap:() async {
                    if(isCameraFront){
                      await   initializeCamera(index: 0);
                      isCameraFront=false;
                    }
                    else{
                      await   initializeCamera(index: 1);
                      isCameraFront=true;
                    }
                   setState(() {});
                  },
                  child: Icon(Icons.flip_camera_ios,color:Colors.white))),


         if(isTimerStart)
          Positioned(
            top: 60,
            right: 180,
            child: Text(_start.toString(),style: TextStyle(color: Colors.red,fontSize: 20,fontWeight: FontWeight.bold))
          )
        ],
      ),
    );
  }
}
