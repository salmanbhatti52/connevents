import 'dart:async';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


Future performLazyTask(
  BuildContext context,
  Future<dynamic> Function() task, {
   String? message,
  bool persistent = true,
}) async {
  if(message==null) message = "processing";
  openLoadingDialog(context, message);

  final result = await task();
  Navigator.of(context).pop();

  return result;
}
