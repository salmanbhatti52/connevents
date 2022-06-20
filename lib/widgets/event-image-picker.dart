import 'dart:io';
import 'package:connevents/variables/globalVariables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class EventImagePicker extends StatefulWidget {
  String? previousImage;
  final Function(File)? onImagePicked;
  final Function()? onImageDeleted;
  EventImagePicker({this.onImagePicked, this.previousImage,this.onImageDeleted});

  @override
  _EventImagePickerState createState() => _EventImagePickerState();
}

class _EventImagePickerState extends State<EventImagePicker> {
  CroppedFile? _image;


   Future  _cropImage(String imagePath) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: imagePath,
        uiSettings:[
          AndroidUiSettings(
              initAspectRatio: CropAspectRatioPreset.ratio4x3,
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              hideBottomControls: true,
              lockAspectRatio: false),
          IOSUiSettings(
              showActivitySheetOnDone: false,
              resetAspectRatioEnabled: false,
              title: 'Cropper',
              hidesNavigationBar: true
          )
        ]);
        if (croppedFile != null) {
            setState(() {
              _image = croppedFile;
            });
        }

  }





  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
          padding: const EdgeInsets.only(top: 5,),
          child: Container(
              height: 175,
              width: double.infinity,
              child: _image == null ? (widget.previousImage != null && widget.previousImage!.isNotEmpty) ?
              Container(
                constraints: BoxConstraints.expand(),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.previousImage!)
                    )),
                child: Align(
                  alignment: Alignment(.95, -.95),
                  child: SizedBox(
                    width: 25,
                    height: 25,
                    child: FlatButton(
                        color: Colors.red,
                        padding: EdgeInsets.zero,
                        child: Icon(Icons.delete, color: Colors.white),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        onPressed: () {
                          setState(() {
                            widget.previousImage = null;
                            _image = null;
                            widget.onImageDeleted!();
                          });
                        }),
                  ),
                ),
              ) :
              Center(
                child: GestureDetector(
                  onTap: () async {
                    final image = await ImagePicker().getImage(
                        source: ImageSource.gallery, imageQuality: 50);
                    if (image != null) {
                      await _cropImage(image.path);
                      // setState(() {
                      //   this._image = File(image.path);
                      // });
                      widget.onImagePicked!(File(this._image!.path));
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
                    padding: EdgeInsets.symmetric(
                      horizontal: padding, vertical: padding * 2,),
                    child: Column(
                      children: [
                        SvgPicture.asset('assets/icons/selectPhoto.svg',
                          fit: BoxFit.fitWidth,),
                        SizedBox(height: padding,),
                        Text('Upload Photo', style: TextStyle(color: globalBlack
                            .withOpacity(0.3),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,),
                        ),

                      ],
                    ),
                  ),
                ),
              ) :
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: globalLGray,
                          blurRadius: 3,
                        )
                      ],
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(File(this._image!.path))
                      )
                  ),
                  child: Align(
                    alignment: Alignment(.95, -.95),
                    child: SizedBox(
                      width: 25,
                      height: 25,
                      child: FlatButton(
                          color: Colors.red,
                          padding: EdgeInsets.zero,
                          child: Icon(Icons.delete, color: Colors.white),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          onPressed: () {
                            setState(() {
                              widget.previousImage = null;
                              _image = null;
                              if(widget.previousImage != null && widget.previousImage!.isNotEmpty)
                                 widget.onImageDeleted!();
                            });
                          }),
                    ),
                  )
              )

          )
      )
    ]);
  }

}