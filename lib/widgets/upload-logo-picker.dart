import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';


class UploadLogoPicker extends StatefulWidget {
  final String? previousImage;
  final Function(PickedFile)? onImagePicked;
  UploadLogoPicker({this.previousImage,this.onImagePicked});
  @override
  _UploadLogoPickerState createState() => _UploadLogoPickerState();
}

class _UploadLogoPickerState extends State<UploadLogoPicker> {
  PickedFile? pickedImage;
  PickedFile image =PickedFile("");

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
            image = (await ImagePicker().getImage(source: ImageSource.gallery,imageQuality: 50))!;
           if(image.path.isNotEmpty){
            setState(() {
              this.pickedImage = image;
            });
            widget.onImagePicked!(image);
          }},
      child: Stack(
          fit: StackFit.loose, children: <Widget>[
          Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color:Colors.white,width: 1)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: pickedImage == null || pickedImage!.path.isEmpty ? widget.previousImage!=null && widget.previousImage!.isNotEmpty
                     ?   Image.network(widget.previousImage!,fit: BoxFit.cover,):
                     Padding(
                       padding: const EdgeInsets.all(16.0),
                       child: SvgPicture.asset('assets/icons/selectPhoto.svg', fit: BoxFit.contain,),
                     )
                    : Image.file(File(pickedImage!.path),fit: BoxFit.cover,)
              ),
            ),
          ],
        ),
          if(image.path.isNotEmpty)
          Positioned(
            top: 2,
            right: 90,
            child: SizedBox(
              height: 30,
              child: CircleAvatar(
                backgroundColor: Colors.red,
                child: IconButton(
                    icon: Icon(Icons.delete, color: Colors.white, size: 15,),
                    onPressed: () {
                      PickedFile file =PickedFile("");
                      image=file;
                      pickedImage=file;
                      widget.onImagePicked!(image);
                      print(image.path);
                      setState(() {});
                    }),
              ),
            ),
          ),
      ]),
    );
  }
}
