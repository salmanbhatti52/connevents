import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/peeks-comment-model.dart';
import 'package:connevents/pages/emojisPicker/emojis-picker.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:connevents/widgets/comment-textfield.dart';
import 'package:connevents/widgets/profile-image-picker.dart';
import 'package:flutter/material.dart';

class CommentSection extends StatefulWidget {
     Function(int comment)? comments;
     Function(bool isshown) isShown;
     final int? peekEventId;
    CommentSection({Key? key,this.comments,this.peekEventId,required this.isShown}) : super(key: key);

  @override
  _CommentSectionState createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  List<PeeksChat> peeksChat=[];
  int totalComments=0;
  bool isLoading=true;
  bool isEmojiShown=false;
   late FocusNode myFocusNode;

  TextEditingController message=TextEditingController();


  Future getAllComments() async {
      try{
         var response = await DioService.post('get_user_peek_comments', {
                "eventPeekId": widget.peekEventId,
                "usersId": AppData().userdetail!.users_id
      });
         if(response['status']=='success'){
           var jsonList = response['data'] as List;
          totalComments=response['total_comments'];
          widget.comments!(totalComments);
          peeksChat = jsonList.map<PeeksChat>((e) => PeeksChat.fromJson(e)).toList();
          isLoading=false;

          print(peeksChat.toList());
          setState(() {});
         }else{
           isLoading=false;
           totalComments=response['total_comments'];
           setState(() {});
         }

      }
      catch(e){
        print("shahzaib");
      }
}

  Future sendMessage() async {
    print(message.text.toString());
      if(message.text.isEmpty) return showErrorToast("Please Write Some Comment");
      openLoadingDialog(context, 'sending');
      var response;

        try{
          response   = await  DioService.post("comment_on_peek", {
            "eventPeekId": widget.peekEventId,
            "usersId": AppData().userdetail!.users_id,
            "comment": message.text.toString(),
          });
          FocusManager.instance.primaryFocus!.unfocus();
          message.clear();
          setState(() {});
        }
        catch(e){
          showErrorToast(e.toString());
        }
      await  getAllComments();
      Navigator.of(context).pop();
      print(response);

    }


 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllComments();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myFocusNode.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
          height: MediaQuery.of(context).size.height/2,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.only(top:16.0,left: 8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(),
                              Text("$totalComments comments",style: TextStyle(color:Colors.black,fontSize: 16)),
                              IconButton(onPressed: (){
                                widget.isShown(false);
                                setState(() {});
                              }, icon: Icon(Icons.close))
                            ],
                          ),
                          isLoading ?  Center(child: CircularProgressIndicator()) :peeksChat.isNotEmpty ?
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                             itemCount: peeksChat.length,
                             itemBuilder: (context,index){
                             PeeksChat commentData= peeksChat[index];
                             print(commentData.commentTimeAgo);//  replyToCommentId=commentData.eventCommentId;
                               return Column(
                                 children: [
                                   Padding(
                                     padding:  EdgeInsets.symmetric(horizontal: padding),
                                     child: Divider(color: globalLGray),
                                   ),
                                   Padding(
                                     padding: const EdgeInsets.symmetric(horizontal: padding),
                                     child: Container(
                                       child: Row(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           SizedBox(
                                             width: 40,
                                             height: 40,
                                             child: ProfileImagePicker(
                                               onImagePicked: (value){},
                                               previousImage: commentData.profilePicture,
                                             ),
                                           ),
                                         SizedBox(width: padding),
                                         Expanded(
                                           child: Column(
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: [
                                               Row(
                                                 mainAxisAlignment:
                                                 MainAxisAlignment.spaceBetween,
                                                 children: [
                                                   Text(commentData.userName, style: TextStyle(color: globalBlack, fontSize: 18, fontWeight: FontWeight.w600)),
                                                 ],
                                               ),
                                               Wrap(
                                                 children: [
                                                   Padding(
                                                     padding: const EdgeInsets.only(left:4.0),
                                                     child: Text(commentData.comment, style: TextStyle(color: globalBlack, fontSize: 14)),
                                                   ),
                                                 ],
                                               ),
                                               Row(
                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                 children: [
                                                   TextButton(
                                                     onPressed: () {},
                                                     child: Text(commentData.commentTimeAgo, style: TextStyle(color: globalBlack.withOpacity(0.7), fontSize: 10,),
                                                     ),
                                                   ),
                                                 ],
                                               ),
                                             ],
                                           ),
                                         ),
                                                 ],
                                               ),
                                             )),
                                          //  EventCommentReplyList(event: widget.event,commentData:commentData)
                                         ],
                                       );
                                     }) : SizedBox() ,

                        ],
                      ),
                    ),
                  ),
                ),
                EventCommentTextField(
                    onTapEmoji: (){
                    FocusScopeNode currentFocus = FocusScope.of(context);
                     if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                      isEmojiShown=!isEmojiShown;
                      setState(() {});
                    },
                    onTap: (){
                      FocusScopeNode currentFocus = FocusScope.of(context);
                     if (!currentFocus.hasPrimaryFocus) {
                       currentFocus.unfocus();
                    }
                     if(isEmojiShown)
                      isEmojiShown=false;
                      setState(() {});
                    },
                    controller: message,
                    onTapIcon: () => sendMessage(),
                    focusNode: myFocusNode,
                  ),
                if(isEmojiShown)
                EmojisPickerPage(
                  emoji: (val){
                    message.text = message.text + val  ;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
    );
  }
}
