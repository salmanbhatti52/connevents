import 'dart:math';

import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/business-type-model.dart';
import 'package:connevents/models/event-address-model.dart';
import 'package:connevents/pages/tabs/tabsPage.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/const.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/business-text.dart';
import 'package:connevents/widgets/connevent-appbar.dart';
import 'package:connevents/widgets/connevent-button.dart';
import 'package:connevents/widgets/connevents-textfield.dart';
import 'package:connevents/widgets/create-container.dart';
import 'package:connevents/widgets/create-page-text.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:flutter/material.dart';
import 'package:connevents/models/business-create-model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places_service/places_service.dart';


class BusinessCreateSecondPage extends StatefulWidget {
  final Business? business;
  final BusinessType? businessType;
  const BusinessCreateSecondPage({Key? key,this.business,this.businessType}) : super(key: key);

  @override
  _BusinessCreateSecondPageState createState() => _BusinessCreateSecondPageState();
}

class _BusinessCreateSecondPageState extends State<BusinessCreateSecondPage> {
  final key=GlobalKey<FormState>();
  Business business=Business(eventAddress: EventAddress());
  TextEditingController selectedAddress=TextEditingController();
  PlacesService  _placesService=PlacesService();
  List<PlacesAutoCompleteResult>  _autoCompleteResult=[];
  String secondaryText="";
  late TextEditingController mainText;
  late TextEditingController city;
   TextEditingController hyperLink=TextEditingController(text: "https://");
  late TextEditingController zip;
  double lat=0.0;
  double lng=0.0;
  bool isSelectedPrivacy=false;
  late TextEditingController state;
  PlacesDetails? placeDetails;
  String? dateTime;
  final List<Marker>  markers=[];
  late LatLng latLng;
  LatLng? latlng=LatLng(30.183419, 71.427832);


  void createBusiness() async{

       business.hyperlink=hyperLink.text;

       print(business.hyperlink);

       if(key.currentState!.validate()){
        key.currentState!.save();
        if(business.hyperlink.isEmpty) return showErrorToast("You have to add Website Link");
        if(business.description.isEmpty) return showErrorToast("You have to add Description");
        if(business.eventAddress!.fullAddress.isEmpty) return showErrorToast("You have to add Address");
        if(business.eventAddress!.city.isEmpty) return showErrorToast("You have to enter City");
        if(business.eventAddress!.state.isEmpty) return showErrorToast("You have to enter state");
        if(business.eventAddress!.zip.isEmpty) return showErrorToast("You have to enter zip Code");
        if(!isSelectedPrivacy) return showErrorToast("Please Accept our Policy");


       openLoadingDialog(context, "creating");
       final response= await DioService.post('create_business',{
        "title": business.title,
        "usersId": AppData().userdetail!.users_id,
         "businessLogo":business.businessLogo,
        if(business.firstImage.isNotEmpty)
          "firstImageBasecode": business.firstImage,
        if(business.secondImage.isNotEmpty)
          "secondImageBasecode": business.secondImage,
        if(business.thirdImage.isNotEmpty)
          "thirdImageBasecode": business.thirdImage,
         if(business.fourthImage.isNotEmpty)
           "fourthImageBasecode": business.fourthImage,
         if(business.fifthImage.isNotEmpty)
           "fifthImageBasecode": business.fifthImage,
         if(business.sixthImage.isNotEmpty)
           "sixthImageBasecode": business.sixthImage,
        if(business.first_video_thumbnail.isNotEmpty)
          "firstVideoThumbnail": business.first_video_thumbnail,
        if(business.second_video_thumbnail.isNotEmpty)
          "secondVideoThumbnail": business.second_video_thumbnail,
        if(business.third_video_thumbnail.isNotEmpty)
          "thirdVideoThumbnail": business.third_video_thumbnail,
        if(business.firstVideo.isNotEmpty)
          "firstVideo": business.firstVideo,
        if(business.secondVideo.isNotEmpty)
          "secondVideo": business.secondVideo,
        if(business.thirdVideo.isNotEmpty)
          "thirdVideo": business.thirdVideo,
        "description":business.description,
        "discount": business.discount,
        "address": business.eventAddress!.fullAddress,
        "city": business.eventAddress!.city,
        "state": business.eventAddress!.state,
        "zip": business.eventAddress!.zip,
        "businessLong": business.businessLong,
        "businessLat": business.businessLat,
        "hyperlink" :business.hyperlink,
        "businessType":widget.businessType!.type
      });
      print(response);
       if(response['status']=='success'){
         print(response);
       //  AppData().userdetail!.one_time_post_count=response['one_time_post_count'];
      showSuccessToast("Your Business has been Created Successfully");
      Navigator.pop(context);
      CustomNavigator.pushReplacement(context,TabsPage());
       }
       else{
         Navigator.of(context).pop();
         print(response['message']);
         showSuccessToast(response['message']);
       }
      }

  }

