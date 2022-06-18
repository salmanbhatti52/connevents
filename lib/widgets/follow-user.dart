import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/create-event-model.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:flutter/material.dart';

class FollowUser extends StatefulWidget {
  final EventDetail? event;
    bool isFollow;
    int? userId;
   FollowUser({Key? key,this.event,this.isFollow=false,this.userId}) : super(key: key);

  @override
  _FollowUserState createState() => _FollowUserState();
}

class _FollowUserState extends State<FollowUser> {
String totalFollowers="";

    void followUser() async{
       openLoadingDialog(context, 'loading');
      try {
      var   response = await DioService.post('follow_user', {
             "usersId" : AppData().userdetail!.users_id,
             "followingToUser" :widget.userId,
            //  "eventPostId": widget.event!.eventPostId
        });
                widget.isFollow = response['is_following'];
                totalFollowers = response['total_followers'];
                setState(() {});
               Navigator.of(context).pop();
      }
      catch(e){
        Navigator.of(context).pop();
      }
    }

    Future followersCount() async {
      var  response;
      try{
         response = await DioService.post('get_followers_count', {
           "usersId" : widget.userId
        });
         totalFollowers = response['data'];
         setState(() {});
         print(response);
     }
      catch (e){
       // showErrorToast(response['message']);
      }


     }


   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    followersCount();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
         text: TextSpan(
           style: TextStyle(color: globalGreen,fontWeight: FontWeight.bold),
           text:  totalFollowers,
           children: [
             TextSpan(
               style: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal),
               text: " Follower"
             )
           ]

         )),
        if(AppData().userdetail!.users_id != widget.userId)
        Container(
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(12.0),
               ),
              child: ElevatedButton(
                     style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        )
                      )
                    ),
                    onPressed: () {
                     followUser();
                    },
                    child: Text( widget.isFollow ? "Following" : "Follow")),
            ),
      ],
    );
  }
}
