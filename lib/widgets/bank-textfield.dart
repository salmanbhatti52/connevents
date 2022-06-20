
import 'package:connevents/variables/globalVariables.dart';
import 'package:flutter/material.dart';

class BankTextField extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  void Function(String?)? onSaved;
  String? hintText;
  final TextInputType? keyBoardType;
  String? labelText;
  final  bool autoFocus;

  FocusNode? focusNode;
  BankTextField({Key? key ,this.keyBoardType,this.validator,this.labelText,this.hintText,this.onSaved,this.autoFocus=false,this.controller,this.onChanged,this.focusNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top:padding,bottom: padding),
      decoration: BoxDecoration(color: Colors.white),
      child: TextFormField(
        onSaved: onSaved,
        keyboardType: keyBoardType,
        style: TextStyle(color: globalBlack , height: 1.7 , fontSize: 14 , fontWeight: FontWeight.normal,),
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color:Colors.green,
                width:1.0,
              )),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color:Colors.green,
                width:1.0,
              )),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color:Colors.blue,
                width:1.0,
              )
          ),
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.black),
          hintStyle: TextStyle(color: globalBlack.withOpacity(0.5) , height: 1.7 , fontSize: 14 , fontWeight: FontWeight.normal,),
        ),
      ),
      );
  }


}





class BankAccountTextField extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  void Function(String?)? onSaved;
  String? hintText;
  final  bool autoFocus;
  FocusNode? focusNode;
  BankAccountTextField({Key? key ,this.autoFocus=false,this.controller,this.onChanged,this.focusNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top:padding,bottom: padding),
      decoration: BoxDecoration(color: Colors.white),
      child: TextFormField(
        onSaved: onSaved,
        keyboardType: TextInputType.number,
        style: TextStyle(color: globalBlack , height: 1.7 , fontSize: 14 , fontWeight: FontWeight.normal,),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color:Colors.blue,
                width:2.0,
              )),

          border: OutlineInputBorder(
              borderSide: BorderSide(
                color:Colors.blue,
                width:2.0,
              )
          ),
          labelText: 'ZIP CODE',
          labelStyle: TextStyle(color: Colors.black),
          hintStyle: TextStyle(color: globalBlack.withOpacity(0.5) , height: 1.7 , fontSize: 14 , fontWeight: FontWeight.normal,),
        ),
      ),
    );
  }


}