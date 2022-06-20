import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class EditProfileImagePicker extends StatefulWidget {
  final String? previousImage;
  final Function(PickedFile)? onImagePicked;
  EditProfileImagePicker({this.previousImage,this.onImagePicked});
  @override
  _EditProfileImagePickerState createState() => _EditProfileImagePickerState();
}

class _EditProfileImagePickerState extends State<EditProfileImagePicker> {
  PickedFile? pickedImage;

  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.loose, children: <Widget>[
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 90.0,
            height: 90.0,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color:Colors.green,width: 1)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: pickedImage == null ? widget.previousImage!=null && widget.previousImage!.isNotEmpty
                  ? Image.network(widget.previousImage!,fit: BoxFit.cover,)
                  : Image.asset("assets/avatar.png", fit: BoxFit.cover,
              )
                  : Image.file(File(pickedImage!.path),fit: BoxFit.cover,)
            ),
          ),
        ],
      ),
      Padding(
          padding: EdgeInsets.only(top: 40.0, left: 70.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () async {
                  final image = await ImagePicker().getImage(source: ImageSource.gallery,imageQuality: 50);
                  if(image!=null){
                    setState(() {
                      this.pickedImage = image;
                    });
                    widget.onImagePicked!(image);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  height: 30,
                  width: 30,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )),
    ]);
  }
}
