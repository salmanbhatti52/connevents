import 'dart:convert';
import 'dart:io';
import 'package:connevents/models/business-type-model.dart';
import 'package:connevents/models/event-address-model.dart';
import 'package:connevents/pages/Dashboard/eventDashboard/eventDashboardPage.dart';
import 'package:connevents/pages/businessEdit/businessEditSecondPage/business-edit-second-page.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/detect-link.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/business-first-page-text.dart';
import 'package:connevents/widgets/connevent-appbar.dart';
import 'package:connevents/widgets/connevent-button.dart';
import 'package:connevents/widgets/connevents-textfield.dart';
import 'package:connevents/widgets/create-page-text.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:connevents/widgets/event-image-picker.dart';
import 'package:connevents/widgets/event-video-picker.dart';
import 'package:connevents/widgets/upload-logo-picker.dart';
import 'package:flutter/material.dart';
import 'package:connevents/models/business-create-model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class BusinessEditFirstPage extends StatefulWidget {

  Business? business;

   BusinessEditFirstPage({Key? key,this.business}) : super(key: key);

  @override
  _BusinessEditFirstPageState createState() => _BusinessEditFirstPageState();
}

class _BusinessEditFirstPageState extends State<BusinessEditFirstPage> {

  Business business= Business(eventAddress: EventAddress());

  String pickedImage="";
  PermissionStatus? _permissionStatus;
  List<BusinessType> businessTypeList = [];

  Future getBusinessTypes() async {
    try{
      var response = await DioService.get('get_business_types');

      var json = response['data'] as List;
      businessTypeList   = json.map<BusinessType>((e) => BusinessType.fromJson(e)).toList();
      print("response");
      print(businessTypeList.toList());
      print("response");
      setState(() {});
      businessTypeList.forEach((element) {

        if(element.id==business.businessType!.id){
          business.businessType = element;
          print("shahzaib");
          print(business.businessType!.id);
          print(element.id);
          print("shahzaib");
          print(business.businessType!.toJson());
        }
      });
      setState(() {});

      // print(isSocial);
      Navigator.of(context).pop();
    }
    catch(e){
      Navigator.of(context).pop();
    }
  }



