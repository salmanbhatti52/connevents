import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/comments-model.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:flutter/material.dart';

class ReportReplyPage extends StatefulWidget {
 final CommentReplies? commentReplies;

   ReportReplyPage({Key? key,this.commentReplies}) : super(key: key);

  @override
  _ReportReplyPageState createState() => _ReportReplyPageState();
}

class _ReportReplyPageState extends State<ReportReplyPage> {

  String? description;
  bool _value = false;
  int val = -1;
  List<String> list=[];

  List<Items> reportComments = [
    Items(reasons: "Nudity"),
    Items(reasons: "Violence"),
    Items(reasons: "Harassment"),
    Items(reasons: "Suicide or Self Injury"),
    Items(reasons: "False Information"),
    Items(reasons: "Spam"),
    Items(reasons: "Hate Speech"),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Row(
            children: [
              Icon(Icons.chevron_left),
              Text('Back', style: TextStyle(color: globalGreen, fontSize: 16, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        padding: EdgeInsets.all(padding * 2),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Reason', style: TextStyle(color: globalBlack, fontSize: 24, fontWeight: FontWeight.bold)),
                    SizedBox(height: padding),
                    Column(
                      children: reportComments.map((e) =>  CheckboxListTile(
                        selectedTileColor: Colors.green,
                        contentPadding: EdgeInsets.zero,
                        controlAffinity: ListTileControlAffinity.leading,
                        value: e.value,
                        activeColor: Colors.green,
                        title: Text(e.reasons!, style: TextStyle(color: globalBlack, fontSize: 14, fontWeight: FontWeight.normal)),
                        onChanged: (bool? val) {
                          setState(() {
                            e.value = val!;
                            if(list.contains(e.reasons))
                              list.remove(e.reasons!);
                            else
                              list.add(e.reasons!);

                            print(list);

                          });
                        },
                        // activeColor: Colors.red,
                      )).toList(),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: padding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Something else', style: TextStyle(color: globalBlack, fontSize: 14, fontWeight: FontWeight.normal,)),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: padding / 2),
                            child: TextFormField(
                              style: TextStyle(
                                color: globalBlack,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                              onChanged: (value)=> setState(() => description=value),
                              decoration: InputDecoration(
                                hintText: 'Briefly describe here...',
                                hintStyle: TextStyle(color: globalBlack.withOpacity(0.5), fontSize: 12, fontWeight: FontWeight.normal),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                    color: globalLGray,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                    color: globalLGray,
                                  ),
                                ),
                                isDense: true,
                              ),
                              minLines: 5,
                              maxLines: 5,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: globalGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () async{
                      print(widget.commentReplies?.eventCommentId);
                      openLoadingDialog(context, "loading");
                      try {
                        var response = await DioService.post('report_comment', {
                          "eventCommentId": widget.commentReplies!.eventCommentId,
                          "usersId": AppData().userdetail!.users_id,
                          "reportCategories": list,

                        });
                        if(response['status']=='success')
                          showSuccessToast(response['data']);
                        else
                          showErrorToast(showSuccessToast(response['message']));
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        print(response);
                      }
                      catch(e){
                        showErrorToast(e.toString());
                      }
                    },
                    child: Text('Report', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Items{

  String? reasons;
  bool   value;
  Items({this.value=false,this.reasons});
}
