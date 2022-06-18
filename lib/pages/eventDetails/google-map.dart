import 'dart:math';

import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/create-event-model.dart';
import 'package:connevents/models/user-location-model.dart';
import 'package:connevents/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapAddress extends StatefulWidget {

  final EventDetail event;

  const GoogleMapAddress({Key? key,required this.event}) : super(key: key);

  @override
  _GoogleMapAddressState createState() => _GoogleMapAddressState();
}

class _GoogleMapAddressState extends State<GoogleMapAddress> {


 double _originLatitude = 26.48424, _originLongitude = 50.04551;
  double _destLatitude = 26.46423, _destLongitude = 50.06358;
   // final List<Marker>  markers=[];
late LatLng latLng;
GoogleMapController? mapController;

Map<MarkerId, Marker> markers = {};
 Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

var userCurrentLocation;

  Future getUserLocation({lat, long}) async {
    var currentLocation;
    try{
        currentLocation = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
        userCurrentLocation=currentLocation;
            setState(() {
   AppData().userLocation    = UserLocation(latitude: userCurrentLocation.latitude, longitude: userCurrentLocation.longitude);
            });
        print("i am here the location");
        print(AppData().userLocation!.toJson());
        print("i am here the location");
        print(userCurrentLocation.longitude);
    }
    catch(e){
      print(e.toString());
    }
  }




  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }


   _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        apiKey, PointLatLng(AppData().userLocation!.latitude!, AppData().userLocation!.longitude!),
        PointLatLng(widget.event.locationLat!, widget.event.locationLong!),
        travelMode: TravelMode.driving,
       // wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]
         );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }



  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }


   void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }



//  addMarker(double lat, double long){
//    int id=Random().nextInt(100);
// setState(() {
//   markers.add(Marker(position: LatLng(lat,long) , markerId: MarkerId(id.toString())));
// });
//  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
_addMarker(LatLng(AppData().userLocation!.latitude!, AppData().userLocation!.longitude!), "origin",
        BitmapDescriptor.defaultMarker);
    _addMarker(LatLng(widget.event.locationLat!, widget.event.locationLong!), "destination",
        BitmapDescriptor.defaultMarkerWithHue(90));
    _getPolyline();
    if(AppData().userLocation == null)
    getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
elevation: 0.0,
      ),
      body: GoogleMap(
        mapType: MapType.normal,
      initialCameraPosition: CameraPosition(target: LatLng(AppData().userLocation!.latitude!, AppData().userLocation!.longitude!),
          zoom: 5.0),
      myLocationEnabled: true,
      tiltGesturesEnabled: true,
      compassEnabled: true,
      scrollGesturesEnabled: true,
      zoomGesturesEnabled: true,
      onMapCreated: _onMapCreated,
      markers: Set<Marker>.of(markers.values),
      polylines: Set<Polyline>.of(polylines.values),
      ),
    );
  }
}
