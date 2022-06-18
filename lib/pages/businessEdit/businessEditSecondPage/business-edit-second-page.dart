import 'dart:math';
import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/event-address-model.dart';
import 'package:connevents/pages/tabs/tabsPage.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/const.dart';
import 'package:connevents/utils/detect-link.dart';
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


class BusinessEditSecondPage extends StatefulWidget {
  final Business? business;
  const BusinessEditSecondPage({Key? key,this.business}) : super(key: key);

  @override
  _BusinessEditSecondPageState createState() => _BusinessEditSecondPageState();
}

class _BusinessEditSecondPageState extends State<BusinessEditSecondPage> {
  final key=GlobalKey<FormState>();
  Business business=Business(eventAddress: EventAddress());
  TextEditingController selectedAddress=TextEditingController();
  PlacesService  _placesService=PlacesService();
  List<PlacesAutoCompleteResult>  _autoCompleteResult=[];
  String secondaryText="";
  late TextEditingController mainText;
  late TextEditingController city;
  late TextEditingController zip;
  double lat=0.0;
  double lng=0.0;
  late TextEditingController state;
  PlacesDetails? placeDetails;
  String? dateTime;
  final List<Marker>  markers=[];
  late LatLng latLng;
  LatLng? latlng=LatLng(30.183419, 71.427832);


  void createBusiness() async{





      if(key.currentState!.validate()){
        key.currentState!.save();

        if(business.hyperlink.isEmpty) return showErrorToast("You have to add Any Website Link");
        if(business.description.isEmpty) return showErrorToast("You have to add Description");
        if(business.address.isEmpty) return showErrorToast("You have to add Address");
        if(business.city.isEmpty) return showErrorToast("You have to enter City");
        if(business.state.isEmpty) return showErrorToast("You have to enter state");
        if(business.zip.isEmpty) return showErrorToast("You have to enter zip Code");

       openLoadingDialog(context, "editing");
       final response= await DioService.post('edit_business',{
        "title": business.title,
        "usersId": AppData().userdetail!.users_id,
         "businessId":business.businessId,
         if(business.businessLogo.isNotEmpty && !business.businessLogo.contains('https'))
         "businessLogo":business.businessLogo,
        if(business.firstImage.isNotEmpty && !business.firstImage.contains('https'))
          "firstImageBasecode": business.firstImage,
        if(business.secondImage.isNotEmpty && !business.secondImage.contains('https'))
          "secondImageBasecode": business.secondImage,
        if(business.thirdImage.isNotEmpty && !business.thirdImage.contains('https'))
          "thirdImageBasecode": business.thirdImage,
        if(business.first_video_thumbnail.isNotEmpty && business.first_video_thumbnail.contains('https'))
          "firstVideoThumbnail": business.first_video_thumbnail,
        if(business.second_video_thumbnail.isNotEmpty && business.second_video_thumbnail.contains('https'))
          "secondVideoThumbnail": business.second_video_thumbnail,
        if(business.third_video_thumbnail.isNotEmpty && business.third_video_thumbnail.contains('https'))
          "thirdVideoThumbnail": business.third_video_thumbnail,
        if(business.firstVideo.isNotEmpty && business.firstVideo.contains('https'))
          "firstVideo": business.firstVideo,
        if(business.secondVideo.isNotEmpty && business.secondVideo.contains('https'))
          "secondVideo": business.secondVideo,
        if(business.thirdVideo.isNotEmpty && business.thirdVideo.contains('https'))
          "thirdVideo": business.thirdVideo,
        "description":business.description,
        "discount": business.discount,
        "address": business.address,
        "city": business.city,
        "state": business.state,
        "zip": business.zip,
        "businessLong": business.businessLong,
        "businessLat": business.businessLat,
        "hyperlink" :business.hyperlink,
         "businessType" : business.businessType!.type
        // "businessIdentificationNo" : business.businessIdentificationNumber,
      });
      print(response);
       if(response['status']=='success'){
         print(response);
       //  AppData().userdetail!.one_time_post_count=response['one_time_post_count'];
         showSuccessToast("Your Business has been edit Successfully");
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
    city=TextEditingController(text: business.city);
    zip=TextEditingController(text: business.zip);
    state=TextEditingController(text: business.state);
    mainText=TextEditingController(text: business.address);
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child:ConneventsTextField(
                    keyBoardType: TextInputType.url,
                    value: business.hyperlink,
                    onSaved: (value) {
                      bool link = isLink(value!);
                      print(link);
                      if(link){
                        setState(() {
                          business.hyperlink = value;
                          print(business.hyperlink);
                        });
                      }
                    },
                    // validator: (val) => val!.isEmpty ? "Please Enter Hyperlink" : null,
                  ),
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
                        onSaved: (value) => business.address = value!,
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
                                    onSaved: (value) => business.city = value!,
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
                                    onSaved: (value) => business.state = value!,
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
                                    onSaved: (value) => business.zip = value!,
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
                                    mainText.text = "${_autoCompleteResult[index].mainText!} " + _autoCompleteResult[index].secondaryText!;
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
