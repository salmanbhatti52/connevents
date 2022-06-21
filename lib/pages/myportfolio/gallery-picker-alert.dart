import 'dart:io';

import 'package:connevents/mixins/data.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class GalleryPickerAlert extends StatefulWidget {
  void Function(String imagePicked)? onImagePicked;
  void Function(String fileType)? fileType;
  void Function(File thumbNail)? thumbNail;
  GalleryPickerAlert({this.onImagePicked,this.fileType,this.thumbNail});

  @override
  State<GalleryPickerAlert> createState() => _GalleryPickerAlertState();
}

class _GalleryPickerAlertState extends State<GalleryPickerAlert> {


  String? imagePath;
  String fileType="";
  String? _tempDir;
  File? thumbNail;

 Future<File> getThumbnailPath(String url) async {
  await getTemporaryDirectory().then((d) => _tempDir = d.path);
  final thumb = await VideoThumbnail.thumbnailFile(
      video: url,
      thumbnailPath: _tempDir,
      imageFormat: ImageFormat.JPEG,
      quality: 80);
  final file = File(thumb!);
  return file;
  }




  Widget Buttons({text, color, void Function()? onTap}) {
    print(AppData().userdetail!.subscription_package_id);
    return RaisedButton(
      textColor: Colors.white,
      color: color,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
        child: Text(
          text,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
        ),
      ),
      onPressed: onTap,
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      // elevation: 3,
      backgroundColor: Colors.transparent,
      child: contentBox(context, size),
    );
  }




  contentBox(context, size) {
    return Container(
      height: 200,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 60,
              ),
              Text("Choose One : ", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 17)),
              SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 10),
                    Buttons(text: "Image",color:  globalGreen,onTap: ()async{
                        final image = await ImagePicker().getImage(
                        source: ImageSource.gallery, imageQuality: 50);
                    if (image != null) {
                      setState(() {
                      widget.onImagePicked!(image.path);
                      widget.fileType!("Image");
                      });}
                    },
                    ) ,
                    SizedBox(width: 10),
                    Buttons(text: "Video",color:  globalGreen,onTap: ()async{
                       final video = await ImagePicker().getVideo(
                        source: ImageSource.gallery, maxDuration: Duration(seconds: 10));
                    if (video != null) {
                      thumbNail = await getThumbnailPath(video.path);
                      widget.thumbNail!(thumbNail!);
                      widget.onImagePicked!(video.path);
                      widget.fileType!("Video");
                      setState(() {});
                      }else{
                      print("Cancel Vide");
                    }

                       //
                       // FilePickerResult? result = await FilePicker.platform.pickFiles(
                       //        type: FileType.custom,
                       //       allowedExtensions:['jpg','mp4','jpeg','png']
                       //    );
                       //    print("video Size");
                       //   if(result!.files.single.extension=="mp4" && result.files.single.size >  25000000)return showErrorToast("You can't upload more than 25 mb");
                       //    if(result.files.single.extension=="mp4"){
                       //      fileType="Video";
                       //      thumbNail = await getThumbnailPath(result.files.single.path!);
                       //      widget.thumbNail!(thumbNail!);
                       //      widget.fileType!(fileType);
                       //      setState(() {});
                       //    }
                       //    else setState(() {
                       //      fileType="Image";
                       //      widget.fileType!(fileType);
                       //    });
                       //    if (result.files.isNotEmpty){
                       //      File file = File(result.files.single.path!);
                       //      widget.onImagePicked!(file.path);
                       //    }



                    }),
                  ],
                ),
              )
            ],
          ),
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.close,
                size: 30,
                color: globalGreen,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
