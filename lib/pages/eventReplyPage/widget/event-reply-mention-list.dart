import 'package:connevents/models/mention-model.dart';
import 'package:connevents/widgets/profile-image-picker.dart';
import 'package:flutter/material.dart';

class EventReplyMentionList extends StatefulWidget {
   Function(bool)? isShown;
   Function(TextEditingController)? selectedMentionName;
   List<MentionCommentUserList> mentionCommentList;
   EventReplyMentionList({Key? key,this.mentionCommentList= const [],this.selectedMentionName,this.isShown}) : super(key: key);

  @override
  _EventReplyMentionListState createState() => _EventReplyMentionListState();
}

class _EventReplyMentionListState extends State<EventReplyMentionList> {
  String mentionNameSelected="";
  TextEditingController mentionName=TextEditingController();
  int? selectedId;
  bool isShown=false;



  @override
  Widget build(BuildContext context) {
    return Padding(
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
                        mentionNameSelected=list.userName!;
                        selectedId=list.usersId;
                        widget.selectedMentionName!(mentionName);
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
        );
  }
}
