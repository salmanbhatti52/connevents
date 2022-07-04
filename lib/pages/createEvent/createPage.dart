import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/create-event-model.dart';
import 'package:connevents/models/event-address-model.dart';
import 'package:connevents/models/event-dummy-ticket.dart';
import 'package:connevents/models/event-tags-model.dart';
import 'package:connevents/models/event-type-model.dart';
import 'package:connevents/pages/BaseTabCreatePage/Base-Tab-Create-Page.dart';
import 'package:connevents/pages/createEventSecond/createSecondPage.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/services/event-tags-service.dart';
import 'package:connevents/services/event-type-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/connevents-textfield.dart';
import 'package:connevents/widgets/create-container.dart';
import 'package:connevents/widgets/create-page-text.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:connevents/widgets/custom-tag-container.dart';
import 'package:connevents/widgets/drop-down-container.dart';
import 'package:connevents/widgets/event-video-picker.dart';
import 'package:connevents/widgets/image-container.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:path_provider/path_provider.dart';

import '../BusinessCreate/businessCreateFirstPage/BusinessCreateFirstPage.dart';

var event = EventDetail( eventAddress: EventAddress(),earlyBird: EarlyBird(), regular: Regular(), vip: VIP(),skippingLine: SkippingLine());

class CreatePage extends StatefulWidget {
  CreatePage({Key? key}) : super(key: key);
  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage>  with TickerProviderStateMixin{
  final key = GlobalKey<FormState>();

  String selectedSegment = 'Events';
  List<Asset> images = [];
  Dio dio = Dio();
  CroppedFile? imageFile;

  bool isEdit=false;
  EventTypeList? listOfEventType;
  List<TagsData> listOfTags = [];
  List<String> mixTags = [];
  Future<EventTypeList>? futureEventTypeModel;
  Future<EventTagsModel>? futureEventTagsModel;
  int totalImages = 3;

  List<String> imagePath = [];
  List<Asset> listOfImages = [];
  TextEditingController tagText=TextEditingController();


  getFileSize(String filepath, int decimals) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1000, i)));
  }



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
        // aspectRatio: CropAspectRatio(ratioX: 4,ratioY: 3),

        if (croppedFile != null) {
            setState(() {
              imageFile = croppedFile;
            });
        }

  }





  Future loadAssets() async {
    if (imagePath.length == 3) return;
    try {
      var resultList = await MultiImagePicker.pickImages(
          maxImages: 3 - imagePath.length,
          enableCamera: false,

          selectedAssets: listOfImages,
          cupertinoOptions: CupertinoOptions(
            takePhotoIcon: "chat",
            doneButtonTitle: "Photos",
          ),
          materialOptions: MaterialOptions(
            actionBarColor: "#abcdef",
            actionBarTitle: "Connevent",
            allViewTitle: "All Photos",
            useDetailsView: false,
            selectCircleStrokeColor: "#000000",
          ));

         for(var i=0 ; i<resultList.length; i++){
          final byteData = await resultList[i].getByteData();
          final tempFile = File("${(await getTemporaryDirectory()).path}/${resultList[i].name}");
          final file = await tempFile.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
          double sizeinMb = await getFileSize(file.path, 1);
          if(sizeinMb>2) return showErrorToast("You can't select more than 25 Mb size");
           await _cropImage(file.path);
           imagePath.add(imageFile!.path);

          if (i==0) {
          final bytes = await imageFile!.readAsBytes();
          event.firstImage = base64Encode(bytes);
          setState(() {});
        }

        if (i==1) {
          final bytes2 = await imageFile!.readAsBytes();
          event.secondImage = base64Encode(bytes2);
          setState(() {});
        }
        if (i==2) {
          final bytes3 = await imageFile!.readAsBytes();
          event.thirdImage = base64Encode(bytes3);
          setState(() {});
        }
          }

    } on Exception catch (e) {
          print(e.toString());
        }

        if (!mounted) return;
      }

  void getEventType() async {
      futureEventTypeModel = EventTypeService().get();
      await futureEventTypeModel!.then((value) {
        if(this.mounted){
          listOfEventType = value;
          setState(() {});
        }
      });
  }

  void getEventsTags() async {
     try{
       futureEventTagsModel = EventTagsService().get();
       await futureEventTagsModel!.then((value) {
         if(this.mounted){
           listOfTags = value.data!;


           setState(() {});
         }
       });
       Navigator.of(context).pop();
     }
     catch(e){
       Navigator.of(context).pop();
     }

  }

  Future addCustomTags() async {
    openLoadingDialog(context, "adding");
    var  response;
   try{
       response = await DioService.post('add_custom_tag', {
        "usersId": AppData().userdetail!.users_id,
         "tagName": tagText.text
      });
       Navigator.of(context).pop();
      print(response);
      if(response['status']=='success'){
          var jsonData = response['data'] ;
        TagsData tags =  TagsData.fromJson(jsonData);
          print(tags.toJson());
           listOfTags.add(tags);
           print(listOfTags);
           setState(() {});
    }
   }
    catch (e){
      showErrorToast(response['message']);
    }
     }


  @override
  void initState() {
    super.initState();
    event.eventTags = event.eventTags ?? <TagsData>[];
    event.customEventTags= <String>[];
    event.showTags= <String>[];
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      openLoadingDialog(context, "loading");
      getEventType();
      getEventsTags();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0),
        body: CreateContainer(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Form(
              key: key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  BaseTabCreatePage(selectedSegment: (val){
                    selectedSegment=val;
                    setState(() {});
                  }),
                  selectedSegment=='Events' ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Padding(
                        padding: const EdgeInsets.only(bottom: padding / 9,top: padding*2),
                        child: Text('Create Post', style: TextStyle(color: globalBlack, fontSize: 30, fontWeight: FontWeight.bold),),
                      ),
                       Padding(
                        padding: const EdgeInsets.symmetric(vertical: padding / 1.2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            text(title:'Event Title',color: globalBlack, fontSize: 18,fontWeight: FontWeight.bold ),
                            text(title:'*',color: Colors.red, fontSize: 18,fontWeight: FontWeight.bold ),
                          ],
                        ),
                  ),
                      Padding(
                         padding: const EdgeInsets.only(bottom: 12.0),
                         child: ConneventsTextField(
                          value: event.title,
                          validator: (val) => val!.isEmpty ? "Please Enter your Title" : null,
                          onSaved: (val) => setState(() => event.title = val!),
                          hintText: 'Enter Event Title',
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          imagePath.asMap().containsKey(0)  ? Expanded(
                          child: SizedBox(
                              height: 160,
                              child: Stack(
                                children: [
                                 Image.file(File(imagePath[0]),width: 200, height: 305,fit: BoxFit.cover),
                                   Positioned(
                                      top: 2,
                                      right: -2,
                                      child: SizedBox(
                                        height: 30,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.red,
                                          child: IconButton(
                                              icon: Icon(Icons.delete, color: Colors.white, size: 15,),
                                              onPressed: () => setState(()
                                              {
                                                imagePath.remove(imagePath.elementAt(0));
                                                if(event.firstImage.isEmpty){
                                                 if(event.secondImage.isNotEmpty){
                                                   event.secondImage="";
                                                 }else if(event.thirdImage.isNotEmpty)
                                                   event.thirdImage="";
                                                }
                                                event.firstImage="";
                                              }


                                              )
                                          ),
                                        ),
                                      ),
                                    ),

                                ],
                              ))) :
                          Expanded(
                            child: imageContainer(
                              child: Stack(
                                  clipBehavior: Clip.none, children: [
                                GestureDetector(
                                  onTap: loadAssets,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset('assets/icons/selectPhoto.svg', fit: BoxFit.fitWidth,),
                                      SizedBox(height: padding),
                                      text(title:'Upload Photo',color: globalBlack.withOpacity(0.3), fontSize: 12,fontWeight: FontWeight.bold ),
                                    ],
                                  ),
                                ),

                              ]),
                            ),
                          ),
                          SizedBox(width: padding),
                          imagePath.asMap().containsKey(1) ?
                          Expanded(
                         child: SizedBox(
                             height: 160,
                             child: Stack(
                               children: [
                                Image.file(File(imagePath[1]),width: 200, height: 305,fit: BoxFit.cover),
                                 Positioned(
                                  top: 2,
                                  right: -2,
                                  child: SizedBox(
                                    height: 30,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.red,
                                      child: IconButton(
                                          icon: Icon(Icons.delete, color: Colors.white, size: 15,),
                                          onPressed: () => setState(() {
                                            imagePath.remove(imagePath.elementAt(1));
                                            if(event.secondImage.isEmpty){
                                              if(event.firstImage.isNotEmpty){
                                                event.firstImage="";
                                              }else if(event.thirdImage.isNotEmpty)
                                                event.thirdImage="";
                                            }
                                            event.secondImage="";

                                          }
                                          )
                                  ),
                                    ),
                                  ),
                                ),
                               ],
                             ))):
                          Expanded(
                              child:imageContainer(
                                child: Stack(
                                    children: [
                                  GestureDetector(
                                    onTap: loadAssets,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                         SvgPicture.asset('assets/icons/selectPhoto.svg', fit: BoxFit.fitWidth,),
                                         SizedBox(height: padding),
                                         text(title:'Upload Photo',color: globalBlack.withOpacity(0.3), fontSize: 12,fontWeight: FontWeight.bold ),

                                      ],
                                    ),
                                  ),

                                ]),
                              )),
                          SizedBox(width: padding,),
                         imagePath.asMap().containsKey(2) ?
                         Expanded(child:
                         SizedBox( height: 160,
                             child: Stack(
                               children: [
                                 Image.file(File(imagePath[2]),width: 200, height: 305,fit: BoxFit.cover),
                                  Positioned(
                                    top: 2,
                                    right: -2,
                                    child: SizedBox(
                                      height: 30,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.red,
                                        child: IconButton(
                                            icon: Icon(Icons.delete, color: Colors.white, size: 15),
                                            onPressed: () {
                                              setState(() {
                                                imagePath.remove(imagePath.elementAt(2));

                                                if(event.thirdImage.isEmpty){
                                                  if(event.firstImage.isNotEmpty){
                                                    event.firstImage="";
                                                  }else if(event.secondImage.isNotEmpty)
                                                    event.secondImage="";
                                                }
                                                event.thirdImage="";


                                              });
                                            }),
                                      ),
                                    ),
                                  ),
                               ],
                             ))):
                          Expanded(
                              child: imageContainer(
                                child: Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: loadAssets,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [

                                           SvgPicture.asset('assets/icons/selectPhoto.svg', fit: BoxFit.fitWidth,),
                                          SizedBox(height: padding,),
                                          text(title:'Upload Photo',color: globalBlack.withOpacity(0.3), fontSize: 12,fontWeight: FontWeight.bold ),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              )),
                        ],
                      ),
                      SizedBox(height: padding),
                      Row(
                        children: [
                          Expanded(
                            child: EventVideoPicker(
                              isEdit: false,
                              onThumbNail: (thumb,thumbNail) async
                              {
                                event.firstThumbNail = thumb;
                                  List<int> imageBytes = thumbNail.readAsBytesSync();
                                event.first_video_thumbnail = base64Encode(imageBytes);
                              },
                              onVideoPicked: (file) async {
                                event.firstVideo = file;
                              },
                              onVideoDeleted: () async {
                                openLoadingDialog(context, "deleting");
                             var res   = await DioService.post('delete_video', {
                                   'fileName': event.firstVideo
                                 });
                                print(res);
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          SizedBox(width: padding),
                          Expanded(
                            child: EventVideoPicker(

                              onThumbNail: (thumb,thumbNail) {
                                event.secondThumbNail = thumb;
                                List<int> imageBytes = thumbNail.readAsBytesSync();
                                event.second_video_thumbnail = base64Encode(imageBytes);
                              },
                              onVideoPicked: (file) async {
                               event.secondVideo = file;
                              },
                              onVideoDeleted: () async {
                                openLoadingDialog(context, "deleting");
                             var res   = await DioService.post('delete_video', {
                                   'fileName': event.secondVideo
                                 });
                                print(res);
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          SizedBox(width: padding),
                          Expanded(
                            child: EventVideoPicker(
                              onThumbNail: (thumb,thumbNail) async{
                                 event.thirdThumbNail = thumb;
                                  List<int> imageBytes = thumbNail.readAsBytesSync();
                                event.third_video_thumbnail = base64Encode(imageBytes);
                              },
                              onVideoPicked: (file) async {
                                event.thirdVideo = file;
                              },
                              onVideoDeleted: () async {
                                openLoadingDialog(context, "deleting");
                             var res   = await DioService.post('delete_video', {
                                   'fileName': event.thirdVideo
                                 });
                                print(res);

                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: padding),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: padding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            text(title:'Event Type',color: globalBlack, fontSize: 18,fontWeight: FontWeight.bold ),
                            text(title:'*',color: Colors.red, fontSize: 18,fontWeight: FontWeight.bold ),
                          ],
                        ),
                      ),
                      dropDownContainer(
                        child: DropdownButton<EventTypes>(
                          underline: Container(),
                          isExpanded: true,
                          iconEnabledColor: Colors.black,
                          focusColor: Colors.black,
                          hint: Text("Select Event Type"),
                          icon: Icon(Icons.arrow_drop_down_rounded),
                          items: listOfEventType?.event_types?.map((value) {
                           // FocusManager.instance.primaryFocus?.unfocus();
                            return new DropdownMenuItem<EventTypes>(
                              value: value,
                              child: Text(value.eventType.toString()),
                            );
                          }).toList(),
                          onChanged: (newValue) => setState(() {
                                event.eventTypeData = newValue;
                                 event.category=null;
                          }),
                          value: event.eventTypeData,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: padding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            text(title:'Category',color:globalBlack,fontSize: 18, fontWeight: FontWeight.bold),
                            text(title:'*',color:Colors.red,fontSize: 18, fontWeight: FontWeight.bold)
                          ],
                        ),
                      ),

                      dropDownContainer(
                        child: DropdownButton<EventTypeCategories>(
                          underline: Container(),
                          isExpanded: true,
                          iconEnabledColor: Colors.black,
                          focusColor: Colors.black,
                          hint: Text("Select Category"),
                          icon: Icon(Icons.arrow_drop_down_rounded),
                          items: event.eventTypeData?.categories?.map((value) {
                            return new DropdownMenuItem<EventTypeCategories>(
                              value: value,
                              child: Text(value.category.toString()),
                            );
                          }).toList(),
                          onChanged: (newValue) => setState(() => event.category = newValue!),
                          value: event.category,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: padding * 2,bottom: padding),
                        child: Wrap(
                            children: listOfTags.map((e) {
                          return Padding(
                            padding: const EdgeInsets.only(top:2.0,left: 4.0),
                            child: TextButton(
                              onPressed: () {
                                if (event.customEventTags!.contains(e.tagId.toString()) || event.customEventTags!.contains(e.tagName)) {
                                    if(e.tagType=="Default"){
                                      event.customEventTags!.remove(e.tagId.toString());
                                      event.showTags!.remove(e.tagName.toString());
                                    }
                                    else{
                                      event.customEventTags!.remove(e.tagName);
                                      event.showTags!.remove(e.tagName.toString());
                                    }
                                  }
                                 else{
                                  if(e.tagType=="Default"){
                                    event.customEventTags!.add(e.tagId.toString());
                                    event.showTags!.add(e.tagName.toString());
                                  }
                                  else{
                                    event.customEventTags!.add(e.tagName!);
                                    event.showTags!.add(e.tagName.toString());
                                  }
                                }
                                setState(() {});
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.only(left:8.0,right: 8.0),
                                backgroundColor: event.customEventTags!.contains(e.tagId.toString()) || event.customEventTags!.contains(e.tagName)  ? globalGreen : Colors.grey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(e.tagName.toString(), style: TextStyle(color: Colors.white, fontSize: 13),
                              ),
                            ),
                          );
                        }).toList()),
                      ),
                     CustomTagContainer(
                      onPressed: (){
                        if(tagText.text.isEmpty) return showErrorToast("Please type tag before adding");
                          else {
                            listOfTags.add(TagsData(
                              tagName: tagText.text
                            ));
                           // addCustomTags();
                            tagText.clear();
                            setState(() {});
                          }
                      },
                      tagText: tagText,
                    ),
                      SizedBox(height: padding),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: globalGreen,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () async {
                            if (key.currentState!.validate()) {
                              key.currentState!.save();
                              print(event.customEventTags!.toList());
                             if ((event.firstVideo.isEmpty && event.secondVideo.isEmpty  && event.thirdVideo.isEmpty) && (imagePath.length < 1) )
                               return showErrorToast("You have to add atleast 1 image or video");

                              if (event.category == null) return showErrorToast("You have to select a Category");

                              if (event.eventTypeData == null) return showErrorToast("You have to select a Event Type");

                             // if (event.eventTags!.isEmpty) return showErrorToast("You have to select Some Tags");

                              CustomNavigator.navigateTo(context, CreateSecondPage(event: event));
                            }
                          },
                          child: text(title:'Next'.toUpperCase(), color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold )
                        ),
                      )

                        ],
                      ) : BusinessCreateFirstPage()
                ],
              ),
            ),
          ),
        ),
    );
  }








}
