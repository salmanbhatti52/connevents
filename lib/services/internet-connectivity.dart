// import 'dart:async';
//
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/services.dart';
//
// mixin InternetConnectivity {
//  static  ConnectivityResult _connectionStatus = ConnectivityResult.none;
//  static  final Connectivity _connectivity = Connectivity();
//  static  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
//    // Platform messages are asynchronous, so we initialize in an async method.
//  static  Future<void> initConnectivity() async {
//     late ConnectivityResult result;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     try {
//       result = await _connectivity.checkConnectivity();
//     } on PlatformException {
//      // developer.log('Couldn\'t check connectivity status', error: e);
//       return;
//     }
// //      return Future.value(null);
//
//     return _updateConnectionStatus(result);
//   }
//
//  static Future<void> _updateConnectionStatus(ConnectivityResult result) async {
//       _connectionStatus = result;
//   }
//
//
//
// }