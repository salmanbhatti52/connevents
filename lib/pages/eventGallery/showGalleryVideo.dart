import 'package:better_player/better_player.dart';
import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/create-event-model.dart';
import 'package:connevents/models/my-event-library-items.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/widgets/profile-image-picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowGalleryVideoScreen extends StatefulWidget {
  final MyEventLibraryItems? eventLibraryItems;
  final EventDetail? event;
  final String video;
  final String? thumbNail;
  final int? eventLibraryItemId;
  final  int? userId;
  const ShowGalleryVideoScreen({Key? key,this.eventLibraryItems,this.userId,this.eventLibraryItemId,required this.video,  this.event, this.thumbNail}) : super(key: key);

  @override
  _ShowGalleryVideoScreenState createState() => _ShowGalleryVideoScreenState();
}

class _ShowGalleryVideoScreenState extends State<ShowGalleryVideoScreen> {



  @override
  Widget build(BuildContext context) {
    List  video =widget.video.split('/');
   // List thumbNail =widget.thumbNail!.split('/');
    print(widget.video);
    print(video.last);
 //   print(thumbNail.last);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
        if(AppData().userdetail!.users_id==widget.userId)
        IconButton(onPressed: (){
            final action = CupertinoActionSheet(
           actions: <Widget>[
             CupertinoActionSheetAction(
             child: Text("Delete Video", style: TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.w500,),),
             isDefaultAction: true,
             onPressed: ()async{
                openLoadingDialog(context, "deleting");
                var response  = await DioService.post('delete_library_item',{
               "eventLibraryItemId": widget.eventLibraryItemId,
              });
                print(response);
               if(response['status']=='success'){
              //   showSuccessToast(response['message']);
                 Navigator.of(context).pop(true);
                 Navigator.of(context).pop(true);
                 Navigator.of(context).pop(true);
              //   CustomNavigator.pushReplacement(context, TabsPage());
               }else{
                // showSuccessToast(response['message']);
                 Navigator.of(context).pop();
               }
        }
      ),

    ],
  );
            showCupertinoModalPopup(context: context, builder: (context) => action);
          }, icon: Icon(Icons.more_horiz))
        ],
      ),
      backgroundColor: Colors.black,
      body:widget.video.isNotEmpty ? Column(
        children: [
          BetterPlayer.network(
              widget.video,
              betterPlayerConfiguration: BetterPlayerConfiguration(
                aspectRatio: 1,
                looping: true,
                autoPlay: true,
                fit: BoxFit.contain,
              ),
          ),
          Container(
            width: double.infinity,
            color: Colors.grey,
            height: 60,
            child: Padding(
              padding: const EdgeInsets.only(left:12.0,right: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                       SizedBox(
                        width: 50, height: 50,
                        child:ProfileImagePicker(
                        onImagePicked: (value){
                        },
                        previousImage: widget.eventLibraryItems!.profilePicture)),
                        Padding(
                          padding: const EdgeInsets.only(left:12.0),
                          child: Text(widget.eventLibraryItems!.postUserName!),
                        ),
                    ],
                  ),
                   Row(
                    children: [
                      Text("${widget.eventLibraryItems!.totalLikesOnItem.toString()} Likes"),
                    ],
                  ),
                ],
              ),
            ),

          )
        ],
      ): Center(
            child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Text("No Video Available",style: TextStyle(color: Colors.white,fontSize: 20),)),
          )

    );
  }
}


