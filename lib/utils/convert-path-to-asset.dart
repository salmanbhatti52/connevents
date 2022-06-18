import 'dart:io';
import 'package:flutter/material.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';


  Future<Asset> fileToAsset(File image) async {
    var uuid = Uuid();
    String fileName = basename(image.path);
    var decodedImage = await decodeImageFromList(image.readAsBytesSync());
    return Asset(uuid.v4(), fileName, decodedImage.width, decodedImage.height);
  }