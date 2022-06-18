import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget switchButton({String title="", bool isSwitched=false,  void Function(bool)? onChanged }){

  return ListTile(
      title: Text(title,style: TextStyle(fontWeight: FontWeight.bold)),
      trailing: CupertinoSwitch(
        activeColor: Colors.green,
        trackColor: Colors.grey,
        onChanged: onChanged,
        value: isSwitched,
      ),
    );
}