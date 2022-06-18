import 'dart:convert';
import 'dart:io';
import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/create-event-model.dart';
import 'package:connevents/models/event-address-model.dart';
import 'package:connevents/models/event-dummy-ticket.dart';
import 'package:connevents/models/event-tags-model.dart';
import 'package:connevents/models/event-type-model.dart';
import 'package:connevents/pages/editEvent/editCreateSecond/editCreateSecondPage.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/services/event-type-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/connevent-appbar.dart';
import 'package:connevents/widgets/connevents-textfield.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:connevents/widgets/custom-tag-container.dart';
import 'package:connevents/widgets/event-image-picker.dart';
import 'package:connevents/widgets/event-video-picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:permission_handler/permission_handler.dart';

var eventDetail = EventDetail( eventAddress: EventAddress(),earlyBird: EarlyBird(), regular: Regular(), vip: VIP(),skippingLine: SkippingLine());


class EditCreatePage extends StatefulWidget {
  final EventDetail? event;
  EditCreatePage({Key? key, this.event}) : super(key: key);

  @override
  State<EditCreatePage> createState() => _EditCreatePageState();
}

class _EditCreatePageState extends State<EditCreatePage> {
  final key = GlobalKey<FormState>();
  List<Asset> images = [];
    TextEditingController tagText=TextEditingController();

  Dio dio = Dio();
  bool isEdit=false;
  EventTypeList? listOfEventType;
  List<EventTypeCategories> listOfCategoryEvents = [];
  List<TagsData> listOfTags = [];
  Future<EventTypeList>? futureEventTypeModel;
  Future<EventTypeCategories>? futureCategoryModel;
  Future<EventTagsModel>? futureEventTagsModel;

  int totalImages = 3;
  List<Asset> imagePath = [];
  List<Asset> listOfImages = [];
  PermissionStatus? _permissionStatus;


