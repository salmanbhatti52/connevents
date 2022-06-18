import 'package:connevents/utils/const.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/categories-button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:places_service/places_service.dart';

class CityDialogBox extends StatefulWidget {
  Function(String city) city;
  double? width;
  CityDialogBox({Key? key,required this.city,this.width}) : super(key: key);

  @override
  _CityDialogBoxState createState() => _CityDialogBoxState();
}

class _CityDialogBoxState extends State<CityDialogBox> {

  List <Placemark>? placeMark;
  late Position userLocation;
  PlacesService  _placesService=PlacesService();
  List<PlacesAutoCompleteResult>  _autoCompleteResult=[];
  TextEditingController cities=TextEditingController();
  TextEditingController mainText=TextEditingController();

  TextEditingController zip = TextEditingController();
  PlacesDetails? placeDetails;
  String city='';

  Future _getLocation() async {
    var currentLocation;
    try {
      currentLocation = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      userLocation=currentLocation;
      setState(() {});
      List<Placemark> placeMarks = await placemarkFromCoordinates(userLocation.latitude,userLocation.longitude);
      city=placeMarks[0].locality!;
      widget.city(city);
      print(city);
    } catch (e) {
      currentLocation = null;
    }
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _placesService.initialize(apiKey: apiKey);
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CategoriesButton(
        onPressed: (){
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return StatefulBuilder(
                  builder: (context, setState){
                    return Dialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        backgroundColor: Colors.transparent,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 30),
                          width: size.width,
                          height: size.height - 100,
                          padding: EdgeInsets.all(11.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(color: globalGreen),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.transparent,
                                offset: Offset(0, 2),
                                blurRadius: 1,
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              SingleChildScrollView(
                                physics:BouncingScrollPhysics(),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text("City", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                                      SizedBox(height: 20),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                        child: GestureDetector(
                                          onTap: ()async{
                                            openLoadingDialog(context, 'Loading');
                                            await _getLocation();
                                          },
                                          child: TextFormField(
                                            cursorColor: globalGreen,
                                            enabled: false,
                                            decoration: InputDecoration(
                                              icon: Icon(Icons.my_location, size: 30),
                                              labelText: "Your Location",
                                              labelStyle: TextStyle(color: Colors.black, fontSize: 14),

                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 7),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 4,
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                          child: TextFormField(
                                            controller: mainText,
                                            onChanged: (value) async {
                                              if(value.isNotEmpty){
                                                final autoCompleteSuggestions = await _placesService.getAutoComplete(value);
                                                _autoCompleteResult = autoCompleteSuggestions;
                                              }
                                              else _autoCompleteResult.clear();
                                              setState(() {});
                                            },
                                            cursorColor: globalGreen,
                                            decoration: InputDecoration(
                                              icon: Icon(Icons.search, size: 30),
                                              labelText: "Search",
                                              labelStyle: TextStyle(color: Colors.black, fontSize: 14),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 7),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                        child: Container(
                                          height: 500,
                                          child: ListView.builder(
                                              physics: NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount:_autoCompleteResult.length,
                                              itemBuilder: (context,index){
                                                print(_autoCompleteResult[index].toJson());
                                                return ListTile(
                                                  title: Text(_autoCompleteResult[index].description??""),
                                                  onTap: () async {
                                                    mainText.clear();
                                                    openLoadingDialog(context,"loading");
                                                    var id = _autoCompleteResult[index].placeId;
                                                    final placeDetails = await _placesService.getPlaceDetails(id!);
                                                    city=placeDetails.city!;
                                                    widget.city(placeDetails.city!);
                                                    _autoCompleteResult.clear();
                                                    setState(() {});
                                                  },
                                                );
                                              }),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: -8,
                                right: -4,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Icon(Icons.close, size: 32,color: globalGreen),
                                ),
                              ),
                            ],
                          ),
                        )
                    );

                  },
                );
              });
        },
        child: Container(
            width: widget.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(city.isNotEmpty ?  city :'City', style: TextStyle(color: Colors.black, fontSize: 10,),),
              Padding(
                padding: const EdgeInsets.only(left:4.0),
                child: city.isEmpty ? SvgPicture.asset('assets/icons/downArrow.svg', color: globalGreen, width: 10,)
                    : GestureDetector(
                  onTap: () async{
                    city="";
                    openLoadingDialog(context, "loading");
                    widget.city(city);
                  },
                  child: Container(
                      height: 20,
                      width:20,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: globalGreen,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: SvgPicture.asset('assets/icons/cross.svg', color: Colors.white, width: 10)),
                ),
              ),

            ],
          ),
        )
    );
  }
}