  final key=GlobalKey<FormState>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    business=widget.business!;
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      openLoadingDialog(context, "loading...");
      getBusinessTypes();
    });
    //     () async {
    //   _permissionStatus = await Permission.storage.status;
    //   if (_permissionStatus != PermissionStatus.granted) {
    //     PermissionStatus permissionStatus= await Permission.storage.request();
    //     setState(() {
    //       _permissionStatus = permissionStatus;
    //     });
    //   }
    // }();


  }



  @override
  Widget build(BuildContext context) {
    print(widget.business!.businessType!.toJson());
    return Scaffold(
      appBar: ConneventAppBar(),
      body:  SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(left:30.0,right:30,bottom: 30),
              child: Form(
                key: key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                    padding: const EdgeInsets.only(top:20,bottom: padding / 9),
                    child: Text('Edit Business', style: TextStyle(color: globalBlack, fontSize: 30, fontWeight: FontWeight.bold),),
                  ),

                   businessFirstPageText('Upload Logo'),

                    Container(
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(20)
                       ),
                        height: 120,
                        child: Stack(
                          children: [
                            UploadLogoPicker(
                              previousImage:business.businessLogo,
                              onImagePicked: (val){
                                pickedImage=val.path;
                                print(pickedImage);
                                if(pickedImage.isNotEmpty){
                                  List<int> imageBytes = File(pickedImage).readAsBytesSync();
                                   business.businessLogo = base64Encode(imageBytes);
                                }
                                else
                                  business.businessLogo="";
                                setState(() {});
                              },
                            ),
                          ],
                        )),

                    businessFirstPageText('Business Name'),
                    Padding(
                       padding: const EdgeInsets.only(bottom: 12.0),
                       child: ConneventsTextField(
                         value: business.title,
                        onSaved: (val) => setState(() => business.title = val!),
                        hintText: 'Enter Business Name',
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                        child: EventImagePicker(
                           previousImage: business.firstImage,
                           onImagePicked: (File file) {
                            List<int> imageBytes = File(file.path).readAsBytesSync();
                            business.firstImage = base64Encode(imageBytes);
                      } ,
                        onImageDeleted: ()async{
                         print(business.firstImage.split('/').last);
                         openLoadingDialog(context, "Deleting");
                         var res   = await DioService.post('created_business_delete_image', {
                               "fileName": business.firstImage.split('/').last,
                                "businessId": business.businessId
                             });
                            print(res);
                            business.firstImage="";
                            Navigator.pop(context);
                          // business.image = null;
                        },
                      )),
                        SizedBox(width: padding),
                        Expanded(
                        child: EventImagePicker(
                          previousImage: business.secondImage,
                           onImagePicked: (File file) {
                            List<int> imageBytes = File(file.path).readAsBytesSync();
                            business.secondImage = base64Encode(imageBytes);
                            print(business.secondImage);
                      } ,
                        onImageDeleted: ()async{
                            print(business.secondImage.split('/').last);
                            print(business.businessId);
                           openLoadingDialog(context, "Deleting");
                         var res   = await DioService.post('created_business_delete_image', {
                               "fileName": business.secondImage.split('/').last,
                                "businessId": business.businessId
                             });
                            print(res);
                            business.secondImage="";
                            Navigator.pop(context);
                          // business.image = null;
                        },
                      )),
                        SizedBox(width: padding),
                       Expanded(child:EventImagePicker(
                          previousImage: business.thirdImage,
                           onImagePicked: (File file) {
                            List<int> imageBytes = File(file.path).readAsBytesSync();
                            business.thirdImage = base64Encode(imageBytes);
                            print(business.thirdImage);
                      } ,
                        onImageDeleted: ()async{
                           openLoadingDialog(context, "Deleting");
                           var res   = await DioService.post('created_business_delete_image', {
                               "fileName": business.thirdImage.split('/').last,
                                "businessId": business.businessId
                             });
                            print(res);
                            business.thirdImage="";
                            Navigator.pop(context);
                          // business.image = null;
                        },
                      ))
                      ],
                    ),
                    SizedBox(height: padding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                            child: EventImagePicker(
                              previousImage: business.fourthImage,
                              onImagePicked: (File file) {
                                List<int> imageBytes = File(file.path).readAsBytesSync();
                                business.fourthImage = base64Encode(imageBytes);
                              } ,
                              onImageDeleted: ()async{
                                print(business.fourthImage.split('/').last);
                                openLoadingDialog(context, "Deleting");
                                var res   = await DioService.post('created_business_delete_image', {
                                  "fileName": business.fourthImage.split('/').last,
                                  "businessId": business.businessId
                                });
                                print(res);
                                business.fourthImage="";
                                Navigator.pop(context);
                                // business.image = null;
                              },
                            )),
                        SizedBox(width: padding),
                        Expanded(
                            child: EventImagePicker(
                              previousImage: business.fifthImage,
                              onImagePicked: (File file) {
                                List<int> imageBytes = File(file.path).readAsBytesSync();
                                business.fifthImage = base64Encode(imageBytes);
                                print(business.fifthImage);
                              } ,
                              onImageDeleted: ()async{
                                print(business.fifthImage.split('/').last);
                                print(business.businessId);
                                openLoadingDialog(context, "Deleting");
                                var res   = await DioService.post('created_business_delete_image', {
                                  "fileName": business.fifthImage.split('/').last,
                                  "businessId": business.businessId
                                });
                                print(res);
                                business.fifthImage="";
                                Navigator.pop(context);
                                // business.image = null;
                              },
                            )),
                        SizedBox(width: padding),
                        Expanded(child:EventImagePicker(
                          previousImage: business.sixthImage,
                          onImagePicked: (File file) {
                            List<int> imageBytes = File(file.path).readAsBytesSync();
                            business.sixthImage = base64Encode(imageBytes);
                            print(business.thirdImage);
                          } ,
                          onImageDeleted: ()async{
                            openLoadingDialog(context, "Deleting");
                            var res   = await DioService.post('created_business_delete_image', {
                              "fileName": business.sixthImage.split('/').last,
                              "businessId": business.businessId
                            });
                            print(res);
                            business.sixthImage="";
                            Navigator.pop(context);
                            // business.image = null;
                          },
                        ))
                      ],
                    ),
                    SizedBox(height: padding),
                    Row(
                      children: [
                      Expanded(
                        child: EventVideoPicker(
                         previousImage: business.first_video_thumbnail.contains('https') ? business.first_video_thumbnail : "",
                          onThumbNail: (thumb,thumbNail) async
                          {
                            business.firstThumbNail = thumb;
                              List<int> imageBytes = thumbNail.readAsBytesSync();
                            business.first_video_thumbnail = base64Encode(imageBytes);
                          },
                          onVideoPicked: (file) async {
                            business.firstVideo = file;
                          },
                             onEditVideoDeleted: () async {
                                   openLoadingDialog(context, "Deleting");
                                await DioService.post('created_business_delete_video', {
                               'videoName': business.firstVideo.split('/').last,
                               'thumbnailName': business.first_video_thumbnail.split('/').last,
                               'businessId': business.businessId
                             });
                            business.firstThumbNail="";
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      SizedBox(width: padding),
                      Expanded(
                        child: EventVideoPicker(
                          previousImage:  business.second_video_thumbnail.contains('https') ? business.second_video_thumbnail : "",
                          onThumbNail: (thumb,thumbNail) {
                            business.secondThumbNail = thumb;
                            List<int> imageBytes = thumbNail.readAsBytesSync();
                            business.second_video_thumbnail = base64Encode(imageBytes);
                          },
                          onVideoPicked: (file) async {
                           business.secondVideo = file;
                          },
                             onEditVideoDeleted: () async {
                                   openLoadingDialog(context, "Deleting");
                               await DioService.post('created_business_delete_video', {
                               'videoName': business.secondVideo.split('/').last,
                               'thumbnailName': business.second_video_thumbnail.split('/').last,
                               'businessId': business.businessId
                             });
                            business.secondThumbNail="";
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      SizedBox(width: padding),
                      Expanded(
                        child: EventVideoPicker(
                          previousImage: business.third_video_thumbnail.contains('https') ? business.third_video_thumbnail : "",
                          onThumbNail: (thumb,thumbNail) async{
                             business.thirdThumbNail = thumb;
                              List<int> imageBytes = thumbNail.readAsBytesSync();
                            business.third_video_thumbnail = base64Encode(imageBytes);
                          },
                          onVideoPicked: (file) async {
                            business.thirdVideo = file;
                          },
                          onEditVideoDeleted: () async {
                           openLoadingDialog(context, "Deleting");
                           var res   = await DioService.post('created_business_delete_video', {
                               'videoName': business.thirdVideo.split('/').last,
                               'thumbnailName': business.third_video_thumbnail.split('/').last,
                               'businessId': business.businessId
                             });
                            print(res);
                            business.thirdThumbNail="";
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      ],
                    ),
                    SizedBox(height: padding),
                    if(businessTypeList.isNotEmpty)
                      dropDownContainer(
                        child: DropdownButton<BusinessType>(
                          underline: Container(),
                          isExpanded: true,
                          iconEnabledColor: Colors.black,
                          focusColor: Colors.black,
                          hint: Text("Select Business Type"),
                          icon: Icon(Icons.arrow_drop_down_rounded),
                          items: businessTypeList.map((value) {
                            return new DropdownMenuItem<BusinessType>(
                              value: value,
                              child: Text(value.type.toString()),
                            );
                          }).toList(),
                          onChanged: (newValue) => setState(() {
                            business.businessType = newValue!;
                            // widget.event!.category=null;
                          }),
                          value: business.businessType,
                        ),
                      ),

                    SizedBox(height: padding* 2),
                    ConneventButton(
                      title: "Next",
                      onPressed: ()async{
                        if (key.currentState!.validate()) {
                            key.currentState!.save();
                            if(business.businessLogo.isEmpty) return showErrorToast("You have to add Business Logo");
                            if(business.title.isEmpty) return showErrorToast("You have to add Business Name");

                           if ((business.firstImage.isEmpty  && business.secondImage.isEmpty && business.thirdImage.isEmpty) && (business.firstVideo.isEmpty && business.secondVideo.isEmpty  && business.thirdVideo.isEmpty) )
                             return showErrorToast("You have to add atleast 1 image or video");
                            CustomNavigator.navigateTo(context, BusinessEditSecondPage(business:business));
                          }
                      },
                    )
                  ],
                ),
              ),
            ),
    ),
    );
  }
}
