import 'package:connevents/variables/globalVariables.dart';
import 'package:flutter/material.dart';

class CustomTagContainer extends StatelessWidget {
  TextEditingController tagText;
   void Function() onPressed;
   CustomTagContainer({Key? key,required this.onPressed,required this.tagText}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
            children: [
              Container(
                height: 40,
                width: 110,
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
                  controller: tagText,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top:22,left:10),
                    hintStyle: TextStyle(fontSize: 13),
                    border:  OutlineInputBorder(
                      borderSide: BorderSide.none
                    ),
                    hintText: "Custom Tag",
                  ),

                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:10.0),
                child: IconButton(
                        onPressed: onPressed,
                        icon: Icon(Icons.add_circle_outline_rounded)),
              )
            ],
          );
  }
}
