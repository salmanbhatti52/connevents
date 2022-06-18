import 'package:connevents/mixins/data.dart';
import 'package:connevents/models/create-event-model.dart';
import 'package:connevents/models/my-event-library-items.dart';
import 'package:connevents/pages/tabs/tabsPage.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/widgets/custom-navigator.dart';
import 'package:connevents/widgets/profile-image-picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowGalleryImageScreen extends StatefulWidget {
  final EventDetail? eventDetail;
  final String image;
  final MyEventLibraryItems? eventLibraryItems;
  final int? eventLibraryItemId;
  final  int? userId;
  const ShowGalleryImageScreen({Key? key,this.eventLibraryItems,this.userId,this.eventLibraryItemId,required this.image, this.eventDetail}) : super(key: key);

  @override
  State<ShowGalleryImageScreen> createState() => _ShowGalleryImageScreenState();
}

class _ShowGalleryImageScreenState extends State<ShowGalleryImageScreen> {
  @override
  Widget build(BuildContext context) {
    print(widget.eventLibraryItems!.profilePicture);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
                actions: [
     if(AppData().userdetail!.users_id==widget.userId)       IconButton(onPressed: (){
            final action = CupertinoActionSheet(
           actions: <Widget>[
   CupertinoActionSheetAction(
           child: Text("Delete Image", style: TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.w500,),),
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
               //  CustomNavigator.pushReplacement(context, TabsPage());
               }else{
               //  showSuccessToast(response['message']);
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
      body:widget.image.isNotEmpty? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            child: Hero(
              tag: 'imageHero',
              child: Center(
                child: Container(
                    width: double.infinity,
                    child: Image.network(widget.image,fit: BoxFit.cover)),
              )
            ),
            onTap: () {
              Navigator.pop(context);
            },
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
      ):Center(
            child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Text("No Image Available",style: TextStyle(color: Colors.white,fontSize: 20),)),
          )
    );
  }
}
