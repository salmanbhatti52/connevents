import 'dart:io';

import 'package:connevents/pages/emojisPicker/emojis-picker.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

class EventCommentTextField extends StatelessWidget {
 final TextEditingController? controller;
 final void Function(String)? onChanged;
 final  void Function()? onTapIcon;
 final  void Function()? onTapEmoji;
 final  void Function()? onTap;
 bool isReply;
 final  bool autoFocus;
  FocusNode? focusNode;
   EventCommentTextField({Key? key,this.isReply=false,this.onTap,this.autoFocus=false,this.controller,this.onChanged,this.focusNode,this.onTapIcon,this.onTapEmoji}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
        padding: EdgeInsets.only(top:padding,bottom: padding),
        decoration: BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            IconButton(
                   icon:Icon(Icons.emoji_emotions, color: globalGreen),
                   onPressed: onTapEmoji),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  autofocus: autoFocus,
                  controller: controller,
                  focusNode: focusNode,
                  onChanged: onChanged,
                  onTap: onTap,
                  style: TextStyle(color: globalBlack, fontSize: 12, height: 2),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    fillColor: globallightbg,
                    hintText:isReply ?'Type your Reply here....' :  'Type your comment here....',
                    hintStyle: TextStyle(color: globalBlack.withOpacity(0.7), fontSize: 12, height: 2,
                    ),
                  ),
                ),
              ),
            ),
            IconButton(icon:Icon(Icons.send, color: globalGreen), onPressed: onTapIcon
            ),
          ],
        ),
      ),

      ],
    );
  }


}
