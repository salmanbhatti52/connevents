import 'package:connevents/models/comments-model.dart';
import 'package:connevents/models/mention-model.dart';
import 'package:connevents/widgets/profile-image-picker.dart';
import 'package:flutter/material.dart';

class BusniessCommentsMentionUsers extends StatefulWidget {
   Function(bool)? isShown;
   Function(TextEditingController)? selectedMentionName;
   List<MentionCommentUserList> mentionCommentList;
   BusniessCommentsMentionUsers({Key? key,this.isShown,this.selectedMentionName,this.mentionCommentList=const []}) : super(key: key);

  @override
  _BusniessCommentsMentionUsersState createState() => _BusniessCommentsMentionUsersState();
}

class _BusniessCommentsMentionUsersState extends State<BusniessCommentsMentionUsers> {

  List<Comments> comments=[];
  int? selectedComment;
  late FocusNode myFocusNode;
  TextEditingController mentionName=TextEditingController();
  bool isReply=false;

  String mentionNameSelected="";
  int? selectedId;





  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
            padding:  EdgeInsets.only(bottom: 5),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 4,
                        offset: Offset(1, 1), // Shadow position
                      ),
                    ],
                    color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                width: MediaQuery.of(context).size.width *0.6,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.mentionCommentList.length,
                    itemBuilder: (context,index){
                      MentionCommentUserList list=widget.mentionCommentList[index];
                  return ListTile(
                    onTap: (){
                      mentionName.text=list.userName! +" ";
                      mentionName.selection= TextSelection.fromPosition(TextPosition(offset: mentionName.text.length));
                      //  mentionName.text= mentionName.text.substring(0, value.length-1);
                      mentionNameSelected=list.userName!;
                      widget.selectedMentionName!(mentionName);
                      selectedId=list.usersId;
                      widget.isShown!(false);
                      setState(() {});
                    },
                    dense: true,
                    minVerticalPadding: 0,
                    leading: Container(
                      height: 40,
                      width: 40,
                      child: ProfileImagePicker(
                        previousImage: list.profilePicture,
                      ),
                    ),
                    title: Text(list.userName!),
                  );
                }),
              ),
            ),
          ),
      );
  }
}
