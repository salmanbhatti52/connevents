import 'dart:convert';
import 'dart:io';
import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/business-type-model.dart';
import 'package:connevents/models/event-address-model.dart';
import 'package:connevents/pages/BusinessCreate/businessCreateSecondPage/business-create-second-page.dart';
import 'package:connevents/pages/Dashboard/eventDashboard/eventDashboardPage.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/business-first-page-text.dart';
import 'package:connevents/widgets/connevent-button.dart';
import 'package:connevents/widgets/connevents-textfield.dart';
import 'package:connevents/widgets/create-page-text.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:connevents/widgets/event-video-picker.dart';
import 'package:connevents/widgets/image-container.dart';
import 'package:connevents/widgets/upload-logo-picker.dart';
import 'package:flutter/material.dart';
import 'package:connevents/models/business-create-model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:path_provider/path_provider.dart';

class BusinessCreateFirstPage extends StatefulWidget {
  const BusinessCreateFirstPage({Key? key}) : super(key: key);

  @override
  _BusinessCreateFirstPageState createState() => _BusinessCreateFirstPageState();
}

class _BusinessCreateFirstPageState extends State<BusinessCreateFirstPage> {

  Business business= Business(eventAddress: EventAddress());
  List<File>  imagePath=[];
  List<Asset> listOfImages = [];
  String pickedImage="";
  CroppedFile? imageFile;
  List<BusinessType> businessTypeList = [];
  BusinessType? businessType;
  String baseCOde='';
  List resultList=[];
  List tempArray=[];


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
              imageFile = croppedFile;
            });
        }

  }

  Future loadAssets() async {
    if (imagePath.length == 6) return;
    try {
      tempArray=resultList;
       resultList.addAll( await MultiImagePicker.pickImages(
          maxImages: 6 - imagePath.length,
          enableCamera: false,
          selectedAssets: listOfImages,
          cupertinoOptions: CupertinoOptions(
            takePhotoIcon: "chat",
            doneButtonTitle: "Photo",
          ),
          materialOptions: MaterialOptions(
            actionBarColor: "#abcdef",
            actionBarTitle: "Connevent",
            allViewTitle: "All Photos",
            useDetailsView: false,
            selectCircleStrokeColor: "#000000",
          )));

      for(var i=0 ; i<   resultList.length; i++){
      final byteData = await resultList[i].getByteData();
      final tempFile = File("${(await getTemporaryDirectory()).path}/${resultList[i].name}");
      final file = await tempFile.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));


       print(resultList.length);

      if (i==0) {
        if(!imagePath.asMap().containsKey(0)){
          await _cropImage(file.path);
          imagePath.add(File(imageFile!.path));
          //imagePath.add(file);
          final bytes = await file.readAsBytes();
          business.firstImage = base64Encode(bytes);
          setState(() {});
        }

    }

    if (i==1) {
      print("first");
      if(!imagePath.asMap().containsKey(1)){
        await _cropImage(file.path);
        imagePath.add(File(imageFile!.path));
       // imagePath.add(file);
        final bytes2 = await file.readAsBytes();
        business.secondImage = base64Encode(bytes2);
        print(business.secondImage);
        setState(() {});
      }

    }
    if (i==2) {
      print("helooo");
      if(!imagePath.asMap().containsKey(2)){
        await _cropImage(file.path);
        imagePath.add(File(imageFile!.path));
        // imagePath.add(file);
        final bytes3 = await file.readAsBytes();
        business.thirdImage = base64Encode(bytes3);
        setState(() {});
      }

    }
      if (i==3) {
        print("helooo");
        if(!imagePath.asMap().containsKey(3)){
          await _cropImage(file.path);
          imagePath.add(File(imageFile!.path));
          // imagePath.add(file);
          final bytes4 = await file.readAsBytes();
          business.fourthImage = base64Encode(bytes4);
          print(business.fourthImage);
          setState(() {});
        }

      }
      if (i==4) {
        print("helooo");
        if(!imagePath.asMap().containsKey(4)){
          await _cropImage(file.path);
          imagePath.add(File(imageFile!.path));
          // imagePath.add(file);
          final bytes5 = await file.readAsBytes();
          business.fifthImage = base64Encode(bytes5);
          print(business.fifthImage);
          setState(() {});
        }

      }
      if (i==5) {
        if(!imagePath.asMap().containsKey(5)){
          await _cropImage(file.path);
          imagePath.add(File(imageFile!.path));
          // imagePath.add(file);
          final bytes6 = await file.readAsBytes();
          business.sixthImage = base64Encode(bytes6);
          setState(() {});
        }

      }
      }
    } on Exception catch (e) {
      print(e.toString());
    }

    if (!mounted) return;
  }

  Future getBusinessTypes() async {
    try{
      var response = await DioService.get('get_business_types');
       var json = response['data'] as List;
        businessTypeList   = json.map<BusinessType>((e) => BusinessType.fromJson(e)).toList();
        // businessType=businessTypeList.first;
        setState(() {});
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

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
         openLoadingDialog(context, "loading");
         getBusinessTypes();
          });
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
            padding: const EdgeInsets.only(top:padding*2 ,bottom: padding / 9),
            child: Text('Add Business', style: TextStyle(color: globalBlack, fontSize: 30, fontWeight: FontWeight.bold),),
          ),
           businessFirstPageText('Upload Logo'),
            Container(
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(20)
               ),
                height: 135,
                child: Stack(
                  children: [
                    UploadLogoPicker(
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
                onSaved: (val) => setState(() => business.title = val!),
                hintText: 'Enter Business Name',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                imagePath.asMap().containsKey(0) ? Expanded(
                child: SizedBox(
                    height: 160,
                    child: Stack(
                      children: [
                        Image.file(imagePath[0],width: 200, height: 305,fit: BoxFit.fill),
                         Positioned(
                            top: 2,
                            right: -2,
                            child: SizedBox(
                              height: 30,
                              child: CircleAvatar(
                                backgroundColor: Colors.red,
                                child: IconButton(
                                    icon: Icon(Icons.delete, color: Colors.white, size: 15,),
                                    onPressed: () => setState((){
                                      imagePath.remove(imagePath.elementAt(0));
                                      resultList.remove(resultList.elementAt(0));
                                    })),
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
                        Image.file(imagePath[1],width: 200, height: 305,fit: BoxFit.fill),
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
                                  resultList.remove(resultList.elementAt(1));
                                })),
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
                SizedBox(width: padding),
               imagePath.asMap().containsKey(2) ?
               Expanded(
                   child: SizedBox( height: 160,
                   child: Stack(
                     children: [
                        Image.file(imagePath[2],width: 200, height: 305,fit: BoxFit.fill),
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
                                      resultList.remove(resultList.elementAt(2));
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                imagePath.asMap().containsKey(3) ? Expanded(
                    child: SizedBox(
                        height: 160,
                        child: Stack(
                          children: [
                            Image.file(imagePath[3],width: 200, height: 305,fit: BoxFit.fill),
                            Positioned(
                              top: 2,
                              right: -2,
                              child: SizedBox(
                                height: 30,
                                child: CircleAvatar(
                                  backgroundColor: Colors.red,
                                  child: IconButton(
                                      icon: Icon(Icons.delete, color: Colors.white, size: 15),
                                      onPressed: () => setState(() {
                                        imagePath.remove(imagePath.elementAt(3));
                                        resultList.remove(resultList.elementAt(3));
                                      })),
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
                imagePath.asMap().containsKey(4) ?
                Expanded(
                    child: SizedBox(
                        height: 160,
                        child: Stack(
                          children: [
                            Image.file(imagePath[4],width: 200, height: 305,fit: BoxFit.fill),
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
                                        imagePath.remove(imagePath.elementAt(4));
                                        resultList.remove(resultList.elementAt(4));

                                      })),
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
                SizedBox(width: padding),
                imagePath.asMap().containsKey(5) ?
                Expanded(child:
                SizedBox( height: 160,
                    child: Stack(
                      children: [
                        Image.file(imagePath[5],width: 200, height: 305,fit: BoxFit.fill),
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
                                      imagePath.remove(imagePath.elementAt(5));
                                      resultList.remove(resultList.elementAt(5));
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
                    onThumbNail: (thumb,thumbNail) async
                    {
                      business.firstThumbNail = thumb;
                      List<int> imageBytes = thumbNail.readAsBytesSync();
                      business.first_video_thumbnail = base64Encode(imageBytes);
                    },
                    onVideoPicked: (file) async {
                      business.firstVideo = file;
                    },
                    onVideoDeleted: () async {
                      openLoadingDialog(context, "deleting");
                   var res   = await DioService.post('delete_video', {
                         'fileName': business.firstVideo
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
                      business.secondThumbNail = thumb;
                      List<int> imageBytes = thumbNail.readAsBytesSync();
                      business.second_video_thumbnail = base64Encode(imageBytes);
                    },
                    onVideoPicked: (file) async {
                     business.secondVideo = file;
                    },
                    onVideoDeleted: () async {
                      openLoadingDialog(context, "Deleting");
                   var res   = await DioService.post('delete_video', {
                         'fileName': business.secondVideo
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
                       business.thirdThumbNail = thumb;
                        List<int> imageBytes = thumbNail.readAsBytesSync();
                      business.third_video_thumbnail = base64Encode(imageBytes);
                    },
                    onVideoPicked: (file) async {
                      business.thirdVideo = file;
                    },
                    onVideoDeleted: () async {
                      openLoadingDialog(context, "Deleting");
                   var res   = await DioService.post('delete_video', {
                         'fileName': business.thirdVideo
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
                  text(title:'Business Type',color: globalBlack, fontSize: 18,fontWeight: FontWeight.bold ),
                  text(title:'*',color: Colors.red, fontSize: 18,fontWeight: FontWeight.bold ),
                ],
              ),
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
                onChanged: (newValue){
                  print(newValue);
                  businessType = newValue!;
                  setState(() {});
                },
                value:  businessType,
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
                   if ((business.firstVideo.isEmpty && business.secondVideo.isEmpty  && business.thirdVideo.isEmpty) && (imagePath.length < 1) )
                     return showErrorToast("You have to add atleast 1 image or video");
                    CustomNavigator.navigateTo(context, BusinessCreateSecondPage(business:business,businessType: businessType));
                  }
              },
            )
          ],
        ),
      ),
    );
  }
}
