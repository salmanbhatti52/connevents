import 'dart:io';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dio/src/form_data.dart';
import 'package:dio/src/multipart_file.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class EventVideoPicker extends StatefulWidget {
   String? previousImage;
  String? image;
  final Function(String)? onVideoPicked;
  final void Function()? onVideoDeleted;
  final void Function()? onEditVideoDeleted;
  final Function(String, File)? onThumbNail;

  EventVideoPicker(
      {this.onVideoPicked,this.previousImage, this.onEditVideoDeleted,this.image, this.onVideoDeleted, this.onThumbNail});

  @override
  _EventVideoPickerState createState() => _EventVideoPickerState();
}

class _EventVideoPickerState extends State<EventVideoPicker> {
  PickedFile? _video;
  File? thumb;
  ImageFormat _format = ImageFormat.JPEG;
  int _quality = 80;
  String? _tempDir;
  bool? isVideo;
  String? url;
  bool? isUploading;





  Future<File> getThumbnailPath(String url) async {
    await getTemporaryDirectory().then((d) => _tempDir = d.path);
    final thumb = await VideoThumbnail.thumbnailFile(
        video: url,
        thumbnailPath: _tempDir,
        imageFormat: _format,
        quality: _quality);
    final file = File(thumb!);
    return file;
  }




  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(padding: const EdgeInsets.only(top: 5),
        child: Container(
          height: 175,
          width: double.infinity,
          child:   widget.previousImage !=null && widget.previousImage!.isNotEmpty ? networkImage() : _resolveVideo(),
        ),
      )
    ]);
  }

  // File? _video;

// This funcion will helps you to pick a Video File
  // _pickVideo() async {
  //  PickedFile? pickedFile = await ImagePicker().getVideo(source: ImageSource.gallery);
  //  _video = File(pickedFile!.path);
  // _videoPlayerController = VideoPlayerController.file(_video)..initialize().then((_) {
  //   setState(() { });
  //   _videoPlayerController.play();
  // });
//}






  String progress = '';
  int counter=0;
  Widget networkImage(){
    return Container(
               height: 500,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: globalLGray,
                  blurRadius: 3,
                )
              ],
            ),
            child:Stack(
              children: [
                Image.network(widget.previousImage!,fit: BoxFit.cover,),
                Align(
                alignment: Alignment(.95, -.95),
                child: SizedBox(
                  width: 25,
                  height: 25,
                  child: FlatButton(
                      color: Colors.red,
                      padding: EdgeInsets.zero,
                      child: Icon(Icons.delete, color: Colors.white),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      onPressed: () {
                          setState(() {
                            widget.previousImage = null;
                            _video = null;
                            widget.onEditVideoDeleted!();
                          });
                        }),
                ),
              ),
              ],
            )
          );
  }





  Widget _resolveVideo() {
    if (_video == null && widget.image == null) {
      return Center(
        child:GestureDetector(
          onTap: () async {
            final video = await ImagePicker().getVideo(source: ImageSource.gallery);
            if (video != null) {
              setState(() {
                this._video = video;
              });
              final vid = File(_video!.path);
              FormData data = FormData.fromMap(
                  {
                    'video': await MultipartFile.fromFile(_video!.path)
                  });
              var ress = await DioService.post("upload_video", data, null, (progress) {
                this.progress = progress;
                setState(() {});
              });
              print(ress);
              widget.onVideoPicked!(ress['data']);

              var res = await getThumbnailPath(video.path);
              setState(() {
                thumb = res;
              });

              widget.onThumbNail!(res.path,res);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: globalLGray,
                  blurRadius: 3,
                )
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: padding,vertical: padding * 2),
            child:
            Column(
              children: [
                SvgPicture.asset('assets/video.svg', fit: BoxFit.fitWidth),
                SizedBox(height: padding),
                Text('Upload Video', style: TextStyle(color: globalBlack.withOpacity(0.3), fontSize: 12, fontWeight: FontWeight.bold,),),
              ],
            )
          )
        ),
      );
    } else {
      return _video != null && thumb == null
          ? Container(
              padding: EdgeInsets.symmetric(horizontal: padding * 2, vertical: padding * 4),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: globalLGray,
                    blurRadius: 3,
                  )
                ],
              ),
              child: Column(
                children: [
                  CircularProgressIndicator(value: double.tryParse(progress))
                ],
              ))
          :
      Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(fit: BoxFit.cover, image: FileImage(File(thumb!.path)))),
              child: Align(
                alignment: Alignment(.95, -.95),
                child: SizedBox(
                  width: 25,
                  height: 25,
                  child: FlatButton(
                      color: Colors.red,
                      padding: EdgeInsets.zero,
                      child: Icon(Icons.delete, color: Colors.white),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      onPressed: () {
                          setState(() {
                            widget.previousImage = null;
                            _video = null;
                            widget.onVideoDeleted!();
                          });
                        }),
                ),
              ),
            );
          Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(fit: BoxFit.cover, image: FileImage(File(thumb!.path)))),
              child: Align(
                alignment: Alignment(.95, -.95),
                child: SizedBox(
                  width: 25,
                  height: 25,
                  child: FlatButton(
                      color: Colors.red,
                      padding: EdgeInsets.zero,
                      child: Icon(Icons.delete, color: Colors.white),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      onPressed: () {
                          setState(() {
                            widget.image = null;
                            _video = null;
                            widget.onVideoDeleted!();
                          });
                        }),
                ),
              ),
            );

    }
  }
}
