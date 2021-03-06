import 'package:connevents/utils/loading-dialog.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'auth_mixin.dart';

/// Export All Models;

class AppData with AuthData {
  AppData._();
  static  bool? _isInitiated;
  static Future initiate() async {
    await Hive.initFlutter();
    // Hive.registerAdapter(ImageModelAdapter());
    await AuthData.initiate();
    _isInitiated = true;
  }


  static   checkConnectivity() async {
    bool  hasInternet  = await  InternetConnectionChecker().hasConnection;
    if(!hasInternet){
      showErrorToast("Please Check Your Internet Connection");
    }
  }



  factory AppData() {
    if (_isInitiated!) {
      return AppData._();
    } else {
      throw 'AppData has not been initialized';
    }
  }
}
