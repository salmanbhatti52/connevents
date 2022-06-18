import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

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

  static void initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async{
          final Uri? deepLink=dynamicLink!.link;
          if(deepLink!=null){
            Get.toNamed('/help');
            print("deep Link ${dynamicLink.toString()}");
          }
        },
      onError: (OnLinkErrorException e) async{
          print(e.message);
      }
    );
  }

  factory AppData() {
    if (_isInitiated!) {
      return AppData._();
    } else {
      throw 'AppData has not been initialized';
    }
  }
}
