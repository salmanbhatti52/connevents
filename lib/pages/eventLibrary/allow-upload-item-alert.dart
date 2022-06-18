import 'package:connevents/mixins/data.dart';
import 'package:connevents/services/dio-service.dart';
import 'package:connevents/utils/loading-dialog.dart';
import 'package:connevents/variables/globalVariables.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
 class AllowUploadItemAlert extends StatefulWidget {
   Function(bool isSuccess)? isSuccess;
 final  num? eventPostId;
  final String? fileType;
  final String? fileName;
  final String? thumbNail;
    AllowUploadItemAlert({Key? key,this.isSuccess,this.thumbNail,this.fileName,this.eventPostId,this.fileType}) : super(key: key);

   @override
   _AllowUploadItemAlertState createState() => _AllowUploadItemAlertState();
 }

 class _AllowUploadItemAlertState extends State<AllowUploadItemAlert> {


   Widget Buttons({text, color, void Function()? onTap}) {
     print(AppData().userdetail!.subscription_package_id);
     return RaisedButton(
       textColor: Colors.white,
       color: color,
       child: Padding(
         padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
         child: Text(
           text,
           style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
         ),
       ),
       onPressed: onTap,
       shape: new RoundedRectangleBorder(
         borderRadius: new BorderRadius.circular(30.0),
       ),
     );
   }


   @override
   Widget build(BuildContext context) {
     print(widget.fileType);
     Size size = MediaQuery.of(context).size;
     return Dialog(
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(20),
       ),
       // elevation: 3,
       backgroundColor: Colors.transparent,
       child: contentBox(context, size),
     );
   }


   contentBox(context, size) {
     return Container(
       height: 200,
       width: 300,
       decoration: BoxDecoration(
         color: Colors.white,
         borderRadius: BorderRadius.circular(20),
       ),
       child: Stack(
         children: [
           Column(
             children: [
               SizedBox(height: 60),
               Text("Are you sure you wants to", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 17)),
               Text("Upload?", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 17)),
               SizedBox(height: 20),
               Center(
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Buttons(text: "NO",color:  Colors.red,onTap: ()=>Navigator.of(context).pop()),
                     SizedBox(width: 10),
                     Buttons(text: "Yes",color:  globalGreen,onTap: ()async{
                       print(widget.fileType);
                       try{
                          openLoadingDialog(context, 'loading');
                       var imgRes = await DioService.post('upload_library_item', FormData.fromMap({
                          'fileType' : widget.fileType!,
if(widget.thumbNail!=null)  'thumbnail' :await MultipartFile.fromFile(widget.thumbNail!),
                          'item' : await MultipartFile.fromFile(widget.fileName!)
                       }));
                       print("Form Data");
                       print(imgRes);
                       print("Form Data");

                   var res  = await DioService.post('submit_library_item_details', {
                         "usersId" : AppData().userdetail!.users_id,
                         "eventPostId" : widget.eventPostId,
 if(imgRes['thumbnail']!=null)  'thumbnailName' : imgRes['thumbnail'],
                         "fileName" : imgRes['data'],
                         "fileType": widget.fileType!

                       });
                       Navigator.of(context).pop();
                       Navigator.of(context).pop();
                      // showSuccessToast(res['data']);
                       print(imgRes);
                       widget.isSuccess!(true);
                       }
                       catch (e){
                         Navigator.of(context).pop();
                         print(e.toString());
                       }

                     }),
                   ],
                 ),
               )
             ],
           ),
           Positioned(
             top: 10,
             right: 10,
             child: GestureDetector(
               onTap: () {
                 Navigator.pop(context);
               },
               child: Icon(
                 Icons.close,
                 size: 30,
                 color: globalGreen,
               ),
             ),
           ),
         ],
       ),
     );
   }

 }
