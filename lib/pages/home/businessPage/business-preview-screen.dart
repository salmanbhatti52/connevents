import 'package:better_player/better_player.dart';
import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/image-videos-model.dart';
import 'package:connevents/pages/home/home-header/videoplay-screen.dart';
import 'package:connevents/pages/tabs/tabsPage.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connevents/models/business-create-model.dart';


class BusinessPreviewScreen extends StatefulWidget {
  final Business? business;
  final List<ImageData> imageUrls;
  final ImageData imageData;
   BusinessPreviewScreen({Key? key,required this.imageData,required this.imageUrls,this.business}) : super(key: key);

  @override
  State<BusinessPreviewScreen> createState() => _BusinessPreviewScreenState();
}

class _BusinessPreviewScreenState extends State<BusinessPreviewScreen> {

  ImageData? data;
  late BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data=widget.imageData;
    _betterPlayerController = BetterPlayerController(
      const BetterPlayerConfiguration(
        autoDispose: true,
        aspectRatio: 0.5,
        looping: false,
        autoPlay: true,
      ),
    );
  }



  @override
  Widget build(BuildContext context) {

  //  List list =widget.image.split('/');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          if(AppData().userdetail!.users_id==widget.business!.usersId)
            IconButton(onPressed: (){
            final action = CupertinoActionSheet(
           actions: <Widget>[
            CupertinoActionSheetAction(
           child: Text("Delete Image", style: TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.w500,),),
             isDefaultAction: true,
             onPressed: ()async{
               List list=[];
               var response;
               openLoadingDialog(context, "deleting");
               if(data!.type=='image'){
                 list =data!.attachment.split('/');
                 response  = await DioService.post('created_business_delete_image',{
                   "fileName": list.last.toString(),
                   "businessId" : widget.business!.businessId.toString()
                 });
               }
               else{
               list =data!.media.split('/');
               List  thumbnail =data!.attachment.split('/');
               response  = await DioService.post('created_business_delete_video',{
                 "thumbnailName": thumbnail.last.toString(),
                 "videoName": list.last.toString(),
                 "businessId" : widget.business!.businessId.toString()
               });
               }

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
 // if(AppData().userdetail!.users_id != widget.eventDetail.usersId)  CupertinoActionSheetAction(
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
      body:widget.imageUrls.isNotEmpty? GestureDetector(
        child: Hero(
          tag: 'imageHero',
          child: Center(
            child: PageView.builder(
              onPageChanged: (index){
                data=widget.imageUrls[index];
                setState(() {});
              },
              controller: PageController(
                  initialPage: widget.imageUrls.indexOf(widget.imageData),
                  keepPage: true,
                  viewportFraction: 1,
              ),
              itemCount:widget.imageUrls.length,
              itemBuilder: (BuildContext context, int index){
                return widget.imageUrls[index].type=='image' ?
                Container(
                width: double.infinity,
                child: Image.network(widget.imageUrls[index].attachment,fit: BoxFit.cover)):
                VideoPlayScreen(url: widget.imageUrls[index].media);

                // Center(
                //   child: BetterPlayer.network(
                //     widget.imageUrls[index].media,
                //     betterPlayerConfiguration: BetterPlayerConfiguration(
                //       aspectRatio: 0.5,
                //       looping: true,
                //       autoPlay: true,
                //     ),
                //   ),
                // );
              },
            ),
          )
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ):Center(
            child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Text("No Image Available",style: TextStyle(color: Colors.white,fontSize: 20),)),
          )
    );
  }
}
