// import 'package:connevents/models/location_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:location/location.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// Future<LocationModel?> _handleGranted({
//   Location? location,
//   BuildContext? context,
//   LocationModel? prevLocation
// }) async {
//   LocationModel? result;
//
//   /// Check if the gps is on.
//   if (await location!.requestService()) {
//     if (prevLocation != null) {
//       result = await navigateTo(context!, LocationPickerMapPage(LatLng(
//         prevLocation.latitude!,
//         prevLocation.longitude!
//       )));
//     } else {
//       result = await navigateTo(context!, LocationPickerMapPage());
//     }
//
//     return result;
//   }
//
//
// }
//
// Future<LocationModel?> _handleDenied({
//   Location? location,
//   BuildContext? context,
//   PermissionStatus? status,
//   LocationModel? prevLocation
// }) async {
//   LocationModel _location;
//
//    await showDialog(
//     context: context!,
//     builder: (context) => LocationPermissionErrorDialog(onPressed: () async {
//       // openLoadingDialog(context, AppLocalizations.of(context).processing);
//      bool _serviceEnabled = await location!.serviceEnabled();
//       if (!_serviceEnabled) {
//         _serviceEnabled = await location.requestService();
//         if (!_serviceEnabled) {
//           return;
//         }
//       }
//         status = await location.requestPermission();
//         print(status);
//       // Navigator.of(context).pop();
//       if (status == PermissionStatus.deniedForever) {
//         /// Close Dialog.
//         // Navigator.of(context).pop();
//         bool? _serviceEnabled = await location.serviceEnabled();
//         if (!_serviceEnabled) {
//           _serviceEnabled = await location.requestService();
//           if (!_serviceEnabled) {
//             return;
//           }
//         }
//         /// Open App Settings to grant permission.
//         await AppSettings.openLocationSettings();
//       } else if (status == PermissionStatus.granted) {
//         // Navigator.of(context).pop();
//
//         _location = (await _handleGranted(
//           context: context,
//           location: location,
//           prevLocation: prevLocation,
//         ))!;
//         print("Granted Location");
//         print(_location.toJson());
//         Navigator.of(context).pop();
//
//       }
//     })
//   );
//
//
// }
//
// Future<LocationModel?> processLocationPicking(BuildContext context, {LocationModel? prevLocation}) async {
//   final _location = Location();
//   LocationModel? locationModel;
//   var _permission = await _location.hasPermission();
//   switch (_permission) {
//     case PermissionStatus.granted:
//       print(_permission);
//       locationModel = (await _handleGranted(
//         context: context,
//         location: _location,
//         prevLocation: prevLocation,
//       ))!;
//       return locationModel;
//     case PermissionStatus.denied:
//       print(_permission);
//       locationModel = (await _handleDenied(
//         context: context,
//         status: _permission,
//         location: _location,
//         prevLocation: prevLocation,
//       ));
//       print("exited");
//       return locationModel;
//     case PermissionStatus.deniedForever:
//       print(_permission);
//       locationModel = (await _handleDenied(
//         context: context,
//         status: _permission,
//         location: _location,
//         prevLocation: prevLocation,
//       ))!;
//       return locationModel;
//     case PermissionStatus.grantedLimited:
//       break;
//   }
//
// }
//
// void processUserLocationPicking(BuildContext context, {
//   Function? onLocationPicked,
//   LocationModel? prevLocation,
// }) async {
//   final _pickedLocation = await processLocationPicking(context,
//     prevLocation: prevLocation
//   );
//
//   if (_pickedLocation != null) {
//     onLocationPicked!();
//   }
// }
