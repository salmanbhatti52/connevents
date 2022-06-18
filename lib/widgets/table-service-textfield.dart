import 'package:connevents/variables/globalVariables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TableServiceTextField extends StatelessWidget {
  String initialValue;
  void Function(String?)? onSaved;
   TableServiceTextField({Key? key,this.initialValue="",this.onSaved}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
            children: [
              Text("\$", style: TextStyle(fontSize: 14)),
              SizedBox(width: 6),
              Container(
                height: 20,
                width: 60,
                child: Container(
                  height: 23,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: globalLGray,
                        blurRadius: 3,
                      )
                    ],
                  ),
                  child: TextFormField(
                    initialValue:   initialValue,
                    onSaved: onSaved,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [LengthLimitingTextInputFormatter(4)],
                    decoration: InputDecoration.collapsed(hintText: ""),
                  ),
                ),
              ),
            ],
          );
  }
}






class DiscountTextField extends StatelessWidget {
  String initialValue;
  void Function(String?)? onSaved;
   DiscountTextField({Key? key,this.initialValue="",this.onSaved}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
            children: [
              Text("%", style: TextStyle(fontSize: 14)),
              SizedBox(width: 6),
              Container(
                height: 20,
                width: 60,
                child: Container(
                  height: 23,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: globalLGray,
                        blurRadius: 3,
                      )
                    ],
                  ),
                  child: TextFormField(
                    initialValue:   initialValue,
                    onSaved: onSaved,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [LengthLimitingTextInputFormatter(4)],
                    decoration: InputDecoration.collapsed(hintText: ""),
                  ),
                ),
              ),
            ],
          );
  }
}

