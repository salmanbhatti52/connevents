import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

 class CopyData{

 static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

 static Future copyFile() async {
   print("hellloooo");
    final path = await _localPath;
    Clipboard.setData(new ClipboardData(text: "content://${_localPath}/assets/logo.png"));
    return path;
  }





}