  void getEventType() async {
    futureEventTypeModel = EventTypeService().get();
    await futureEventTypeModel!.then((value) =>   setState(() {
      listOfEventType = value;
      listOfEventType!.event_types!.forEach((element) {
        if(element.eventTypeId==eventDetail.eventTypeData!.eventTypeId){
          eventDetail.eventTypeData =element;
        }
      });
    } ));
   // if(this.mounted) setState(() {});
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

   Future getEventsTags() async {

    var  response;
   try{
       response = await DioService.post('get_all_tags_with_custom', {
        "usersId": AppData().userdetail!.users_id,
         //"eventPostId" :
      });
       Navigator.of(context).pop();
      print(response);
      if(response['status']=='success'){
          var jsonData = response['data'] as List;
         listOfTags  = jsonData.map<TagsData>((e) => TagsData.fromJson(e)).toList();
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
       eventDetail=widget.event!;
       WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
       openLoadingDialog(context, "Loading...");
       getEventType();
       getEventsTags();
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
    return Scaffold(
      appBar: ConneventAppBar(),
      body: Container(
        decoration: BoxDecoration(color: globallightbg),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.all(padding * 2),
            child: Form(
              key: key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: padding / 9),
                    child: Text('Edit Create Post', style: TextStyle(color: globalBlack, fontSize: 30, fontWeight: FontWeight.bold),),
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
                      value: eventDetail.title,
                      validator: (val) => val!.isEmpty ? "Please Enter your Title" : null,
                      onSaved: (val) => setState(() => eventDetail.title = val!),
                      hintText: 'Enter Event Title',
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                   SizedBox(width: padding),
                    Expanded(
                      child: EventImagePicker(
                          previousImage: eventDetail.firstImage,
                           onImagePicked: (File file) {
                            List<int> imageBytes = File(file.path).readAsBytesSync();
                            eventDetail.firstImage = base64Encode(imageBytes);
                            print(eventDetail.firstImage);
                      } ,
                        onImageDeleted: ()async{
                           openLoadingDialog(context, "Deleting");
                         var res   = await DioService.post('created_event_delete_image', {
                               "fileName": eventDetail.firstImage.split('/').last,
                                "eventPostId": eventDetail.eventPostId
                             });
                            print(res);
                            eventDetail.firstImage="";
                            Navigator.pop(context);
                          // business.image = null;
                        },
                      ),
                ),
                    SizedBox(width: padding),
                    Expanded(
                      child: EventImagePicker(
                        previousImage: eventDetail.secondImage ,
                        onImagePicked: (File file) {
                           print(file);
                           List<int> imageBytes = File(file.path).readAsBytesSync();
                            eventDetail.secondImage = base64Encode(imageBytes);

                      } ,
                        onImageDeleted: ()async{
                           openLoadingDialog(context, "Deleting");
                         var res   = await DioService.post('created_event_delete_image', {
                               "fileName": eventDetail.secondImage.split('/').last,
                                "eventPostId": eventDetail.eventPostId
                             });
                            print(res);
                            eventDetail.secondImage="";
                            Navigator.pop(context);
                          // business.image = null;
                        },
                      ),
                ),
                    SizedBox(width: padding),
                    Expanded(
                      child: EventImagePicker(
                         previousImage: eventDetail.thirdImage,
                        onImagePicked: (File file) {
                           List<int> imageBytes = File(file.path).readAsBytesSync();
                            eventDetail.thirdImage = base64Encode(imageBytes);
                      } ,
                        onImageDeleted: ()async{
                             openLoadingDialog(context, "Deleting");
                         var res   = await DioService.post('created_event_delete_image', {
                               "fileName": eventDetail.thirdImage.split('/').last,
                                "eventPostId": eventDetail.eventPostId
                             });
                            print(res);
                            eventDetail.thirdImage="";
                            Navigator.pop(context);
                          // business.image = null;
                        },
                      ),
                ),

                    ],
                  ),
                  SizedBox(height: padding),
                  Row(
                    children: [
                      Expanded(
                        child: EventVideoPicker(
                         previousImage: eventDetail.first_video_thumbnail.contains('https') ? eventDetail.first_video_thumbnail : "",
                          onThumbNail: (thumb,thumbNail) async
                          {
                            eventDetail.firstThumbNail = thumb;
                              List<int> imageBytes = thumbNail.readAsBytesSync();
                            eventDetail.first_video_thumbnail = base64Encode(imageBytes);
                          },
                          onVideoPicked: (file) async {
                            eventDetail.firstVideo = file;
                          },
                             onEditVideoDeleted: () async {
                                   openLoadingDialog(context, "Deleting");
                               await DioService.post('created_event_delete_video', {
                               'videoName': eventDetail.firstVideo.split('/').last,
                               'thumbnailName': eventDetail.first_video_thumbnail.split('/').last,
                               'eventPostId': eventDetail.eventPostId
                             });
                         eventDetail.firstThumbNail="";
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      SizedBox(width: padding),
                      Expanded(
                        child: EventVideoPicker(
                          previousImage:  eventDetail.second_video_thumbnail.contains('https') ? eventDetail.second_video_thumbnail : "",
                          onThumbNail: (thumb,thumbNail) {
                            eventDetail.secondThumbNail = thumb;
                            List<int> imageBytes = thumbNail.readAsBytesSync();
                            eventDetail.second_video_thumbnail = base64Encode(imageBytes);
                          },
                          onVideoPicked: (file) async {
                           eventDetail.secondVideo = file;
                          },
                             onEditVideoDeleted: () async {
                                   openLoadingDialog(context, "Deleting");
                                await DioService.post('created_event_delete_video', {
                               'videoName': eventDetail.secondVideo.split('/').last,
                               'thumbnailName': eventDetail.second_video_thumbnail.split('/').last,
                               'eventPostId': eventDetail.eventPostId
                             });
                            eventDetail.secondThumbNail="";
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      SizedBox(width: padding),
                      Expanded(
                        child: EventVideoPicker(
                          previousImage: eventDetail.third_video_thumbnail.contains('https') ? eventDetail.third_video_thumbnail : "",
                          onThumbNail: (thumb,thumbNail) async{
                             eventDetail.thirdThumbNail = thumb;
                              List<int> imageBytes = thumbNail.readAsBytesSync();
                            eventDetail.third_video_thumbnail = base64Encode(imageBytes);
                          },
                          onVideoPicked: (file) async {
                            eventDetail.thirdVideo = file;
                          },
                          onEditVideoDeleted: () async {
                                   openLoadingDialog(context, "Deleting");
                          var res   = await DioService.post('created_event_delete_video', {
                               'videoName': eventDetail.thirdVideo.split('/').last,
                               'thumbnailName': eventDetail.third_video_thumbnail.split('/').last,
                               'eventPostId': eventDetail.eventPostId
                             });
                            print(res);
                            eventDetail.thirdThumbNail="";
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
                        return new DropdownMenuItem<EventTypes>(
                          value: value,
                          child: Text(value.eventType.toString()),
                        );
                      }).toList(),
                      onChanged: (newValue) => setState(() {
                            widget.event!.eventTypeData = newValue;
                             widget.event!.category=null;
                      }),
                      value: eventDetail.eventTypeData,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: padding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        text(title:'Category',color:globalBlack,fontSize: 18, fontWeight: FontWeight.bold),
                        text(title:'*',color:Colors.red,fontSize: 18, fontWeight: FontWeight.bold)
                      ])),
                  dropDownContainer(
                    child: DropdownButton<EventTypeCategories>(
                      underline: Container(),
                      isExpanded: true,
                      iconEnabledColor: Colors.black,
                      focusColor: Colors.black,
                      hint: Text("Select Category"),
                      icon: Icon(Icons.arrow_drop_down_rounded),
                      items: eventDetail.eventTypeData?.categories?.map((value) {
                        return new DropdownMenuItem<EventTypeCategories>(
                          value: value,
                          child: Text(value.category.toString()),
                        );
                      }).toList(),
                      onChanged: (newValue) => setState(() => eventDetail.category = newValue!),
                      value: eventDetail.category,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: padding * 2),
                    child: Wrap(
                        children: listOfTags.map((e) {
                        return Padding(
                        padding: const EdgeInsets.only(top:2.0,left: 4.0),
                        child: TextButton(
                          onPressed: () {
                            if (eventDetail.eventTags!.any((element) => element.tagName==e.tagName)) eventDetail.eventTags!.removeWhere((element) => element.tagName==e.tagName);
                             else eventDetail.eventTags!.add(e);
                            setState(() {});
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.only(left:8.0,right: 8.0),
                            backgroundColor: eventDetail.eventTags!.any((element) => element.tagName==e.tagName) ? globalGreen : Colors.grey,
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
                          addCustomTags();
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
                        if ((eventDetail.firstImage.isEmpty  && eventDetail.secondImage.isEmpty && eventDetail.thirdImage.isEmpty) && (eventDetail.firstVideo.isEmpty && eventDetail.secondVideo.isEmpty  && eventDetail.thirdVideo.isEmpty) )
                          return showErrorToast("You have to add atleast 1 Photo or video");

                          if (eventDetail.category == null) return showErrorToast("You have to select a Category");

                          if (eventDetail.eventTypeData == null) return showErrorToast("You have to select a Event Type");

                        //  if (eventDetail.eventTags!.isEmpty) return showErrorToast("You have to select Some Tags");

                          eventDetail.eventTags!.map((e) => print(e.toJson())).toList();

                          CustomNavigator.navigateTo(context, EditCreateSecondPage(event: eventDetail));
                        }
                      },
                      child: text(title:'Next'.toUpperCase(), color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold )
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget dropDownContainer({required Widget child}) {
    return Container(
      height: 60,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: globalLGray,
            blurRadius: 3,
          )
        ],
      ),
      child: child,
    );
  }

  Widget text({String? title, Color? color, double? fontSize, FontWeight?  fontWeight}){
    return Text(title!, style: TextStyle(color: color!, fontSize: fontSize!, fontWeight: fontWeight));

}

}