  addMarker(double lat, double long){
   int id=Random().nextInt(100);
    setState(() {
    markers.add(Marker(position: LatLng(business.businessLat!.toDouble(),business.businessLong!.toDouble()) , markerId: MarkerId(id.toString())));
  });
    }


    @override
  void initState() {
    super.initState();
    business=widget.business!;
    _placesService.initialize(apiKey: apiKey);
    city=TextEditingController(text: business.eventAddress!.city);
    zip=TextEditingController(text: business.eventAddress!.zip);
    state=TextEditingController(text: business.eventAddress!.state);
    mainText=TextEditingController(text: business.eventAddress!.fullAddress);
  }



  @override


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ConneventAppBar(),
      body: CreateContainer(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                businessText("Discount"),
                ConneventsTextField(
                   keyBoardType: TextInputType.number,
                   value: business.discount,
                   onSaved: (value) => setState(() => business.discount=value!)
                  // validator: (val) => val!.isEmpty ? "Please Enter Hyperlink" : null,
                 ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: padding / 1.2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      text(title:'Hyperlink',color: globalBlack, fontSize: 18,fontWeight: FontWeight.bold ),
                      text(title:'*',color: Colors.red, fontSize: 18,fontWeight: FontWeight.bold ),
                    ],
                  ),
                ),
                ConneventsTextField(
                    controller: hyperLink,
                    // hintText: "https://",
                    keyBoardType: TextInputType.text,
                    // value: "https${business.hyperlink}",
                    onSaved: (value) => setState(() => hyperLink.text=value!)
                  // validator: (val) => val!.isEmpty ? "Please Enter Hyperlink" : null,
                ),
                // businessText("Business Identification No."),
                // ConneventsTextField(
                //    hintText: "1D9032ML9239",
                //    isTextFieldEnabled: false,
                //    color: Color(0xffE5E8EF),
                //    keyBoardType: TextInputType.number,
                //    value: business.businessIdentificationNumber,
                //    onSaved: (value) => setState(() => business.businessIdentificationNumber=value!)
                //   // validator: (val) => val!.isEmpty ? "Please Enter Hyperlink" : null,
                //  ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0,bottom: 8.0),
                  child: businessText("Description"),
                ),
                ConneventsTextField(
                  value: business.description,
                  onSaved: (value) => setState(() => business.description = value!),
                  maxLines: 4,
                ),
                SizedBox(height: padding),
                Stack(
                  children: [
                    text(title: "Address*",color:globalBlack,fontSize:18,fontWeight: FontWeight.bold ),
                    Padding(
                      padding: const EdgeInsets.only(top:30.0),
                      child: ConneventsTextField(
                        controller: mainText,
                        onSaved: (value) => business.eventAddress!.fullAddress = value!,
                        onChanged: (value) async {
                          setState(() {
                            print(value);
                          });
                          final autoCompleteSuggestions = await _placesService.getAutoComplete(value);
                          _autoCompleteResult = autoCompleteSuggestions;
                        },

                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 120.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                              text(title: "City*",color:globalBlack,fontSize:14,fontWeight: FontWeight.w600 ),
                                SizedBox(height: padding / 2),
                                Container(
                                  height: 44,
                                  padding: EdgeInsets.symmetric(horizontal: padding),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: globalLGray,
                                        blurRadius: 3,
                                      )
                                    ],
                                  ),
                                  child: TextFormField(
                                    controller: city,
                                    onSaved: (value) => business.eventAddress!.city = value!,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: padding),
                          Expanded(
                            child: Column(
                              children: [
                                text(title: "State*",color:globalBlack,fontSize:14,fontWeight: FontWeight.w600 ),
                                SizedBox(height: padding / 2),
                                Container(
                                  height: 44,
                                  padding: EdgeInsets.symmetric(horizontal: padding),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: globalLGray,
                                        blurRadius: 3,
                                      )
                                    ],
                                  ),
                                  child: TextFormField(
                                    controller: state,
                                    onSaved: (value) => business.eventAddress!.state = value!,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: padding),
                          Expanded(
                            child: Column(
                              children: [
                                text(title: "Zip*",color:globalBlack,fontSize:14,fontWeight: FontWeight.bold ),
                                SizedBox(height: padding / 2),
                                Container(
                                  height: 44,
                                  padding: EdgeInsets.symmetric(horizontal: padding),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: globalLGray,
                                        blurRadius: 3,
                                      )
                                    ],
                                  ),
                                  child: TextFormField(
                                    controller: zip,
                                    onSaved: (value) => business.eventAddress!.zip = value!,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (_autoCompleteResult.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 90.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black)),
                          height: 140,
                          child: ListView.builder(
                            itemCount: _autoCompleteResult.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                visualDensity: VisualDensity(
                                    horizontal: 0, vertical: -4),
                                title: Text(_autoCompleteResult[index].mainText ?? ""),
                                subtitle: Text(_autoCompleteResult[index].description ?? ""),
                                onTap: () async {
                                  var id = _autoCompleteResult[index].placeId;
                                  final placeDetails = await _placesService.getPlaceDetails(id!);
                                  setState(() {
                                    zip.text = placeDetails.zip!;
                                    state.text = placeDetails.state!;
                                    city.text = placeDetails.city!;
                                    latlng = LatLng(lat, lng);
                                    business.businessLat = placeDetails.lat!;
                                    business.businessLong = placeDetails.lng!;
                                    mainText.text = "${_autoCompleteResult[index].mainText!} ${_autoCompleteResult[index].secondaryText}";
                                    _autoCompleteResult.clear();
                                    addMarker(business.businessLat!.toDouble(),business.businessLong!.toDouble());
                                  });
                                },
                              );
                            },
                          ),
                        ),
                      ),
                  ],
                ),
                 Padding(
                   padding: const EdgeInsets.only(top:12.0,bottom: 12.0),
                   child: businessText("Location"),
                 ),


                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: globalLGray,
                        blurRadius: 5,
                      ),
                    ],
                   ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: padding),
                        child: Text(mainText.text, style: TextStyle(color: globalBlack.withOpacity(0.5), fontSize: 16, fontWeight: FontWeight.w300, height: 2.3,),), height: 40,
                      ),
                      Expanded(
                        child: GoogleMap(
                          mapType: MapType.normal,
                          initialCameraPosition: CameraPosition(
                          target: LatLng(business.businessLat??22.735110,business.businessLong??75.917380),
                          zoom: 5.0,
                        ),
                         markers: markers.toSet()
                      )),
                    ],
                  ),
                ),
                Theme(
                  data: ThemeData(unselectedWidgetColor: Colors.black),
                  child: CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text("Privacy & Policy",style: TextStyle(color: Colors.black)),
                    selectedTileColor: Colors.white,
                    value: isSelectedPrivacy,
                    activeColor: globalGolden,
                    onChanged: (newValue) {
                      if(!isSelectedPrivacy)
                        showDialog(context: context,barrierDismissible: false,builder: (index){
                          return privacyAndPolicy(
                              onTapAccept: (){
                                isSelectedPrivacy=true;
                                setState(() {});
                                Navigator.of(context).pop();
                              },
                              onTapDecline:()=>Navigator.of(context).pop());
                        });
                      else setState(() => isSelectedPrivacy=false);
                    },
                    controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                  ),
                ),


                       Padding(
                         padding: const EdgeInsets.only(top:16.0),
                         child: ConneventButton(
                          title: "Save",
                          onPressed:() => createBusiness(),
                      ),
                       )

              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget privacyAndPolicy({void Function()? onTapAccept,void Function()? onTapDecline}){
  return AlertDialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0)
    ),
    title: Center(child: Text("Privacy & Policy",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black))),
    content: SingleChildScrollView(
      child: Column(
        children: [
          Text(" This service is totally free only for businesses. See our terms and conditions and privacy policy to learn what businesses are eligible to use this service"
              ".Allow event users to see your business based on their location."
              ". Access to our platform with a community of users to interact with your business' services or menu in one place.",
            textAlign: TextAlign.justify,
          )
        ],
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(onPressed: onTapAccept, child: Text("Accept")),
            ElevatedButton(onPressed: onTapDecline, child: Text("Decline")),
          ],
        ),
      ),
    ],
  );


}