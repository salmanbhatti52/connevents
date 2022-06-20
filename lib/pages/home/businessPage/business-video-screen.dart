import 'package:better_player/better_player.dart';
import 'package:connevents/mixins/data.dart';
import 'package:connevents/pages/tabs/tabsPage.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connevents/models/business-create-model.dart';


class BusinessShowVideo extends StatefulWidget {
  final Business? business;
 final String video;
 final String? thumbNail;
  const BusinessShowVideo({Key? key,required this.video,  this.business, this.thumbNail}) : super(key: key);

  @override
  _BusinessShowVideoState createState() => _BusinessShowVideoState();
}

class _BusinessShowVideoState extends State<BusinessShowVideo> {


  @override
  Widget build(BuildContext context) {
    List  video =widget.video.split('/');
   List thumbNail =widget.thumbNail!.split('/');
    print(widget.video);
    print(video.last);
 //   print(thumbNail.last);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          if(AppData().userdetail!.users_id==widget.business!.usersId)
            IconButton(onPressed: (){
            final action = CupertinoActionSheet(
           actions: <Widget>[
            CupertinoActionSheetAction(
            child: Text("Delete Video", style: TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.w500,),),
             isDefaultAction: true,
                onPressed: ()async{
                openLoadingDialog(context, "deleting");
                var response  = await DioService.post('created_business_delete_video',{
                "thumbnailName": thumbNail.last.toString(),
                "videoName": video.last.toString(),
                "businessId" : widget.business!.businessId.toString()
              });

                print(response);
               if(response['status']=='success'){
                 showSuccessToast(response['message']);
                 Navigator.of(context).pop();
             CustomNavigator.pushReplacement(context, TabsPage());
               }else{
                 showSuccessToast(response['message']);
                 Navigator.of(context).pop();
               }
        }
      ),
 // if(AppData().userdetail!.users_id != widget.business!.usersId)     CupertinoActionSheetAction(
 //        child: Text("Report Image",
 //          style: TextStyle(color: Colors.blue,
 //            fontSize: 18,
 //            fontWeight: FontWeight.w500,
 //          ),
 //        ),
 //        isDefaultAction: true,
 //        onPressed: (){}
 //      ),
    ],
  );
                    showCupertinoModalPopup(context: context, builder: (context) => action);
          }, icon: Icon(Icons.more_horiz))



        ],

      ),
      backgroundColor: Colors.black,
      body:widget.video.isNotEmpty ? BetterPlayer.network(

          widget.video,
          betterPlayerConfiguration: BetterPlayerConfiguration(

            aspectRatio: 1,
            looping: true,
            autoPlay: true,
            fit: BoxFit.contain,
          ),
      ): Center(
            child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Text("No Video Available",style: TextStyle(color: Colors.white,fontSize: 20),)),
          )

    );
  }
}


