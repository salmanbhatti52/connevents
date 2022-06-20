import 'dart:io';
import 'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';


class EmojisPickerPage extends StatefulWidget {
  Function(String emoji) emoji;
   EmojisPickerPage({Key? key,required this.emoji}) : super(key: key);

  @override
  State<EmojisPickerPage> createState() => _EmojisPickerPageState();
}

class _EmojisPickerPageState extends State<EmojisPickerPage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: EmojiPicker(
       onEmojiSelected: (category, emoji) {
         widget.emoji(emoji.emoji);
          // Do something when emoji is tapped
      },
      onBackspacePressed: () {

          // Backspace-Button tapped logic
          // Remove this line to also remove the button in the UI
      },
      config: Config(
          columns: 7,
          emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0), // Issue: https://github.com/flutter/flutter/issues/28894
          verticalSpacing: 0,
          horizontalSpacing: 0,
          initCategory: Category.RECENT,
          bgColor: Color(0xFFF2F2F2),
          indicatorColor: Colors.blue,
          iconColor: Colors.grey,
          iconColorSelected: Colors.blue,
          progressIndicatorColor: Colors.blue,
          backspaceColor: Colors.blue,
          skinToneDialogBgColor: Colors.white,
          skinToneIndicatorColor: Colors.grey,
          enableSkinTones: true,
          showRecentsTab: true,
          recentsLimit: 28,
          noRecents: Text("No Recents",style: TextStyle(fontSize: 20, color: Colors.black26),),
          tabIndicatorAnimDuration: kTabScrollDuration,
          categoryIcons: const CategoryIcons(),
          buttonMode: ButtonMode.MATERIAL
      ),
),
    );
  }
}
